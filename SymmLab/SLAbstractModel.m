//
//  SLAbstractModel.m
//  SymmLab
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLAbstractModel.h"
@import OpenGLES;

@interface SLAbstractModel() {
    BOOL isVBOPrepared;
    NSMutableSet *_children;
}

- (void)prepareVBOs;

@end

@implementation SLAbstractModel

- (id) init {
    self = [super init];
    if (self) {
        isVBOPrepared = NO;
        _isRenderable = NO;
        _points = NULL;
        _indices = NULL;
        glGenVertexArraysOES(1, &_vertexArray);
        assert(_vertexArray != 0);
        glGenBuffers(2, _glBuffers);
        assert(_glBuffers[0] != 0);
        assert(_glBuffers[1] != 0);
        _children = [[NSMutableSet alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    if (_points) {
        free(_points);
        _points = NULL;
    }
    
    if (_indices) {
        free(_indices);
        _indices = NULL;
    }
    glDeleteBuffers(2, _glBuffers);
    glDeleteVertexArraysOES(1, &_vertexArray);
}

- (void)translateByX:(GLfloat)dx byY:(GLfloat)dy byZ:(GLfloat)dz
{
    GLKVector3 dv = GLKVector3Make(dx, dy, dz);
    
    for(int i=0; i<_vertexCount; i++) {
        _points[i].position = GLKVector3Add(_points[i].position, dv);
    }
    
    isVBOPrepared = NO;
}

- (void)setColorWithR:(GLfloat)r g:(GLfloat)g b:(GLfloat)b alpha:(GLfloat)a
{
    SLColor newColor = {r, g, b, a};
    for(int i=0; i<_vertexCount; i++) {
        _points[i].color = newColor;
    }
    
    isVBOPrepared = NO;
}

- (void)prepareVBOs
{
    glBindVertexArrayOES(_vertexArray);
    
    glBindBuffer(GL_ARRAY_BUFFER, _glBuffers[0]);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _glBuffers[1]);
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(SLModelPoint) * _vertexCount, _points, GL_STATIC_DRAW);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLuint) * _indexCount, _indices, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SLModelPoint), BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(SLModelPoint), BUFFER_OFFSET(sizeof(GLKVector3)));
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SLModelPoint), BUFFER_OFFSET(sizeof(GLKVector3) * 2));
    
    glBindVertexArrayOES(0);
    

    isVBOPrepared = YES;
}

- (void) configStates {
    // empty implementation
}

- (void) restoreStates {
    // empty implementation
}

- (void)render {
    
    if (_isRenderable) {
        if (!isVBOPrepared) {
            [self prepareVBOs];
        }
        
        [self configStates];
        
        glBindVertexArrayOES(_vertexArray);
        glDrawElements(_glDrawMode, _indexCount, GL_UNSIGNED_INT, 0);
        glBindVertexArrayOES(0);
        
        [self restoreStates];
    }

    for (SLAbstractModel *child in _children) {
        [child render];
    }
}

- (void)addChild:(SLAbstractModel *)child {
    if (child == self) {
        return;
    }
    
    [_children addObject:child];
}


@end
