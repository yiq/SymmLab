//
//  SLViewController.h
//  SymmLab
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

@import UIKit;

@class SLAbstractSymmetryOperation;
@class SLRootOpPanelViewController;
@class SLMoleculeViewController;

@interface SLViewController : UIViewController <UISplitViewControllerDelegate>

@property (weak, nonatomic) SLRootOpPanelViewController *RootOpPanelVC;
@property (weak, nonatomic) SLMoleculeViewController *MoleculeVC;
@property (weak, nonatomic) NSString * activeFile;

- (IBAction)interactiveModeChanged:(id)sender;

@end
