//
//  SLProperAxisSymmetryOperation.h
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLAbstractSymmetryOperation.h"
@import GLKit;

@interface SLProperAxisSymmetryOperation : SLAbstractSymmetryOperation

@property (readonly) NSUInteger divides;

- (id)initWithAxis:(GLKVector3)axis divide: (NSUInteger)n;

@end
