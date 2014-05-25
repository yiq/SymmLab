//
//  SLModelCube.m
//  SymmLab
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLModelCube.h"

@interface SLModelCube () {

    
    SLModelPoint * points;
    GLuint indices;
}

@end

@implementation SLModelCube

- (id) init
{
    self = [super init];
    if (self) {
        _glDrawMode = GL_TRIANGLE_STRIP;
        _elementCount = 36;
        
        points = (SLModelPoint *)malloc(sizeof(SLModelPoint) * _elementCount);
        
        points[0].position = GLKVector3Make(0.5f, -0.5f, -0.5f); points[0].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        points[1].position = GLKVector3Make(0.5f, 0.5f, -0.5f);  points[1].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        points[2].position = GLKVector3Make(0.5f, -0.5f, 0.5f);  points[2].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        points[3].position = GLKVector3Make(0.5f, -0.5f, 0.5f);  points[3].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        points[4].position = GLKVector3Make(0.5f, 0.5f, -0.5f);  points[4].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        points[5].position = GLKVector3Make(0.5f, 0.5f, 0.5f);   points[5].normal = GLKVector3Make(1.0f, 0.0f, 0.0f);
        
		points[6].position = GLKVector3Make(0.5f, 0.5f, -0.5f);  points[6].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        points[7].position = GLKVector3Make(-0.5f, 0.5f, -0.5f); points[7].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        points[8].position = GLKVector3Make(0.5f, 0.5f, 0.5f);   points[8].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        points[9].position = GLKVector3Make(0.5f, 0.5f, 0.5f);   points[9].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        points[10].position = GLKVector3Make(-0.5f, 0.5f, -0.5f); points[10].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        points[11].position = GLKVector3Make(-0.5f, 0.5f, 0.5f);  points[11].normal = GLKVector3Make(0.0f, 1.0f, 0.0f);
        
		points[12].position = GLKVector3Make(-0.5f, 0.5f, -0.5f); points[12].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        points[13].position = GLKVector3Make(-0.5f, -0.5f, -0.5f);points[13].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        points[14].position = GLKVector3Make(-0.5f, 0.5f, 0.5f);  points[14].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        points[15].position = GLKVector3Make(-0.5f, 0.5f, 0.5f);  points[15].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        points[16].position = GLKVector3Make(-0.5f, -0.5f, -0.5f);points[16].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        points[17].position = GLKVector3Make(-0.5f, -0.5f, 0.5f); points[17].normal = GLKVector3Make(-1.0f, 0.0f, 0.0f);
        
		points[18].position = GLKVector3Make(-0.5f, -0.5f, -0.5f);points[18].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        points[19].position = GLKVector3Make(0.5f, -0.5f, -0.5f); points[19].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        points[20].position = GLKVector3Make(-0.5f, -0.5f, 0.5f); points[20].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        points[21].position = GLKVector3Make(-0.5f, -0.5f, 0.5f); points[21].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        points[22].position = GLKVector3Make(0.5f, -0.5f, -0.5f); points[22].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        points[23].position = GLKVector3Make(0.5f, -0.5f, 0.5f);  points[23].normal = GLKVector3Make(0.0f, -1.0f, 0.0f);
        
		points[24].position = GLKVector3Make(0.5f, 0.5f, 0.5f);   points[24].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        points[25].position = GLKVector3Make(-0.5f, 0.5f, 0.5f);  points[25].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        points[26].position = GLKVector3Make(0.5f, -0.5f, 0.5f);  points[26].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        points[27].position = GLKVector3Make(0.5f, -0.5f, 0.5f);  points[27].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        points[28].position = GLKVector3Make(-0.5f, 0.5f, 0.5f);  points[28].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        points[29].position = GLKVector3Make(-0.5f, -0.5f, 0.5f); points[29].normal = GLKVector3Make(0.0f, 0.0f, 1.0f);
        
		points[30].position = GLKVector3Make(0.5f, -0.5f, -0.5f); points[30].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        points[31].position = GLKVector3Make(-0.5f, -0.5f, -0.5f);points[31].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        points[32].position = GLKVector3Make(0.5f, 0.5f, -0.5f);  points[32].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        points[33].position = GLKVector3Make(0.5f, 0.5f, -0.5f);  points[33].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        points[34].position = GLKVector3Make(-0.5f, -0.5f, -0.5f);points[34].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        points[35].position = GLKVector3Make(-0.5f, 0.5f, -0.5f); points[35].normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        
        

        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, sizeof(SLModelPoint) * _elementCount, points, GL_STATIC_DRAW);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
    }
    
    return self;
}

@end
