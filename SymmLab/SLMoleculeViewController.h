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
@class SLViewController;

@interface SLMoleculeViewController : GLKViewController

@property (weak, nonatomic) SLViewController * rootVC;

@property (strong, nonatomic) SLAbstractSymmetryOperation *symmOperation;
@property (strong, nonatomic) SLAbstractModel *visualClue;
@property (nonatomic) GLKMatrix4 visualClueMatrix;

@property (nonatomic) BOOL isRotatingCamera;

@property (nonatomic) float animationProgress;

@property GLfloat moleculeRotateX;
@property GLfloat moleculeRotateY;
@property GLfloat moleculeRotateZ;

- (void)startOpAnimation;
- (void)pauseOpAnimation;
- (void)resetOpAnimation;

- (void)loadMoleculeWithFilename:(NSString *)filename;

@end
