//
//  SLAbstractSymmetryOperation.m
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLAbstractSymmetryOperation.h"

@implementation SLAbstractSymmetryOperation

- (SLMolecule *)applyOperationWithMolecule: (SLMolecule *)origMolecule {
    return nil;
}

- (GLKMatrix4)modelMatrixWithAnimationProgress: (float)progress
{
    return GLKMatrix4Identity;
}

@end
