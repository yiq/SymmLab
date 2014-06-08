//
//  SLAbstractSymmetryOperation.h
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

@import Foundation;
#import "SLMolecule.h"
@import GLKit;

/**
 * This class represents any symmetry operation.
 */
@interface SLAbstractSymmetryOperation : NSObject

- (SLMolecule *)applyOperationWithMolecule: (SLMolecule *)origMolecule;

- (GLKMatrix4)modelMatrixWithAnimationProgress: (float)progress;

@end
