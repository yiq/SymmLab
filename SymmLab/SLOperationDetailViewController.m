//
//  SLOperationDetailViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLOperationDetailViewController.h"

@interface SLOperationDetailViewController ()

@end

@implementation SLOperationDetailViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)button
{
    if (self.navigationItem.leftBarButtonItem == button) {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{

}

- (void)setOperation:(NSString *)operation {
    [self.navigationController popToRootViewControllerAnimated:NO];
    self.title = operation;
    
    [self performSegueWithIdentifier:@"newOperation" sender:self];
}

@end
