//
//  STPDizainierView.h
//  DizainierGeek
//
//  Created by Nanook on 17/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPViewController.h"

@interface STPDizainierView : UIView

@property(retain, atomic) STPViewController* controller;

- (id)initWithFrame:(CGRect)frame andValue:(int)val;
- (void)drawWithOrientation:(UIInterfaceOrientation)orientation;
-(void)setValue:(int)value;
-(void)setMinVal:(int)val;
-(void)setMaxVal:(int)val;

/* ACTIONS
- (void)deciSegmentAction;
- (void)hexaSegmentAction;
- (void)stepperAction;
- (void)sliderAction;
- (void)switchGeek;
- (void)resetTotal;
 */

@end
