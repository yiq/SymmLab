//
//  SLModelCube.m
//  SymmLab
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLModelCube.h"

@implementation SLModelCube

- (id) init
{
    self = [super init];
    if (self) {
        _glDrawMode = GL_TRIANGLES;
        _indexCount = 36;
        _vertexCount = 36;
        
        _points = (SLModelPoint *)malloc(sizeof(SLModelPoint) * _vertexCount);
        
        _points[0].position = GLKVector3Make(0.5f, -0.5f, -0.5f); _points[0].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        _points[1].position = GLKVector3Make(0.5f, 0.5f, -0.5f);  _points[1].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        _points[2].position = GLKVector3Make(0.5f, -0.5f, 0.5f);  _points[2].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        _points[3].position = GLKVector3Make(0.5f, -0.5f, 0.5f);  _points[3].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        _points[4].position = GLKVector3Make(0.5f, 0.5f, -0.5f);  _points[4].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        _points[5].position = GLKVector3Make(0.5f, 0.5f, 0.5f);   _points[5].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        
		_points[6].position = GLKVector3Make(0.5f, 0.5f, -0.5f);  _points[6].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        _points[7].position = GLKVector3Make(-0.5f, 0.5f, -0.5f); _points[7].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        _points[8].position = GLKVector3Make(0.5f, 0.5f, 0.5f);   _points[8].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        _points[9].position = GLKVector3Make(0.5f, 0.5f, 0.5f);   _points[9].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        _points[10].position = GLKVector3Make(-0.5f, 0.5f, -0.5f); _points[10].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        _points[11].position = GLKVector3Make(-0.5f, 0.5f, 0.5f);  _points[11].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        
		_points[12].position = GLKVector3Make(-0.5f, 0.5f, -0.5f); _points[12].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        _points[13].position = GLKVector3Make(-0.5f, -0.5f, -0.5f);_points[13].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        _points[14].position = GLKVector3Make(-0.5f, 0.5f, 0.5f);  _points[14].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        _points[15].position = GLKVector3Make(-0.5f, 0.5f, 0.5f);  _points[15].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        _points[16].position = GLKVector3Make(-0.5f, -0.5f, -0.5f);_points[16].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        _points[17].position = GLKVector3Make(-0.5f, -0.5f, 0.5f); _points[17].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        
		_points[18].position = GLKVector3Make(-0.5f, -0.5f, -0.5f);_points[18].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        _points[19].position = GLKVector3Make(0.5f, -0.5f, -0.5f); _points[19].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        _points[20].position = GLKVector3Make(-0.5f, -0.5f, 0.5f); _points[20].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        _points[21].position = GLKVector3Make(-0.5f, -0.5f, 0.5f); _points[21].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        _points[22].position = GLKVector3Make(0.5f, -0.5f, -0.5f); _points[22].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        _points[23].position = GLKVector3Make(0.5f, -0.5f, 0.5f);  _points[23].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        
		_points[24].position = GLKVector3Make(0.5f, 0.5f, 0.5f);   _points[24].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        _points[25].position = GLKVector3Make(-0.5f, 0.5f, 0.5f);  _points[25].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        _points[26].position = GLKVector3Make(0.5f, -0.5f, 0.5f);  _points[26].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        _points[27].position = GLKVector3Make(0.5f, -0.5f, 0.5f);  _points[27].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        _points[28].position = GLKVector3Make(-0.5f, 0.5f, 0.5f);  _points[28].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        _points[29].position = GLKVector3Make(-0.5f, -0.5f, 0.5f); _points[29].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        
		_points[30].position = GLKVector3Make(0.5f, -0.5f, -0.5f); _points[30].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        _points[31].position = GLKVector3Make(-0.5f, -0.5f, -0.5f);_points[31].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        _points[32].position = GLKVector3Make(0.5f, 0.5f, -0.5f);  _points[32].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        _points[33].position = GLKVector3Make(0.5f, 0.5f, -0.5f);  _points[33].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        _points[34].position = GLKVector3Make(-0.5f, -0.5f, -0.5f);_points[34].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        _points[35].position = GLKVector3Make(-0.5f, 0.5f, -0.5f); _points[35].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        
        _indices = (GLuint *)malloc(sizeof(GLuint)*_indexCount);
        for (GLuint i=0; i<_indexCount; i++) _indices[i] = i;
    }
    
    return self;
}

@end
