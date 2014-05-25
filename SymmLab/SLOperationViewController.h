//
//  SLOperationViewController.h
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

@import UIKit;

@class SLOperationListViewController;
@class SLOperationDetailViewController;

@interface SLOperationViewController : UISplitViewController

@property (weak, nonatomic) SLOperationListViewController *listVC;
@property (weak, nonatomic) SLOperationDetailViewController *opVC;

@end
