//
//  STPDizainierView.m
//  DizainierGeek
//
//  Created by Nanook on 17/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPDizainierView.h"
#import "STPSegmentBlock.h"

@interface STPDizainierView(){
    UIView *container;
    UIStepper *totalStepper;
    UISlider *totalSlider;
    UISwitch *geekSwitch;
    UILabel *geekLabel, *deciTotalLabel, *hexaTotalLabel;
    UIButton *resetButton;
    
    STPSegmentBlock *deci1SegBlock,
                    *deci2SegBlock,
                    *hexa1SegBlock,
                    *hexa2SegBlock;
    
    int margin;
}

@end

@implementation STPDizainierView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andValue:0];
}

- (id)initWithFrame:(CGRect)frame andValue:(int)val{
    
    margin = 20;
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        container = [[UIView alloc] init];
        
        geekSwitch = [[UISwitch alloc] init];
        [geekSwitch setOn:NO];
        [container addSubview:geekSwitch];

        geekLabel = [[UILabel alloc] init];
        [geekLabel setText:@"mode geek"];
        [geekLabel setTextAlignment:NSTextAlignmentRight];
        [container addSubview:geekLabel];
        
        deciTotalLabel = [[UILabel alloc] init];
        [deciTotalLabel setTextAlignment:NSTextAlignmentCenter];
        [deciTotalLabel setText:@"total"];
        [container addSubview:deciTotalLabel];
        
        hexaTotalLabel = [[UILabel alloc] init];
        [hexaTotalLabel setTextAlignment:NSTextAlignmentCenter];
        [hexaTotalLabel setText:@"tot hexa"];
        [container addSubview:hexaTotalLabel];
        
        resetButton = [ [UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [resetButton setTitle:@"RESET" forState:UIControlStateNormal];
        [container addSubview:resetButton];
        
        totalStepper = [[UIStepper alloc] init];
        [totalStepper setMinimumValue:0];
        [totalStepper setMaximumValue:99];
        [totalStepper setValue:val];
        [container addSubview:totalStepper];
        
        totalSlider = [[UISlider alloc] init];
        [totalSlider setMinimumValue:0];
        [totalSlider setMaximumValue:99];
        [totalSlider setValue:val];
        [container addSubview:totalSlider];
        
        [self addSubview:container];
        
        //clean memory references
        [geekSwitch release];
        [geekLabel release];
        [deciTotalLabel release];
        [hexaTotalLabel release];
        [resetButton release];
        [totalStepper release];
        
        
        [self drawWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    }
    
    return self;
}

-(void) drawWithOrientation:(UIInterfaceOrientation)orientation {
    
    int gap = 20;
    int lineHeight = 20;
    
    [container setFrame:CGRectMake([self bounds].origin.x + margin,
                                   [self bounds].origin.y + margin,
                                   [self bounds].size.width - 2 * margin,
                                   [self bounds].size.height - 2 * margin)];
    
    //top stick elements
    [totalStepper setFrame:CGRectMake(0,
                                      0,
                                      [totalStepper bounds].size.width,
                                      [totalStepper bounds].size.height)];
    [geekSwitch setFrame:CGRectMake([container bounds].size.width - [geekSwitch bounds].size.width,
                                    0,
                                    [geekSwitch bounds].size.width,
                                    [geekSwitch bounds].size.height)];
    [geekLabel setFrame:CGRectMake([totalStepper frame].origin.x + [totalStepper frame].size.width + gap,
                                   0,
                                   [container bounds].size.width - [geekSwitch frame].size.width - [totalStepper frame].size.width - 2 * gap,
                                   [geekSwitch bounds].size.height)];
    
    
    //bottom stick elements
    [resetButton setFrame:CGRectMake( [container bounds].size.width / 4,
                                     [container bounds].size.height - 30,
                                     [container bounds].size.width / 2,
                                     lineHeight)];
    [totalSlider setFrame:CGRectMake(0,
                                     [resetButton frame].origin.y - lineHeight - gap,
                                     [container bounds].size.width,
                                     lineHeight)];
    [hexaTotalLabel setFrame:CGRectMake(0,
                                        [totalSlider frame].origin.y - lineHeight - gap,
                                        [container bounds].size.width,
                                        lineHeight)];
    [deciTotalLabel setFrame:CGRectMake(0,
                                        [hexaTotalLabel frame].origin.y - lineHeight - gap,
                                        [container bounds].size.width,
                                        lineHeight)];
    
}

@end
