//
//  SLViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLViewController.h"
#import "SLRootOpPanelViewController.h"
#import "SLMoleculeViewController.h"

@interface SLViewController ()
@property (weak, nonatomic) SLRootOpPanelViewController *RootOpPanelVC;
@property (weak, nonatomic) SLMoleculeViewController *MoleculeVC;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation SLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
    //self.title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"emseg_op"]) {
        self.RootOpPanelVC = [[segue.destinationViewController viewControllers] objectAtIndex:0];
        self.RootOpPanelVC.slViewController = self;
        self.RootOpPanelVC.moleculeViewController = self.MoleculeVC;
    }
    else if ([segue.identifier isEqualToString:@"emseg_gl"]) {
        self.MoleculeVC = segue.destinationViewController;
        assert(self.MoleculeVC);
    }
}

- (void)setDetailItem:(id)newDetailItem
{
//    if (_detailItem != newDetailItem) {
//        _detailItem = newDetailItem;
//        
//        // Update the view.
//        [self configureView];
//    }
//    
//    if (self.masterPopoverController != nil) {
//        [self.masterPopoverController dismissPopoverAnimated:YES];
//    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Molecules", @"Molecules");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
