//
//  SLAbstractModel.h
//  SymmLab
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

@import Foundation;
@import GLKit;

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

typedef struct {
    GLfloat r;
    GLfloat g;
    GLfloat b;
    GLfloat a;
} SLColor;

typedef struct {
    GLKVector3 position;
    GLKVector3 normal;
    SLColor color;
} SLModelPoint;

@interface SLAbstractModel : NSObject {
    @protected
    GLuint _glDrawMode;
    GLuint _vertexArray;
    GLuint _glBuffers[2];
    
    GLuint _vertexCount;
    GLuint _indexCount;
    
    SLModelPoint * _points;
    GLuint * _indices;
    
    BOOL _isRenderable;
}

- (void)render;
- (void)addChild:(SLAbstractModel *)child;

- (void)translateByX:(GLfloat)dx byY:(GLfloat)dy byZ:(GLfloat)dz;
- (void)setColorWithR:(GLfloat)r g:(GLfloat)g b:(GLfloat)b alpha:(GLfloat)a;

@end
