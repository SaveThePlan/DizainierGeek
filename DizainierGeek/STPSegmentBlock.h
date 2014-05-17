//
//  STPSegmentBlock.h
//  DizainierGeek
//
//  Created by Nanook on 17/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPSegmentBlock : UIView

- (id)initWithItems:(NSArray *)items;
-(void)setTitle:(NSString*)title;
-(void)setColor:(UIColor*)color;

@end
