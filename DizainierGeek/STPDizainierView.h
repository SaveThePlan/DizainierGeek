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

- (id)initWithValue:(int)val;
- (void)drawWithOrientation:(UIInterfaceOrientation)orientation;

-(void)setValue:(int)value;

-(void)setMin:(int)min andMax:(int)max;

@end
