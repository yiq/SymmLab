//
//  SLCnOpPanelViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 6/15/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLCnOpPanelViewController.h"
#import "SLProperAxisSymmetryOperation.h"
#import "SLMoleculeViewController.h"
#import "SLModelLine.h"

@interface SLCnOpPanelViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nValueDisplay;
@property (weak, nonatomic) IBOutlet UISegmentedControl *axisSegCtl;
@property (weak, nonatomic) IBOutlet UIStepper *nValueStepper;
@property (weak, nonatomic) IBOutlet UISlider *animationProgressSlider;

@end

@implementation SLCnOpPanelViewController

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
    self.moleculeViewController.visualClue = [self makeVisualCueWithIndex:0 n:2];
    self.moleculeViewController.visualClueMatrix = [self makeVisualCueMatrixWithIndex:0 n:2];
    
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

- (IBAction)steperValueChanged:(UIStepper *)sender {
    self.nValueDisplay.text = [NSString stringWithFormat:@"%lu", (unsigned long)sender.value];
    [self updateOperation];
}

- (IBAction)axisValueChanged:(UISegmentedControl *)sender {
    [self updateOperation];
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.axisSegCtl.tintColor = [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:48.0f/255.0f alpha:1.0f];
            break;
        case 1:
            self.axisSegCtl.tintColor = [UIColor colorWithRed:76.0f/255.0f green:217.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            break;
        case 2:
            self.axisSegCtl.tintColor = [UIColor colorWithRed:0.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
            break;
            
        default:
            break;
    }
}

- (void)updateOperation {
    self.moleculeViewController.symmOperation = [self makeOperationWithIndex:self.axisSegCtl.selectedSegmentIndex n:self.nValueStepper.value];
    self.moleculeViewController.visualClue = [self makeVisualCueWithIndex:self.axisSegCtl.selectedSegmentIndex n:self.nValueStepper.value];
    self.moleculeViewController.visualClueMatrix = [self makeVisualCueMatrixWithIndex:self.axisSegCtl.selectedSegmentIndex n:self.nValueStepper.value];
}

- (IBAction)startAnimationAction:(id)sender {
    [self.moleculeViewController startOpAnimation];
}

- (IBAction)resetAnimationAction:(id)sender {
    [self.moleculeViewController resetOpAnimation];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.moleculeViewController.animationProgress = sender.value;
}

- (void)animationProgressChanged:(float)progress {
    self.animationProgressSlider.value = progress;
}

- (SLProperAxisSymmetryOperation *)makeOperationWithIndex: (NSUInteger)index n:(NSUInteger)n
{
    if (n < 2) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Illegal Operation!"
                                                          message:@"The n in Cn must be greater than 1"
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
    
    return [[SLProperAxisSymmetryOperation alloc] initWithAxis:axis divide:n];
}

- (SLModelLine *)makeVisualCueWithIndex: (NSUInteger)index n:(NSUInteger)n
{
    
    SLModelLine *cue;
    
    GLKVector3 xAxisPoints[2] = {
        GLKVector3Make(-100.0f, 0.0f, 0.0f),
        GLKVector3Make(100.0f, 0.0f, 0.0f)
    };
    
    GLKVector3 yAxisPoints[2] = {
        GLKVector3Make(0.0, -100.0f, 0.0f),
        GLKVector3Make(0.0, 100.0f, 0.0f)
    };
    
    GLKVector3 zAxisPoints[2] = {
        GLKVector3Make(0.0, 0.0f, -100.0f),
        GLKVector3Make(0.0, 0.0f, 100.0f)
    };
    
    SLColor axisColors[2] = {
        {1.0f, 1.0f, 0.0f, 1.0f}, {1.0f, 1.0f, 0.0f, 1.0f}
    };

    switch (index) {
        case 0:
            cue = [[SLModelLine alloc] initWithPoints:xAxisPoints colors:axisColors count:2];
            break;
        case 1:
            cue = [[SLModelLine alloc] initWithPoints:yAxisPoints colors:axisColors count:2];
            break;
        case 2:
            cue = [[SLModelLine alloc] initWithPoints:zAxisPoints colors:axisColors count:2];
            break;
            
        default:
            cue = nil;
    }
    
    return cue;
}

- (GLKMatrix4)makeVisualCueMatrixWithIndex: (NSUInteger)index n:(NSUInteger)n
{
    
    return GLKMatrix4Identity;
}

@end
