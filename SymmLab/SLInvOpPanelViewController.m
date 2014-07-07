//
//  SLInvOpPanelViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 6/15/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLInvOpPanelViewController.h"
#import "SLMoleculeViewController.h"
#import "SLInversionSymmetryOperation.h"

@interface SLInvOpPanelViewController ()
@property (weak, nonatomic) IBOutlet UISlider *animationProgressSlider;

@end

@implementation SLInvOpPanelViewController

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
    
    self.moleculeViewController.symmOperation = [[SLInversionSymmetryOperation alloc] init];
    self.moleculeViewController.visualClue = nil;
    
    self.animationProgressSlider.value = 0.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startAnimationAction:(id)sender {
    [self.moleculeViewController startOpAnimation];
}

- (IBAction)resetAnimationAction:(id)sender {
    [self.moleculeViewController resetOpAnimation];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.moleculeViewController.animationProgress = sender.value;
}

- (void)animationProgressChanged:(float)progress
{
    self.animationProgressSlider.value = progress;
}

@end
