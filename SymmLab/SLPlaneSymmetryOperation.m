//
//  SLPlaneSymmetryOperation.m
//  SymmLab
//
//  Created by Yi Qiao on 6/8/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLPlaneSymmetryOperation.h"
#import "SLAtom.h"

@implementation SLPlaneSymmetryOperation

- (instancetype) initWithNormalAngleTheta:(CGFloat)theta phi:(CGFloat)phi {
    self = [super init];
    if (self) {
        _normalAngleTheta = theta;
        _normalAnglePhi = phi;
    }
    
    return self;
}

- (SLMolecule *)applyOperationWithMolecule: (SLMolecule *)origMolecule {
    SLMolecule *resultMolecule = [[SLMolecule alloc] init];
    NSMutableArray *atoms;
    
    GLKMatrix3 transform = GLKMatrix3Identity;
    transform = GLKMatrix3RotateY(transform, -_normalAnglePhi);
    transform = GLKMatrix3RotateZ(transform, -_normalAngleTheta);
    transform = GLKMatrix3Scale(transform, -1.0f, 1.0f, 1.0f);
    transform = GLKMatrix3RotateZ(transform, _normalAngleTheta);
    transform = GLKMatrix3RotateY(transform, _normalAnglePhi);
    
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

- (GLKMatrix4)modelMatrixWithAnimationProgress: (float)progress {
    
    float scaleFactor = 2 * (1 - progress) - 1;
    
    
    GLKMatrix4 matrix = GLKMatrix4Identity;
    matrix = GLKMatrix4RotateY(matrix, -_normalAnglePhi);
    matrix = GLKMatrix4RotateZ(matrix, -_normalAngleTheta);
    matrix = GLKMatrix4Scale(matrix, scaleFactor, 1.0f, 1.0f);
    matrix = GLKMatrix4RotateZ(matrix, _normalAngleTheta);
    matrix = GLKMatrix4RotateY(matrix, _normalAnglePhi);
    
    return matrix;
}

@end
