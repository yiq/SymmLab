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
    GLKVector3 position;
    GLKVector3 normal;
} SLModelPoint;

@interface SLAbstractModel : NSObject {
    @protected
    GLuint _glDrawMode;
    GLuint _vertexArray;
    GLuint _vertexBuffer;
    GLuint _elementCount;
}

- (void)render;

@end
