//
//  STPSegmentBlock.m
//  DizainierGeek
//
//  Created by Nanook on 17/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPSegmentBlock.h"

@interface STPSegmentBlock(){
    UILabel *titleLabel;
    UISegmentedControl *valueSegment;
}

@end

@implementation STPSegmentBlock

- (id)initWithItems:(NSArray *)items {
    self = [super init];
    if(self){
        titleLabel = [[UILabel alloc] init];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:titleLabel];
        
        valueSegment = [[UISegmentedControl alloc] initWithItems:items];
        [self addSubview:valueSegment];
        
        [valueSegment release];
        [titleLabel release];
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action{
    [valueSegment addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}

-(NSInteger)segmentIndex{
    return [valueSegment selectedSegmentIndex];
}
-(void)setSegmentIndex:(NSInteger)index {
    [valueSegment setSelectedSegmentIndex:index];
}


-(void)setTitle:(NSString *)title {
    [titleLabel setText:title];
}

-(void)setColor:(UIColor *)color {
    [titleLabel setTextColor:color];
    [valueSegment setTintColor:color];
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height / 3)];
    [valueSegment setFrame:CGRectMake(0,
                                      [titleLabel bounds].size.height + 5,
                                      frame.size.width,
                                      frame.size.height - [titleLabel bounds].size.height)];
}


@end
