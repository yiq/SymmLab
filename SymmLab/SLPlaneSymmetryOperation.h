//
//  SLPlaneSymmetryOperation.h
//  SymmLab
//
//  Created by Yi Qiao on 6/8/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLAbstractSymmetryOperation.h"

@import GLKit;

/**
 * The plane is defined by its normal vector, which starts with X and first rotates 
 * up around Z by theta, then rotates around Y by phi
 */
@interface SLPlaneSymmetryOperation : SLAbstractSymmetryOperation

/**
 * angle between the normal vector and the x-z plane.
 */
@property (nonatomic) CGFloat normalAngleTheta;

/**
 * rotation around y axis after it has been raised up by theta
 */
@property (nonatomic) CGFloat normalAnglePhi;

- (instancetype) initWithNormalAngleTheta:(CGFloat)theta phi:(CGFloat)phi;

@end
