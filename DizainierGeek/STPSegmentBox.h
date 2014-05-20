//
//  STPSegmentBox.h
//  DizainierGeek
//
//  Created by Nanook on 19/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface STPSegmentBox : UIScrollView

@property(assign, nonatomic) int gap;

-(void)setDeciAction:(id)target action:(SEL)action;
-(void)setHexaAction:(id)target action:(SEL)action;

- (int)getValueDeci;
- (int)getValueHexa;
- (void)setValue:(int)val;

-(void)setInterfaceProperty:(BOOL)geek landscape:(BOOL)isLandscape;


@end
