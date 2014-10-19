//
//  SLMoleculeRotateViewController.h
//  SymmLab
//
//  Created by Yi Qiao on 10/19/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLAbstractOpPanelViewController.h"

@interface SLMoleculeRotateViewController : SLAbstractOpPanelViewController

@property (weak, nonatomic) IBOutlet UISlider *sliderX;
@property (weak, nonatomic) IBOutlet UISlider *sliderY;
@property (weak, nonatomic) IBOutlet UISlider *sliderZ;

@property (weak, nonatomic) IBOutlet UILabel *labelX;
@property (weak, nonatomic) IBOutlet UILabel *labelY;
@property (weak, nonatomic) IBOutlet UILabel *labelZ;

@end
