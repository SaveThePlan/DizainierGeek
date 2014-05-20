//
//  STPSegmentBlock.m
//  DizainierGeek
//
//  Created by Nanook on 17/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPSegmentBlock.h"
#import "STPLayoutConstraintBuilder.h"

@interface STPSegmentBlock(){
    UILabel *titleLabel;
    UISegmentedControl *valueSegment;
    NSLayoutConstraint *heightConstraint;
}

@end

@implementation STPSegmentBlock

- (id)initWithItems:(NSArray *)items {
    self = [super init];
    if(self){
        
        titleLabel = [[UILabel alloc] init];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:titleLabel];
        [titleLabel release];
        
        valueSegment = [[UISegmentedControl alloc] initWithItems:items];
        [valueSegment setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:valueSegment];
        [valueSegment release];
        
        //add fix constraints
        
        [self addConstraint:[STPLayoutConstraintBuilder
                             fixTop:titleLabel
                             toTop:self
                             withConstant:0]];
        [self addConstraint:[STPLayoutConstraintBuilder
                             fixCenterX:titleLabel
                             toCenterX:self
                             withConstant:0]];
        
        [self addConstraint:[STPLayoutConstraintBuilder
                             fixBottom:valueSegment
                             toBottom:self
                             withConstant:0]];
        [self addConstraint:[STPLayoutConstraintBuilder
                             fixCenterX:valueSegment
                             toCenterX:self
                             withConstant:0]];
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:valueSegment attribute:NSLayoutAttributeLeft
                             relatedBy:NSLayoutRelationGreaterThanOrEqual
                             toItem:self attribute:NSLayoutAttributeLeft
                             multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:valueSegment attribute:NSLayoutAttributeRight
                             relatedBy:NSLayoutRelationLessThanOrEqual
                             toItem:self attribute:NSLayoutAttributeRight
                             multiplier:1 constant:0]];
        
        heightConstraint = [NSLayoutConstraint
                            constraintWithItem:self attribute:NSLayoutAttributeHeight
                            relatedBy:NSLayoutRelationGreaterThanOrEqual
                            toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                            multiplier:1 constant:50];
        [self addConstraint:heightConstraint];

        
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

-(void)setMinHeight:(int)minHeight{
    if(minHeight > 50){
        [self removeConstraint:heightConstraint];
        heightConstraint = [NSLayoutConstraint
                            constraintWithItem:self attribute:NSLayoutAttributeHeight
                            relatedBy:NSLayoutRelationGreaterThanOrEqual
                            toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                            multiplier:1
                            constant:minHeight];
        [self addConstraint:heightConstraint];
    }
}

-(void)dealloc{
    [titleLabel release];
    [valueSegment release];
    [heightConstraint release];
    [super dealloc];
}

@end
