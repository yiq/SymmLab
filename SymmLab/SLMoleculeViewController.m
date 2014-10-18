//
//  SLMoleculeViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLMoleculeViewController.h"
#import "SLModelMolecule.h"
#import "SLMolecule.h"
#import "SLModelLine.h"
#import "SLModelPlane.h"

#import "SLIdentitySymmetryOperation.h"
#import "SLInversionSymmetryOperation.h"
#import "SLProperAxisSymmetryOperation.h"
#import "SLPlaneSymmetryOperation.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

// Uniform index.
enum
{
    UNIFORM_MODELVIEWPROJECTION_MATRIX,
    UNIFORM_NORMAL_MATRIX,
    UNIFORM_USE_LIGHTING,
    UNIFORM_ALPHA_ADJUST,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum
{
    ATTRIB_VERTEX,
    ATTRIB_NORMAL,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
};

@interface SLMoleculeViewController() {
    GLuint _program;
    
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKMatrix4 _worldViewProjectionMatrix;
    GLKMatrix3 _normalMatrix;
    BOOL _isAnimating;
    
    GLuint _vertexArray;
    GLuint _vertexBuffer;
    
    SLMolecule *molecule;
    SLModelMolecule *moleculeModel;
    
    SLModelLine *axis;
    //SLAbstractSymmetryOperation *symmOp;
    
    CGFloat _cameraTheta;
    CGFloat _cameraPhi;
    
    CGFloat _cameraThetaDelta;
    CGFloat _cameraPhiDelta;
    
    CGFloat _cameraDistance;
    CGFloat _cameraUpY;
}

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

@end

@implementation SLMoleculeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    _animationProgress = 0.0f;
    _isAnimating = NO;
    _visualClue = nil;
    
    _cameraPhi = 0.0f; _cameraPhiDelta = 0.0f;
    _cameraTheta = 0.0f; _cameraThetaDelta = 0.0f;
    _cameraDistance = 10.0f;
    _cameraUpY = 1.0f;
    
//    molecule = [SLMolecule moleculeWithCifFile:[[NSBundle mainBundle] pathForResource:@"benzene" ofType:@"cif"]];
    molecule = [SLMolecule moleculeWithXyzFile:[[NSBundle mainBundle] pathForResource:@"1,3,5,7-tetrafluorocyclooctatetraene" ofType:@"xyz"]];

    //symmOp = [[SLPlaneSymmetryOperation alloc] initWithNormalAngleTheta: - M_PI_2 / 3.0f phi:0.0f];
    self.symmOperation = [[SLIdentitySymmetryOperation alloc] init];
    
    [self setupGL];
}

- (void)dealloc
{
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
    
    // Dispose of any resources that can be recreated.
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    [self loadShaders];
    
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    moleculeModel = [[SLModelMolecule alloc] initWithMolecule:molecule];
    GLKVector3 axisPointPos[8] = {
        GLKVector3Make(-100.0f, 0.0f, 0.0f),
        GLKVector3Make(100.0f, 0.0f, 0.0f),
        GLKVector3Make(0.0, -100.0f, 0.0f),
        GLKVector3Make(0.0, 100.0f, 0.0f),
        GLKVector3Make(0.0, 0.0f, -100.0f),
        GLKVector3Make(0.0, 0.0f, 100.0f),
        GLKVector3Make(-50.0f * cosf(M_PI/6), -50.0f*sinf(M_PI/6), 0.0f),
        GLKVector3Make(50.0f * cosf(M_PI/6), 50.0f*sinf(M_PI/6), 0.0f),
    };
    
    SLColor axisColors[8] = {
        {1.0f, 0.0f, 0.0f, 1.0f}, {1.0f, 0.0f, 0.0f, 1.0f},
        {0.0f, 1.0f, 0.0f, 1.0f}, {0.0f, 1.0f, 0.0f, 1.0f},
        {0.0f, 0.0f, 1.0f, 1.0f}, {0.0f, 0.0f, 1.0f, 1.0f}
    };
    
    axis = [[SLModelLine alloc] initWithPoints:axisPointPos colors:axisColors count:6];
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];

    moleculeModel = nil;
    
    self.effect = nil;
    
    if (_program) {
        glDeleteProgram(_program);
        _program = 0;
    }
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
    
    if (_cameraPhi > M_PI * 2) _cameraPhi -= M_PI * 2;
    if (_cameraPhi < - (M_PI * 2)) _cameraPhi += M_PI * 2;
    if (_cameraTheta > M_PI * 2) _cameraTheta -= M_PI * 2;
    if (_cameraTheta < - (M_PI * 2)) _cameraTheta += M_PI * 2;
        
    CGFloat cameraX = cosf(_cameraPhi + _cameraPhiDelta) * sinf(_cameraTheta + _cameraThetaDelta) * _cameraDistance;
    CGFloat cameraY = sinf(_cameraPhi + _cameraPhiDelta) * _cameraDistance;
    CGFloat cameraZ = cosf(_cameraPhi + _cameraPhiDelta) * cosf(_cameraTheta + _cameraThetaDelta) * _cameraDistance;
    
    _cameraUpY = 1.0f;
    
    if (fabs(_cameraPhi + _cameraPhiDelta) > M_PI_2) {
        _cameraUpY = -1.0f;
    }

    GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(cameraX, cameraY, cameraZ, 0.0f, 0.0f, 0.0f, 0.0f, _cameraUpY, 0.0f);
    
    //GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    
    GLKMatrix4 modelMatrix = [self.symmOperation modelMatrixWithAnimationProgress:_animationProgress];

    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(viewMatrix, modelMatrix);
    
    _normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    
    _modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
    _worldViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, viewMatrix);
    
    //_rotation += self.timeSinceLastUpdate * 0.5f;
    if (_isAnimating) {
        if (self.animationProgress + self.timeSinceLastUpdate > 1.0f) {
            self.animationProgress = 1.0f;
            _isAnimating = NO;
        }
        else {
            self.animationProgress += self.timeSinceLastUpdate;
        }
        NSLog(@"animation progress updated to %f", _animationProgress);
    }
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    //glClearColor(0.35f, 0.35f, 0.35f, 1.0f);
    glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // Render the object again with ES2
    glUseProgram(_program);
    
    glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, _worldViewProjectionMatrix.m);
    glUniformMatrix3fv(uniforms[UNIFORM_NORMAL_MATRIX], 1, 0, _normalMatrix.m);
    glUniform1i(uniforms[UNIFORM_USE_LIGHTING], 0);
    glUniform1f(uniforms[UNIFORM_ALPHA_ADJUST], 1.0);
    [axis render];

    // Render the molecule in transform
    glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, _modelViewProjectionMatrix.m);
    glUniform1i(uniforms[UNIFORM_USE_LIGHTING], 1);

    [moleculeModel render];
    
    glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, _worldViewProjectionMatrix.m);
    glUniform1f(uniforms[UNIFORM_ALPHA_ADJUST], 0.5);

    // Render ghost
    if (self.animationProgress > 0.0f) {
        glUniformMatrix3fv(uniforms[UNIFORM_NORMAL_MATRIX], 1, 0, GLKMatrix3Identity.m);
        [moleculeModel render];
    }
    
    glUniform1f(uniforms[UNIFORM_ALPHA_ADJUST], 0.3);
    if (self.visualClue) {
        GLKMatrix4 mvpMatrix = GLKMatrix4Multiply(_worldViewProjectionMatrix, self.visualClueMatrix);
        glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, mvpMatrix.m);
        glUniform1i(uniforms[UNIFORM_USE_LIGHTING], 0);

        [self.visualClue render];
    }
}

- (void)startOpAnimation
{
    if (self.animationProgress >= 1.0f) {
        self.animationProgress = 0.0f;
    }
    _isAnimating = YES;
}

- (void)pauseOpAnimation {
    _isAnimating = NO;
}

- (void)resetOpAnimation {
    _isAnimating = NO;
    self.animationProgress = 0.0f;
}


- (IBAction)panGestureHandler:(UIPanGestureRecognizer *)sender {
    CGPoint translate = [sender translationInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateEnded) {
        _cameraPhi = _cameraPhi + _cameraPhiDelta;
        _cameraPhiDelta = 0;
        _cameraTheta = _cameraTheta + _cameraThetaDelta;
        _cameraThetaDelta = 0;
    }
    else {
        _cameraThetaDelta = - (translate.x / 100.0) * M_PI_2;
        _cameraPhiDelta = (translate.y / 100.0) * M_PI_2;
    }
}

#pragma mark -  OpenGL ES 2 shader compilation

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    _program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    NSLog(@"loading vertex shader %@", vertShaderPathname);

    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    NSLog(@"loading fragment shader %@", fragShaderPathname);
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    // Attach vertex shader to program.
    glAttachShader(_program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(_program, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(_program, GLKVertexAttribPosition, "position");
    glBindAttribLocation(_program, GLKVertexAttribNormal, "normal");
    glBindAttribLocation(_program, GLKVertexAttribColor, "diffuseColor");
    
    // Link program.
    if (![self linkProgram:_program]) {
        NSLog(@"Failed to link program: %d", _program);
        
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (_program) {
            glDeleteProgram(_program);
            _program = 0;
        }
        
        return NO;
    }
    
    // Get uniform locations.
    uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX] = glGetUniformLocation(_program, "modelViewProjectionMatrix");
    uniforms[UNIFORM_NORMAL_MATRIX] = glGetUniformLocation(_program, "normalMatrix");
    uniforms[UNIFORM_USE_LIGHTING] = glGetUniformLocation(_program, "useLighting");
    uniforms[UNIFORM_ALPHA_ADJUST] = glGetUniformLocation(_program, "alphaAdjust");
    
    // Release vertex and fragment shaders.
    if (vertShader) {
        glDetachShader(_program, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader) {
        glDetachShader(_program, fragShader);
        glDeleteShader(fragShader);
    }
    
    return YES;
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}


@end
