//
//  SLAbstractModel.m
//  SymmLab
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLAbstractModel.h"

@interface SLAbstractModel() {
    BOOL isVBOPrepared;
}

- (void)prepareVBOs;

@end

@implementation SLAbstractModel

- (id) init {
    self = [super init];
    if (self) {
        isVBOPrepared = NO;
        _points = NULL;
        _indices = NULL;
        glGenVertexArraysOES(1, &_vertexArray);
        glGenBuffers(2, _glBuffers);
    }
    
    return self;
}

- (void)dealloc
{
    glDeleteBuffers(2, _glBuffers);
    glDeleteVertexArraysOES(1, &_vertexArray);
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
    glVertexAttribPointer(GLKVertexAttribColor, 3, GL_FLOAT, GL_FALSE, sizeof(SLModelPoint), BUFFER_OFFSET(sizeof(GLKVector3)*2));
    
    glBindVertexArrayOES(0);
    
    if (_points) {
        free(_points);
        _points = NULL;
    }

    if (_indices) {
        free(_indices);
        _indices = NULL;
    }
    isVBOPrepared = YES;
}

- (void)render {
    
    if (!isVBOPrepared) {
        [self prepareVBOs];
    }
    
    glBindVertexArrayOES(_vertexArray);
    glDrawElements(_glDrawMode, _indexCount, GL_UNSIGNED_INT, 0);
    glBindVertexArrayOES(0);
}

@end
