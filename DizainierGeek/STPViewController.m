//
//  STPViewController.m
//  DizainierGeek
//
//  Created by Nanook on 17/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPViewController.h"
#import "STPDizainierView.h"

@interface STPViewController () {
    STPDizainierView *mainView;
    
    int minVal;
    int maxVal;
    int total;
}

@end

@implementation STPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    total = minVal = 0;
    maxVal = 99;
    
    mainView = [[STPDizainierView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [[self view] addSubview:mainView];
    [mainView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//orientation
-(BOOL)shouldAutorotate{
    return YES;
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [mainView drawWithOrientation:toInterfaceOrientation];
}

- (void)deciSegmentAction{
    
}

- (void)hexaSegmentAction{
    
}

- (void)stepperAction{
    
}

- (void)sliderAction{
    
}

- (void)switchGeek{
    
}

- (void)resetTotal{
    
}


@end
