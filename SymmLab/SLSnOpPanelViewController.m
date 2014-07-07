//
//  SLSnOpPanelViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 7/7/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLSnOpPanelViewController.h"
#import "SLMoleculeViewController.h"
#import "SLImproperAxisSymmetryOperation.h"
#import "SLModelPlane.h"

@interface SLSnOpPanelViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nValueDisplay;
@property (weak, nonatomic) IBOutlet UISegmentedControl *axisSegCtl;
@property (weak, nonatomic) IBOutlet UIStepper *nValueStepper;
@property (weak, nonatomic) IBOutlet UISlider *animationProgressSlider;

@end

@implementation SLSnOpPanelViewController

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
    
    self.moleculeViewController.symmOperation = [self makeOperationWithIndex:0 n:2];
    self.moleculeViewController.visualClue = [self makeVisualCueWithIndex:0];
    self.moleculeViewController.visualClueMatrix = [self makeVisualCueMatrixWithIndex:0];
    
    self.axisSegCtl.tintColor = [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:48.0f/255.0f alpha:1.0f];
    
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

- (void)updateOperation {
    self.moleculeViewController.symmOperation = [self makeOperationWithIndex:self.axisSegCtl.selectedSegmentIndex n:self.nValueStepper.value];
    self.moleculeViewController.visualClue = [self makeVisualCueWithIndex:self.axisSegCtl.selectedSegmentIndex];
    self.moleculeViewController.visualClueMatrix = [self makeVisualCueMatrixWithIndex:self.axisSegCtl.selectedSegmentIndex];
}

- (SLProperAxisSymmetryOperation *)makeOperationWithIndex: (NSUInteger)index n:(NSUInteger)n
{
    if (n < 2) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Illegal Operation!"
                                                          message:@"The n in Sn must be greater than 1"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
        return nil;
    }
    
    GLKVector3 axis;
    
    switch (index) {
        case 0:
            axis = GLKVector3Make(1.0f, 0.0f, 0.0f);
            break;
        case 1:
            axis = GLKVector3Make(0.0f, 1.0f, 0.0f);
            break;
        case 2:
            axis = GLKVector3Make(0.0f, 0.0f, 1.0f);
            break;
        default:
            return nil;
    }
    
    return [[SLImproperAxisSymmetryOperation alloc] initWithAxis:axis divide:n];
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
            // Y-Z
            planeModeMatrix = GLKMatrix4RotateY(planeModeMatrix, M_PI_2);
            break;
        case 1:
            //X-Z Plane
            planeModeMatrix = GLKMatrix4RotateX(planeModeMatrix, M_PI_2);
            break;
        case 2:
            //X-Y Plane
            break;
        default:
            break;
    }
    
    planeModeMatrix = GLKMatrix4Scale(planeModeMatrix, 5.0f, 5.0f, 1.0f);
    
    return planeModeMatrix;
}

@end
