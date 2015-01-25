//
//  SLModelLine.m
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLModelLine.h"

@interface SLModelLine() {
    GLfloat origLineWidth;
}

@property BOOL isLineWidthCustomized;
@property GLfloat customLineWidth;

@end

@implementation SLModelLine

- (id) initWithPoints:(GLKVector3 *)points colors:(SLColor *)colors count:(GLuint)count
{
    self = [super init];
    if (self) {
        _glDrawMode = GL_LINES;
        _isRenderable = YES;
        _indexCount = count;
        _vertexCount = count;
        
        _points = (SLModelPoint *)malloc(sizeof(SLModelPoint) * _vertexCount);

        for (NSUInteger idx = 0; idx < count; idx++) {
            _points[idx].position = points[idx];
            _points[idx].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
            _points[idx].color = colors[idx];
        }
        
        _indices = (GLuint *)malloc(sizeof(GLuint) * _indexCount);
        for (GLuint i=0; i<count; i++) {
            _indices[i] = i;
        }
        self.isLineWidthCustomized = NO;
    }
    
    return self;
}

- (id) initWithPoints:(GLKVector3 *)points colors:(SLColor *)colors count:(GLuint)count lineWidth:(GLfloat)width {
    self = [self initWithPoints:points colors:colors count:count];
    if (self) {
        self.isLineWidthCustomized = YES;
        self.customLineWidth = width;
    }
    
    return self;
}

- (void) configStates {
    if (self.isLineWidthCustomized) {
        glGetFloatv(GL_LINE_WIDTH, &origLineWidth);
        glLineWidth(self.customLineWidth);
    }
}

- (void) restoreStates {
    if (self.isLineWidthCustomized) {
        glLineWidth(origLineWidth);
    }
}

@end
