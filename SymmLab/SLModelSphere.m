//
//  SLModelSphere.m
//  SymmLab
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLModelSphere.h"

@implementation SLModelSphere

- (id)init {
    return [self initWithLongs:24 lats:24];
}

- (id)initWithLongs:(int)longs lats:(int)lats {
    
    self = [super init];
    if (self) {
        _glDrawMode = GL_TRIANGLES;
        _vertexCount = (lats + 1) * (longs + 1);
        _indexCount = lats * longs * 6;
        
        _points = (SLModelPoint *)malloc(sizeof(SLModelPoint) * _vertexCount);
        _indices = (GLuint *)malloc(sizeof(GLuint) * _indexCount);

        NSUInteger p_idx = 0;

        for (int latNumber = 0; latNumber <= lats; ++latNumber) {
            for (int longNumber = 0; longNumber <= longs; ++longNumber) {
                float theta = latNumber * M_PI / lats;
                float phi = longNumber * 2 * M_PI / longs;
                
                float sinTheta = sin(theta);
                float sinPhi = sin(phi);
                float cosTheta = cos(theta);
                float cosPhi = cos(phi);
                                
                float x = cosPhi * sinTheta;
                float y = cosTheta;
                float z = sinPhi * sinTheta;
                
                _points[p_idx].position = GLKVector3Make(x, y, z);
                _points[p_idx++].normal = GLKVector3Make(x, y, z);
            }
        }
        
        assert(p_idx == _vertexCount);
        
        NSUInteger i_idx = 0;
        
        for (int latNumber = 0; latNumber < lats; latNumber++) {
            for (int longNumber = 0; longNumber < longs; longNumber++) {
                
                int first = (latNumber * (longs + 1)) + longNumber;
                int second = first + (longs + 1);
                int third = first + 1;
                int fourth = second + 1;
                
                _indices[i_idx++] = first;
                _indices[i_idx++] = third;
                _indices[i_idx++] = second;
                
                _indices[i_idx++] = second;
                _indices[i_idx++] = third;
                _indices[i_idx++] = fourth;
            }
        }
    
        assert(i_idx == _indexCount);
    }
    
    return self;
}


@end
