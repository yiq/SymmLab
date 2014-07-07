//
//  SLCnOpPanelViewController.h
//  SymmLab
//
//  Created by Yi Qiao on 6/15/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLAbstractOpPanelViewController.h"

@interface SLCnOpPanelViewController : SLAbstractOpPanelViewController

- (IBAction)steperValueChanged:(UIStepper *)sender;
- (IBAction)axisValueChanged:(UISegmentedControl *)sender;
- (IBAction)startAnimationAction:(id)sender;
- (IBAction)resetAnimationAction:(id)sender;
- (IBAction)sliderValueChanged:(UISlider *)sender;
@end
