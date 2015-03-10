//
//  SLImproperAxisSymmetryOperation.h
//  SymmLab
//
//  Created by Yi Qiao on 7/7/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLAbstractSymmetryOperation.h"
#import "SLProperAxisSymmetryOperation.h"

@import GLKit;

@interface SLImproperAxisSymmetryOperation : SLAbstractSymmetryOperation

- (id)initWithAxis:(GLKVector3)axis divide: (NSUInteger)n repeats: (NSUInteger)x;

@end
