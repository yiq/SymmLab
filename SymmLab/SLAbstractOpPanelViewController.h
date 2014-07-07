//
//  SLAbstractOpPanelViewController.h
//  SymmLab
//
//  Created by Yi Qiao on 6/15/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLMoleculeViewController;

@interface SLAbstractOpPanelViewController : UIViewController

@property (weak, nonatomic) SLMoleculeViewController * moleculeViewController;

- (void)animationProgressChanged:(float)progress;

@end
