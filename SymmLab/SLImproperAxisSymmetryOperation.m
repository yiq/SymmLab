//
//  SLImproperAxisSymmetryOperation.m
//  SymmLab
//
//  Created by Yi Qiao on 7/7/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLImproperAxisSymmetryOperation.h"
#import "SLProperAxisSymmetryOperation.h"
#import "SLPlaneSymmetryOperation.h"
#import "SLAtom.h"
#import "SLMolecule.h"

@interface SLImproperAxisSymmetryOperation() {
    SLProperAxisSymmetryOperation *cnComponent;
    SLPlaneSymmetryOperation *sComponent;
}
@end

@implementation SLImproperAxisSymmetryOperation

- (id)initWithAxis:(GLKVector3)axis divide: (NSUInteger)n
{
    self = [super init];
    if (self) {
        cnComponent = [[SLProperAxisSymmetryOperation alloc] initWithAxis:axis divide:n];
        
        GLKVector3 normAxis = GLKVector3Normalize(axis);
        
        CGFloat theta = 0;
        CGFloat phi = 0;
        
        if (normAxis.y > 0) {
            theta = asinf(axis.y);
        }
        
        if (normAxis.x == 0) {
            phi = M_PI_2 * axis.z;
        }
        else {
            phi = atan2f(axis.z, axis.x);
        }
        
        sComponent = [[SLPlaneSymmetryOperation alloc] initWithNormalAngleTheta:theta phi:phi];
    }
    
    return self;
}

- (SLMolecule *)applyOperationWithMolecule: (SLMolecule *)origMolecule {
    
    SLMolecule *resultMolecule = [[SLMolecule alloc] init];
    NSMutableArray *atoms;
    
    GLKMatrix4 transform = [self modelMatrixWithAnimationProgress:1.0f];
    
    
    for (SLAtom *atom in origMolecule.atoms) {
        
        GLKVector4 origPos = GLKVector4MakeWithVector3(atom.position, 1.0f);
        GLKVector4 newPos = GLKMatrix4MultiplyVector4(transform, origPos);
        newPos.x = newPos.x / newPos.w;
        newPos.y = newPos.y / newPos.w;
        newPos.z = newPos.z / newPos.w;
        
        [atoms addObject:[[SLAtom alloc] initWithPosition:GLKVector3Make(newPos.x, newPos.y, newPos.z) element:atom.element]];
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
    
    if (progress <= 0.5) {
        return [cnComponent modelMatrixWithAnimationProgress:progress * 2.0f];
    }
    else {
        return GLKMatrix4Multiply([sComponent modelMatrixWithAnimationProgress:((progress - 0.5f) * 2)], [cnComponent modelMatrixWithAnimationProgress:1.0f]);
    }
}


@end
