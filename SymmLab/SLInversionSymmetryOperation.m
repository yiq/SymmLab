//
//  SLInversionSymmetryOperation.m
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLInversionSymmetryOperation.h"
#import "SLAtom.h"
#import "SLMolecule.h"

@implementation SLInversionSymmetryOperation

- (SLMolecule *)applyOperationWithMolecule: (SLMolecule *)origMolecule {
    
    SLMolecule *resultMolecule = [[SLMolecule alloc] init];
    NSMutableArray *atoms;
    
    GLKMatrix3 transform = GLKMatrix3Scale(GLKMatrix3Identity, -1.0f, -1.0f, -1.0f);
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
    
    float scaleFactor = 2 * (1 - progress) - 1;
    
    return GLKMatrix4Scale(GLKMatrix4Identity, scaleFactor, scaleFactor, scaleFactor);
}

@end
