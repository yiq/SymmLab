//
//  SLMoleculeViewController.h
//  SymmLab
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

@import UIKit;
@import GLKit;

@class SLAbstractSymmetryOperation;
@class SLAbstractModel;

@interface SLMoleculeViewController : GLKViewController

@property (strong, nonatomic) SLAbstractSymmetryOperation *symmOperation;
@property (strong, nonatomic) SLAbstractModel *visualClue;
@property (nonatomic) GLKMatrix4 visualClueMatrix;

@property (nonatomic) float animationProgress;

- (void)startOpAnimation;
- (void)pauseOpAnimation;
- (void)resetOpAnimation;

@end
