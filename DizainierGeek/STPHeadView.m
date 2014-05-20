//
//  STPHeadView.m
//  DizainierGeek
//
//  Created by Nanook on 19/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPHeadView.h"

@interface STPHeadView(){
    UIStepper *totalStepper;
    UISwitch *geekSwitch;
    UILabel *geekLabel;
}

@end

@implementation STPHeadView

- (id)init {
    self = [super init];
    if (self) {
        
        geekSwitch = [[UISwitch alloc] init];
        [geekSwitch setOn:NO];
        [geekSwitch setOnTintColor:[UIColor purpleColor]];
        [self addSubview:geekSwitch];
        
        geekLabel = [[UILabel alloc] init];
        [geekLabel setText:@"mode geek"];
        [geekLabel setTextColor:[UIColor lightGrayColor]];
        [geekLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:geekLabel];

        totalStepper = [[UIStepper alloc] init];
        [totalStepper setMinimumValue:0];
        [totalStepper setMaximumValue:1];
        [self addSubview:totalStepper];
        
        //free memory
        [geekSwitch release];
        [geekLabel release];
        [totalStepper release];
        
    }
    return self;
}

-(void)setStepperMin:(int)val {
    [totalStepper setMinimumValue:val];
}
-(void)setStepperMax:(int)val {
    [totalStepper setMaximumValue:val];
}
-(void)setStepperValue:(int)val {
    [totalStepper setValue:val];
}

-(BOOL)isGeek {
    return geekSwitch.on;
}


-(void)setFrame:(CGRect)frame modeLandscape:(BOOL)isLandscape {
    [super setFrame:frame];
    
    int originX = [self bounds].origin.x;
    int originY = [self bounds].origin.y;
    int maxWidth = [self bounds].size.width;
    int maxHeight = [self bounds].size.height;
    
    int stepperWidth = [totalStepper bounds].size.width;
    int switchWidth = [geekSwitch bounds].size.width;
    
    [totalStepper setFrame:CGRectMake(originX, originY,
                                      stepperWidth, maxHeight)];
    
    [geekSwitch setFrame:CGRectMake(originX + maxWidth - switchWidth, originY,
                                    switchWidth, maxHeight)];
    
    [geekLabel setFrame:CGRectMake(originX + stepperWidth + _gap, originY,
                                   maxWidth - stepperWidth - switchWidth - 2 * _gap, maxHeight)];
}

/* ----------------- ACTIONS --------------------- */
- (void)setStepperAction:(id)target action:(SEL)action {
    [totalStepper addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}

- (void)setSwitchGeekAction:(id)target action:(SEL)action {
    [geekSwitch addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}




@end
