//
//  SLMoleculeRotateViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 10/19/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLMoleculeRotateViewController.h"
#import "SLMoleculeViewController.h"

@interface SLMoleculeRotateViewController ()

@end

@implementation SLMoleculeRotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.moleculeViewController resetOpAnimation];
    
    self.sliderX.value = self.moleculeViewController.moleculeRotateX;
    self.labelX.text = [NSString stringWithFormat:@"%d°", (int)(self.sliderX.value)];
    self.sliderY.value = self.moleculeViewController.moleculeRotateY;
    self.labelY.text = [NSString stringWithFormat:@"%d°", (int)(self.sliderY.value)];
    self.sliderZ.value = self.moleculeViewController.moleculeRotateZ;
    self.labelZ.text = [NSString stringWithFormat:@"%d°", (int)(self.sliderZ.value)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)xValueChanged:(UISlider *)sender {
    self.moleculeViewController.moleculeRotateX = (int)sender.value;
    self.labelX.text = [NSString stringWithFormat:@"%d°", (int)(sender.value)];
    NSLog(@"slider x value changed to %f", self.moleculeViewController.moleculeRotateX);
}

- (IBAction)yValueChanged:(UISlider *)sender {
    self.moleculeViewController.moleculeRotateY = (int)sender.value;
    self.labelY.text = [NSString stringWithFormat:@"%d°", (int)(sender.value)];
}

- (IBAction)zValueChanged:(UISlider *)sender {
    self.moleculeViewController.moleculeRotateZ = (int)sender.value;
    self.labelZ.text = [NSString stringWithFormat:@"%d°", (int)(sender.value)];
}

@end
