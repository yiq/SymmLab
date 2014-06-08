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
}

@end

@implementation SLProperAxisSymmetryOperation

- (id)initWithAxis:(GLKVector3)axis divide: (NSUInteger)n
{
    self = [super init];
    if (self) {
        _axis = axis;
        _divides = n;
    }
    
    return self;
}

- (SLMolecule *)applyOperationWithMolecule: (SLMolecule *)origMolecule {
    
    SLMolecule *resultMolecule = [[SLMolecule alloc] init];
    NSMutableArray *atoms;
    
    GLKMatrix3 transform = GLKMatrix3RotateWithVector3(GLKMatrix3Identity, M_2_PI / _divides, _axis);
    for (SLAtom *atom in origMolecule.atoms) {
        [atoms addObject:[[SLAtom alloc] initWithPosition:GLKMatrix3MultiplyVector3(transform, atom.position) type:atom.atomType]];
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
    return GLKMatrix4RotateWithVector3(GLKMatrix4Identity, M_PI * 2 / _divides * progress, _axis);
}

@end
