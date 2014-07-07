//
//  SLSigmaOpPanelViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 6/15/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLSigmaOpPanelViewController.h"
#import "SLMoleculeViewController.h"
#import "SLPlaneSymmetryOperation.h"

#import "SLModelPlane.h"

@interface SLSigmaOpPanelViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *symmetryPlaneSegCtl;
@property (weak, nonatomic) IBOutlet UISlider *animationProgressSlider;

@end

@implementation SLSigmaOpPanelViewController

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
    self.moleculeViewController.symmOperation = [self makeOperationWithIndex:0];
    self.moleculeViewController.visualClue = [self makeVisualCueWithIndex:0];
    self.moleculeViewController.visualClueMatrix = [self makeVisualCueMatrixWithIndex:0];
    self.animationProgressSlider.value = self.moleculeViewController.animationProgress;
    
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

- (void)animationProgressChanged:(float)progress
{
    self.animationProgressSlider.value = progress;
}

- (IBAction)startAnimationAction:(id)sender {
    [self.moleculeViewController startOpAnimation];
}

- (IBAction)resetAnimationAction:(id)sender {
    [self.moleculeViewController resetOpAnimation];
}

- (IBAction)sliderTouchedAction:(id)sender {
    [self.moleculeViewController pauseOpAnimation];
    self.moleculeViewController.animationProgress = self.animationProgressSlider.value;
}

- (IBAction)sliderValueChanged:(id)sender {
    [self.moleculeViewController pauseOpAnimation];
    self.moleculeViewController.animationProgress = self.animationProgressSlider.value;
}

- (IBAction)planeChanged:(UISegmentedControl *)sender {
    [self.moleculeViewController resetOpAnimation];
    self.moleculeViewController.symmOperation = [self makeOperationWithIndex:sender.selectedSegmentIndex];
    self.moleculeViewController.visualClue = [self makeVisualCueWithIndex:sender.selectedSegmentIndex];
    self.moleculeViewController.visualClueMatrix = [self makeVisualCueMatrixWithIndex:sender.selectedSegmentIndex];
}

- (SLPlaneSymmetryOperation *)makeOperationWithIndex: (NSUInteger)index
{
    SLPlaneSymmetryOperation *op;
    switch (index) {
        case 0:
            //X-Y Plane
            op = [[SLPlaneSymmetryOperation alloc] initWithNormalAngleTheta:0.0f phi:M_PI_2];
            break;
        case 1:
            //X-Z Plane
            op = [[SLPlaneSymmetryOperation alloc] initWithNormalAngleTheta:M_PI_2 phi:0.0f];
            break;
        case 2:
            //Y-Z Plane
            op = [[SLPlaneSymmetryOperation alloc] initWithNormalAngleTheta:0.0f phi:0.0f];
            break;
        default:
            break;
    }
    
    return op;
}

- (SLModelPlane *)makeVisualCueWithIndex: (NSUInteger)index
{
    return [[SLModelPlane alloc] init];
}

- (GLKMatrix4)makeVisualCueMatrixWithIndex: (NSUInteger)index
{
    
    GLKMatrix4 planeModeMatrix = GLKMatrix4Identity;
    
    switch (index) {
        case 0:
            break;
        case 1:
            //X-Z Plane
            planeModeMatrix = GLKMatrix4RotateX(planeModeMatrix, M_PI_2);
            break;
        case 2:
            //Y-Z Plane
            planeModeMatrix = GLKMatrix4RotateY(planeModeMatrix, M_PI_2);
            break;
        default:
            break;
    }
    
    planeModeMatrix = GLKMatrix4Scale(planeModeMatrix, 5.0f, 5.0f, 1.0f);

    return planeModeMatrix;
}

@end
