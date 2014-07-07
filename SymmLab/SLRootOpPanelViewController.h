//
//  SLRootOpPanelViewController.h
//  SymmLab
//
//  Created by Yi Qiao on 6/15/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLViewController;
@class SLMoleculeViewController;

@interface SLRootOpPanelViewController : UIViewController

@property (weak, nonatomic) SLViewController * slViewController;
@property (weak, nonatomic) SLMoleculeViewController * moleculeViewController;

@end
