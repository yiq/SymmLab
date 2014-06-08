//
//  SLModelPlane.m
//  SymmLab
//
//  Created by Yi Qiao on 6/8/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLModelPlane.h"

@implementation SLModelPlane

- (instancetype)init {
    self = [super init];
    if (self) {
        _glDrawMode = GL_TRIANGLE_STRIP;
        _isRenderable = YES;
        _indexCount = 4;
        _vertexCount = 4;
        
        _points = (SLModelPoint *)malloc(sizeof(SLModelPoint) * _vertexCount);
        _indices = (GLuint *)malloc(sizeof(GLuint) * _indexCount);
        
        _points[0].position = GLKVector3Make(-0.5f, 0.5f, 0.0f); _points[0].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        _points[1].position = GLKVector3Make( 0.5f, 0.5f, 0.0f); _points[1].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        _points[2].position = GLKVector3Make(-0.5f, -0.5f, 0.0f); _points[2].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        _points[3].position = GLKVector3Make( 0.5f, -0.5f, 0.0f); _points[3].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        
        
        SLColor yellowColor = {1.0f, 1.0f, 0.0f, 0.3f};
        
        for(GLuint i=0; i<_vertexCount; i++) {
            _points[i].color = yellowColor;
            _indices[i] = i;
        }
    }
    
    return self;
}

@end
