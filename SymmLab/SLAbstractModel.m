//
//  SLAbstractModel.m
//  SymmLab
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLAbstractModel.h"

@implementation SLAbstractModel

- (id) init {
    self = [super init];
    if (self) {
        glGenVertexArraysOES(1, &_vertexArray);
        glGenBuffers(1, &_vertexBuffer);
        
        glBindVertexArrayOES(_vertexArray);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexArray);
        glEnableVertexAttribArray(GLKVertexAttribPosition);
        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SLModelPoint), BUFFER_OFFSET(0));
        glEnableVertexAttribArray(GLKVertexAttribNormal);
        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(SLModelPoint), BUFFER_OFFSET(sizeof(GLKVector3)));
        glBindVertexArrayOES(0);
    }
    
    return self;
}

- (void)dealloc
{
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteVertexArraysOES(1, &_vertexArray);
}

- (void)render {
    glBindVertexArrayOES(_vertexArray);
    glDrawArrays(GL_TRIANGLES, 0, 36);
    glBindVertexArrayOES(0);
}

@end
