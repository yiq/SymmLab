//
//  SLModelLine.h
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLAbstractModel.h"

@interface SLModelLine : SLAbstractModel

- (id) initWithPoints:(GLKVector3 *)points colors:(SLColor *)colors count:(GLuint)count;
- (id) initWithPoints:(GLKVector3 *)points colors:(SLColor *)colors count:(GLuint)count lineWidth:(GLfloat)width;


@end
