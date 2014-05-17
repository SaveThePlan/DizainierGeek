//
//  STPDizainierView.h
//  DizainierGeek
//
//  Created by Nanook on 17/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPDizainierView : UIView

- (id)initWithFrame:(CGRect)frame andValue:(int)val;
- (void)drawWithOrientation:(UIInterfaceOrientation)orientation;

@end
