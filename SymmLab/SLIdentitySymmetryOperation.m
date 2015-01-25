//
//  SLIdentitySymmetryOperation.m
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLIdentitySymmetryOperation.h"
#import "SLAtom.h"

@implementation SLIdentitySymmetryOperation

- (SLMolecule *)applyOperationWithMolecule: (SLMolecule *)origMolecule {
    
    SLMolecule *resultMolecule = [[SLMolecule alloc] init];
    NSMutableArray *atoms;
    
    for (SLAtom *atom in origMolecule.atoms) {
        [atoms addObject:[[SLAtom alloc] initWithPosition:atom.position element:atom.element]];
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
    return GLKMatrix4Identity;
}

@end
