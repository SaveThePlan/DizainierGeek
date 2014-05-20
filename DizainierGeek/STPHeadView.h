//
//  STPHeadView.h
//  DizainierGeek
//
//  Created by Nanook on 19/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPViewController.h"

@interface STPHeadView : UIView

@property(assign, nonatomic) int gap;

- (void)setStepperAction:(id)target action:(SEL)action;
- (void)setSwitchGeekAction:(id)target action:(SEL)action;

-(void)setStepperMin:(int)val;
-(void)setStepperMax:(int)val;
-(void)setStepperValue:(int)val;

@end
