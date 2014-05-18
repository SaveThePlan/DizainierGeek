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
    int value;
    BOOL isIpad;
}

@end

@implementation STPDizainierView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andValue:0];
}

- (id)initWithFrame:(CGRect)frame andValue:(int)val {
    
    isIpad = ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad );
    
    margin = 20;
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        NSArray *deciArray = [NSArray arrayWithObjects: @"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
        NSArray *hexaArray = [NSArray arrayWithObjects: @"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", @"A", @"B", @"C", @"D", @"E", @"F", nil];
        
        
        container = [[UIView alloc] init];
        
        geekSwitch = [[UISwitch alloc] init];
        [geekSwitch setOn:NO];
        [geekSwitch setOnTintColor:[UIColor purpleColor]];
        [geekSwitch addTarget:self action:@selector(switchGeek)
             forControlEvents:UIControlEventValueChanged];
        [container addSubview:geekSwitch];

        geekLabel = [[UILabel alloc] init];
        [geekLabel setText:@"mode geek"];
        [geekLabel setTextColor:[UIColor lightGrayColor]];
        [geekLabel setTextAlignment:NSTextAlignmentRight];
        [container addSubview:geekLabel];
        
        deciTotalLabel = [[UILabel alloc] init];
        [deciTotalLabel setTextAlignment:NSTextAlignmentCenter];
        [container addSubview:deciTotalLabel];
        
        hexaTotalLabel = [[UILabel alloc] init];
        [hexaTotalLabel setTextAlignment:NSTextAlignmentCenter];
        [container addSubview:hexaTotalLabel];
        
        resetButton = [ [UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [resetButton setTitle:@"RESET" forState:UIControlStateNormal];
        [resetButton addTarget:self
                        action:@selector(resetTotal)
                        forControlEvents:UIControlEventTouchDown];
        [container addSubview:resetButton];
        
        totalStepper = [[UIStepper alloc] init];
        [totalStepper setMinimumValue:0];
        [totalStepper setMaximumValue:1];
        [totalStepper addTarget:self
                        action:@selector(stepperAction)
                        forControlEvents:UIControlEventValueChanged];
        [container addSubview:totalStepper];
        
        totalSlider = [[UISlider alloc] init];
        [totalSlider setMinimumValue:0];
        [totalSlider setMaximumValue:1];
        [totalSlider addTarget:self
                         action:@selector(sliderAction)
               forControlEvents:UIControlEventValueChanged];
        [container addSubview:totalSlider];
        
        deci2SegBlock = [[STPSegmentBlock alloc] initWithItems:deciArray];
        [deci2SegBlock setTitle:@"Dizaines"];
        [deci2SegBlock setColor:[UIColor blueColor]];
        [deci2SegBlock addTarget:self action:@selector(deciSegmentAction)];
        [container addSubview:deci2SegBlock];
        
        deci1SegBlock = [[STPSegmentBlock alloc] initWithItems:deciArray];
        [deci1SegBlock setTitle:@"Unités"];
        [deci1SegBlock setColor:[UIColor blueColor]];
        [deci1SegBlock addTarget:self action:@selector(deciSegmentAction)];
        [container addSubview:deci1SegBlock];
        
        hexa2SegBlock = [[STPSegmentBlock alloc] initWithItems:hexaArray];
        [hexa2SegBlock setTitle:@"Rang 2 hexa"];
        [hexa2SegBlock setColor:[UIColor purpleColor]];
        [hexa2SegBlock addTarget:self action:@selector(hexaSegmentAction)];
        [container addSubview:hexa2SegBlock];
        
        hexa1SegBlock = [[STPSegmentBlock alloc] initWithItems:hexaArray];
        [hexa1SegBlock setTitle:@"Rang 1 hexa"];
        [hexa1SegBlock setColor:[UIColor purpleColor]];
        [hexa1SegBlock addTarget:self action:@selector(hexaSegmentAction)];
        [container addSubview:hexa1SegBlock];
        
        
        [self addSubview:container];
        
        //clean memory references
        [geekSwitch release];
        [geekLabel release]; [deciTotalLabel release]; [hexaTotalLabel release];
        [resetButton release];
        [totalStepper release];
        [deci1SegBlock release]; [deci2SegBlock release];
        [hexa1SegBlock release]; [hexa2SegBlock release];
        
        
        [self setValue:val];
        [self drawWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    }
    
    return self;
}

-(void)setMinVal:(int)val{
    [totalSlider setMinimumValue:val];
    [totalStepper setMinimumValue:val];
}
-(void)setMaxVal:(int)val {
    [totalStepper setMaximumValue:val];
    [totalSlider setMaximumValue:val];
}

-(void)setValue:(int)val {
    value = val;
    [self widgetsValues];
}

-(void)widgetsValues {
    [deciTotalLabel setText:[NSString stringWithFormat:@"%d", value]];
    [hexaTotalLabel setText:[NSString stringWithFormat:@"%x", value]];
    if(value == 42){
        [deciTotalLabel setTextColor:[UIColor redColor]];
        [hexaTotalLabel setTextColor:[UIColor greenColor]];
    } else {
        [deciTotalLabel setTextColor:[UIColor blueColor]];
        [hexaTotalLabel setTextColor:[UIColor purpleColor]];
    }
    
    [deci1SegBlock setSegmentIndex: value % 10];
    [deci2SegBlock setSegmentIndex: value / 10];
    [hexa1SegBlock setSegmentIndex: value % 16];
    [hexa2SegBlock setSegmentIndex: value / 16];
    
    [totalStepper setValue:value];
    [totalSlider setValue:value animated:YES];
    
    [self setNeedsDisplay];
}

-(void) drawWithOrientation:(UIInterfaceOrientation)orientation {
    
    BOOL isGeek = geekSwitch.on;
    BOOL isLandscape = (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight);

    if(isLandscape){
        [container setFrame:CGRectMake([self bounds].origin.x + margin,
                                       [self bounds].origin.y + margin,
                                       [self bounds].size.height - 2 * margin,
                                       [self bounds].size.width - 2 * margin)];
        
    } else {
        [container setFrame:CGRectMake([self bounds].origin.x + margin,
                                       [self bounds].origin.y + margin,
                                       [self bounds].size.width - 2 * margin,
                                       [self bounds].size.height - 2 * margin)];
        
    }
    
    int gap = [container bounds].size.height / 30;
    int lineHeight = [container bounds].size.height / 15;
    
    //top stick elements
    [totalStepper setFrame:CGRectMake(0,
                                      0,
                                      [totalStepper bounds].size.width,
                                      [totalStepper bounds].size.height)];
    int test = (isLandscape)? 200 : 0;
    [geekSwitch setFrame:CGRectMake([container bounds].size.width - [geekSwitch bounds].size.width - test,
                                    0,
                                    [geekSwitch bounds].size.width,
                                    [geekSwitch bounds].size.height)];
    [geekLabel setFrame:CGRectMake([totalStepper frame].origin.x + [totalStepper frame].size.width + gap,
                                   0,
                                   [container bounds].size.width - [geekSwitch frame].size.width - [totalStepper frame].size.width - 2 * gap,
                                   [geekSwitch bounds].size.height)];
    
    [deci2SegBlock setFrame:CGRectMake(0,
                                       [geekSwitch frame].origin.y + [geekSwitch frame].size.height + gap,
                                       [container bounds].size.width, 2*lineHeight)];
    [deci1SegBlock setFrame:CGRectMake(0,
                                       [deci2SegBlock frame].origin.y + [deci2SegBlock frame].size.height + gap,
                                       [container bounds].size.width, 2*lineHeight)];
    if(isGeek){
        [hexa2SegBlock setHidden:NO];
        [hexa1SegBlock setHidden:NO];
        [hexa2SegBlock setFrame:CGRectMake(0,
                                       [deci1SegBlock frame].origin.y + [deci1SegBlock frame].size.height + gap,
                                       [container bounds].size.width,
                                       2*lineHeight)];
        [hexa1SegBlock setFrame:CGRectMake(0,
                                       [hexa2SegBlock frame].origin.y + [hexa2SegBlock frame].size.height + gap,
                                       [container bounds].size.width,
                                       2*lineHeight)];
    } else {
        [hexa2SegBlock setHidden:YES];
        [hexa1SegBlock setHidden:YES];
        [hexa1SegBlock setFrame:CGRectMake(0, 0, 0, 0)];
        [hexa2SegBlock setFrame:CGRectMake(0, 0, 0, 0)];
    }

    
    //bottom stick elements
    [resetButton setFrame:CGRectMake([container bounds].size.width / 4,
                                     [container bounds].size.height - 30,
                                     [container bounds].size.width / 2,
                                     lineHeight)];
    [totalSlider setFrame:CGRectMake(0,
                                     [resetButton frame].origin.y - lineHeight - gap,
                                     [container bounds].size.width,
                                     lineHeight)];
    
    if(isGeek){
        [hexaTotalLabel setHidden:NO];
        [hexaTotalLabel setFrame:CGRectMake([container bounds].size.width / 2,
                                        [totalSlider frame].origin.y - lineHeight - gap,
                                        [container bounds].size.width / 2,
                                        lineHeight)];
        [deciTotalLabel setFrame:CGRectMake(0,
                                        [totalSlider frame].origin.y - lineHeight - gap,
                                        [container bounds].size.width / 2,
                                        lineHeight)];
    } else {
        [hexaTotalLabel setHidden:YES];
        [hexaTotalLabel setFrame:CGRectMake(0, 0, 0, 0)];
        [deciTotalLabel setFrame:CGRectMake(0,
                                            [totalSlider frame].origin.y - lineHeight - gap,
                                            [container bounds].size.width,
                                            lineHeight)];
    }
    
}

/* ----------------- ACTIONS --------------------- */
- (void)deciSegmentAction{
    [[self controller] controlTotal: [deci2SegBlock segmentIndex] * 10 + [deci1SegBlock segmentIndex] ];
}

- (void)hexaSegmentAction{
    [[self controller] controlTotal: [hexa2SegBlock segmentIndex] * 16 + [hexa1SegBlock segmentIndex] ];
}

- (void)stepperAction{
    [[self controller] controlTotal:(int)[totalStepper value]];
}

- (void)sliderAction{
    [[self controller] controlTotal:(int)[totalSlider value]];
}

- (void)switchGeek{
    [self drawWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

- (void)resetTotal{
    [[self controller] controlTotal:0];
}


@end
