//
//  SLProperAxisSymmetryOperation.m
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLProperAxisSymmetryOperation.h"
#import "SLAtom.h"
#import "SLMolecule.h"

@interface SLProperAxisSymmetryOperation () {
    GLKVector3 _axis;
    NSUInteger _repeats;
}

@end

@implementation SLProperAxisSymmetryOperation

- (id)initWithAxis:(GLKVector3)axis divide: (NSUInteger)n repeat:(NSUInteger)x
{
    self = [super init];
    if (self) {
        _axis = axis;
        _divides = n;
        _repeats = x;
    }
    
    return self;
}

- (SLMolecule *)applyOperationWithMolecule: (SLMolecule *)origMolecule {
    
    SLMolecule *resultMolecule = [[SLMolecule alloc] init];
    NSMutableArray *atoms;
    
    GLKMatrix3 transform = GLKMatrix3RotateWithVector3(GLKMatrix3Identity, M_2_PI / _divides * _repeats, _axis);
    for (SLAtom *atom in origMolecule.atoms) {
        [atoms addObject:[[SLAtom alloc] initWithPosition:GLKMatrix3MultiplyVector3(transform, atom.position) element:atom.element]];
    }
    
    resultMolecule.atoms = [NSArray arrayWithArray:atoms];
    
    resultMolecule.cellAngleX = origMolecule.cellAngleX;
    resultMolecule.cellAngleY = origMolecule.cellAngleY;
    resultMolecule.cellAngleZ = origMolecule.cellAngleZ;
    
    resultMolecule.cellLengthA = origMolecule.cellLengthA;
    resultMolecule.cellLengthB = origMolecule.cellLengthB;
    resultMolecule.cellLengthC = origMolecule.cellLengthC;
    
    return resultMolecule;
}

- (GLKMatrix4)modelMatrixWithAnimationProgress: (float)progress
{
    return GLKMatrix4RotateWithVector3(GLKMatrix4Identity, M_PI * 2.0 / _divides * _repeats * progress, _axis);
}

@end
