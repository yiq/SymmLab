//
//  SLRootOpPanelViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 6/15/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLRootOpPanelViewController.h"
#import "SLSigmaOpPanelViewController.h"

@interface SLRootOpPanelViewController ()

@end

@implementation SLRootOpPanelViewController

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"sigma"]) {
        SLSigmaOpPanelViewController *destVC = segue.destinationViewController;
        destVC.moleculeViewController = self.moleculeViewController;
    }
    else if ([segue.identifier isEqualToString:@"inversion"]) {
        SLSigmaOpPanelViewController *destVC = segue.destinationViewController;
        destVC.moleculeViewController = self.moleculeViewController;
    }
    else if ([segue.identifier isEqualToString:@"cn"]) {
        SLSigmaOpPanelViewController *destVC = segue.destinationViewController;
        destVC.moleculeViewController = self.moleculeViewController;
    }
    else if ([segue.identifier isEqualToString:@"sn"]) {
        SLSigmaOpPanelViewController *destVC = segue.destinationViewController;
        destVC.moleculeViewController = self.moleculeViewController;
    }

}


@end
