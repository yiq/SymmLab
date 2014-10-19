//
//  SLAbstractOpPanelViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 6/15/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLAbstractOpPanelViewController.h"
#import "SLMoleculeViewController.h"
#import "SLIdentitySymmetryOperation.h"

@interface SLAbstractOpPanelViewController ()

@end

@implementation SLAbstractOpPanelViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.moleculeViewController resetOpAnimation];
    [self.moleculeViewController addObserver:self forKeyPath:@"animationProgress" options:NSKeyValueObservingOptionNew context:NULL];}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.moleculeViewController removeObserver:self forKeyPath:@"animationProgress"];
    self.moleculeViewController.symmOperation = [[SLIdentitySymmetryOperation alloc] init];
    self.moleculeViewController.visualClue = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString: @"animationProgress"]) {
        [self animationProgressChanged:self.moleculeViewController.animationProgress];
    }
}

- (void)animationProgressChanged:(float)progress {
    // implement in subclass
}

@end
