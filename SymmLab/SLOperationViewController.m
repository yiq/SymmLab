//
//  SLOperationViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLOperationViewController.h"

@interface SLOperationViewController ()

@end

@implementation SLOperationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    id<UISplitViewControllerDelegate> theDelegate = [((UINavigationController *)self.viewControllers[1]) viewControllers][0];
    
    
    self.delegate = theDelegate;
    
    _listVC = [self.viewControllers[0] viewControllers][0];
    _opVC = [self.viewControllers[1] viewControllers][0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
