//
//  STPDizainierView.m
//  DizainierGeek
//
//  Created by Nanook on 17/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPDizainierView.h"
#import "STPSegmentBlock.h"
#import "STPLayoutConstraintBuilder.h"

@interface STPDizainierView(){
    
    UIColor *deciColor;
    UIColor *hexaColor;
    UIColor *lightColor;
    
    UIStepper *totalStepper;
    UISwitch *geekSwitch;
    
    STPSegmentBlock *deci1SegBlock, *deci2SegBlock,
                    *hexa1SegBlock, *hexa2SegBlock;
    
    UISlider *totalSlider;
    UILabel *geekLabel, *deciTotalLabel, *hexaTotalLabel;
    UIButton *resetButton;
    
    BOOL isIpad;
    BOOL isLandscape;
    BOOL isGeek;
    
    int gap;
    int lineHeight;
    
    NSMutableArray *flexConstraints;
    
}

@end

@implementation STPDizainierView

-(id)init {
    
    isIpad = ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad );
    
    self = [super init];
    
    if(self){
        gap = (isIpad)? 20: 8;
        
        //COLORS
        deciColor = [UIColor blueColor];
        hexaColor = [UIColor purpleColor];
        lightColor = [UIColor lightGrayColor];
        
        
        //setup elements
        [self setupTotalStepper];
        [self setupGeekBlock];
        [self setupResetButton];
        [self setupTotalSlider];
        [self setupTotalBlock];
        [self setupSegmentsBlocks];
        
        //add fix constraints
        [self addConstraints:[self constraintsFixForTotalStepper]];//totalStepper
        [self addConstraints:[self constraintsFixForGeekBlock]];//geekBlock
        [self addConstraints:[self constraintsFixForResetButton]];//resetButton
        [self addConstraints:[self constraintsFixForTotalSlider]];//totalSlider
        [self addConstraints:[self constraintsFixForSegments]];//segments
        
        
        //flex constraints init
        flexConstraints = [[NSMutableArray alloc]init];
        
        [self drawWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    }
    return self;
}

- (id)initWithValue:(int)val {
    self = [self init];
    
    if (self) {
        [self setValue:val];
    }

    return self;
}


/* ---------- SETUP ELEMENTS ---------- */
-(void)setupTotalStepper {
    
    totalStepper = [[UIStepper alloc] init];
    
    [totalStepper setTintColor:deciColor];
    [totalStepper setMinimumValue:0];
    [totalStepper setMaximumValue:1];
    
    [totalStepper addTarget:self action:@selector(stepperAction)
           forControlEvents:UIControlEventValueChanged];
    
    [totalStepper setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:totalStepper];
    [totalStepper release];
}

-(void)setupGeekBlock {
    //switch
    geekSwitch = [[UISwitch alloc] init];
    
    [geekSwitch setOnTintColor:hexaColor];
    [geekSwitch setOn:NO];
    
    [geekSwitch addTarget:self action:@selector(switchGeek)
         forControlEvents:UIControlEventValueChanged];
    
    [geekSwitch setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:geekSwitch];
    [geekSwitch release];
    
    
    //label
    geekLabel = [[UILabel alloc] init];
    
    [geekLabel setText:@"mode geek"];
    [geekLabel setTextAlignment:NSTextAlignmentRight];
    [geekLabel setTextColor:lightColor];
    
    [geekLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:geekLabel];
    [geekLabel release];
}


-(void)setupResetButton {
    resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [resetButton setTitle:@"RESET" forState:UIControlStateNormal];
    [resetButton setTitleColor:deciColor forState:UIControlStateNormal];
    
    [resetButton addTarget:self
                    action:@selector(resetTotal)
          forControlEvents:UIControlEventTouchDown];
    
    [resetButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:resetButton];
}

-(void)setupTotalSlider {
    totalSlider = [[UISlider alloc] init];
    
    [totalSlider setMinimumValue:0];
    [totalSlider setMaximumValue:1];
    
    [totalSlider addTarget:self
                    action:@selector(sliderAction)
          forControlEvents:UIControlEventValueChanged];
    
    [totalSlider setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:totalSlider];
    [totalSlider release];
}

-(void)setupTotalBlock{
    //deci
    deciTotalLabel = [[UILabel alloc] init];
    
    [deciTotalLabel setTextAlignment:NSTextAlignmentCenter];
    [deciTotalLabel setTextColor:deciColor];
    
    [deciTotalLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:deciTotalLabel];
    [deciTotalLabel release];

    
    //hexa
    hexaTotalLabel = [[UILabel alloc] init];

    [hexaTotalLabel setTextAlignment:NSTextAlignmentCenter];
    [hexaTotalLabel setTextColor:hexaColor];
    
    [hexaTotalLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:hexaTotalLabel];
    [hexaTotalLabel release];
}

-(void)setupSegmentsBlocks {
    NSArray *deciArray = [[NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil] retain];
    NSArray *hexaArray = [[NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"A", @"B", @"C", @"D", @"E", @"F", nil] retain];
    
    //deci rg1
    deci1SegBlock = [[STPSegmentBlock alloc] initWithItems:deciArray];
    
    [deci1SegBlock setColor:deciColor];
    [deci1SegBlock setTitle:@"Unités"];
    [deci1SegBlock addTarget:self action:@selector(deciSegmentAction)];
    
    [deci1SegBlock setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:deci1SegBlock];
    [deci1SegBlock release];
    
    
    //deci rg2
    deci2SegBlock = [[STPSegmentBlock alloc] initWithItems:deciArray];
    
    [deci2SegBlock setColor:deciColor];
    [deci2SegBlock setTitle:@"Dizaines"];
    [deci2SegBlock addTarget:self action:@selector(deciSegmentAction)];
    
    [deci2SegBlock setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:deci2SegBlock];
    [deci2SegBlock release];
    
    //hexa rg1
    hexa1SegBlock = [[STPSegmentBlock alloc] initWithItems:hexaArray];
    
    [hexa1SegBlock setColor:hexaColor];
    [hexa1SegBlock setTitle:@"RANG 1"];
    [hexa1SegBlock addTarget:self action:@selector(hexaSegmentAction)];
    
    [hexa1SegBlock setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:hexa1SegBlock];
    [hexa1SegBlock release];
    
    //hexa rg2
    hexa2SegBlock = [[STPSegmentBlock alloc] initWithItems:hexaArray];
    
    [hexa2SegBlock setColor:hexaColor];
    [hexa2SegBlock setTitle:@"RANG 2"];
    [hexa2SegBlock addTarget:self action:@selector(hexaSegmentAction)];
    
    [hexa2SegBlock setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:hexa2SegBlock];
    [hexa2SegBlock release];
    
    
    [deciArray release];
    [hexaArray release];
}
/* ---------- END SETUP ELEMENTS ---------- */



/* ---------- VALUES ---------- */
-(void)setMin:(int)min andMax:(int)max {
    [totalStepper setMinimumValue:min];
    [totalStepper setMaximumValue:max];
    [totalSlider setMinimumValue:min];
    [totalSlider setMaximumValue:max];
}

-(void)setValue:(int)val {
    [totalStepper setValue:val];
    [totalSlider setValue:val];

    [deciTotalLabel setText:[NSString stringWithFormat:@"%d", val]];
    [hexaTotalLabel setText:[NSString stringWithFormat:@"%X", val]];
    
    if(val == 42){
        [deciTotalLabel setBackgroundColor:lightColor];
        [hexaTotalLabel setBackgroundColor:lightColor];
    } else {
        [deciTotalLabel setBackgroundColor:[UIColor clearColor]];
        [hexaTotalLabel setBackgroundColor:[UIColor clearColor]];
    }

    [deci2SegBlock setSegmentIndex:val / 10];
    [deci1SegBlock setSegmentIndex:val % 10];
    [hexa2SegBlock setSegmentIndex:val / 16];
    [hexa1SegBlock setSegmentIndex:val % 16];
    
    [UIView animateWithDuration:0.4f animations:^{[self layoutIfNeeded];}];
}
/* ---------- END VALUES ---------- */



/* ---------- DRAW INTERFACE ---------- */
-(void) drawWithOrientation:(UIInterfaceOrientation)orientation {
    
    isLandscape = (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight);
    
    isGeek = geekSwitch.on;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if(isLandscape){
        [self setFrame:CGRectMake(0, 0, screenBounds.size.height, screenBounds.size.width)];
    } else {
        [self setFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
    }
    
    int margin = (isIpad)? 60 : 20;
    [self setBounds:CGRectMake(margin, margin,
                               [self frame].size.width - 2 * margin,
                               [self frame].size.height - 2 * margin)];
    
    /* ----- flex constraints ----- */
    [self removeConstraints:flexConstraints];

    [flexConstraints removeAllObjects];

    //total block
    [flexConstraints addObjectsFromArray:[self constraintsFlexForTotalBlocks]];
    
    //segments
    [flexConstraints addObjectsFromArray:[self constraintsFlexForSegments]];
    
    [self addConstraints:flexConstraints];
    /* ----- end flex constraints ----- */
    
    [UIView animateWithDuration:0.8f animations:^{[self layoutIfNeeded];}];
    
}





/* ---------- SETUP CONSTRAINTS -------- */
-(NSArray*) constraintsFixForTotalStepper {
    return [STPLayoutConstraintBuilder
            insideTopLeftfor:totalStepper inside:self padding:0];
}

-(NSArray*) constraintsFixForGeekBlock {
    return [NSArray arrayWithObjects:
            [STPLayoutConstraintBuilder fixTop:geekSwitch
                                         toTop:self withConstant:0],
            [STPLayoutConstraintBuilder fixRight:geekSwitch
                                         toRight:self withConstant:0],
            [STPLayoutConstraintBuilder fixCenterY:geekLabel
                                         toCenterY:geekSwitch withConstant:0],
            [STPLayoutConstraintBuilder fixRight:geekLabel
                                          toLeft:geekSwitch withConstant:-gap],
            nil];
}

-(NSArray*) constraintsFixForResetButton {
    NSMutableArray *c = [[NSMutableArray alloc]
                         initWithArray:[STPLayoutConstraintBuilder
                                        insideLeftRightBorders:resetButton inside:self padding:0]];
    [c addObject:[STPLayoutConstraintBuilder fixBottom:resetButton toBottom:self withConstant:0]];
    return [c autorelease];
}

-(NSArray*) constraintsFixForTotalSlider {
    NSMutableArray *c = [[NSMutableArray alloc]
                         initWithArray:[STPLayoutConstraintBuilder
                                        insideLeftRightBorders:totalSlider inside:self padding:0]];
    [c addObject:[STPLayoutConstraintBuilder fixBottom:totalSlider
                                                 toTop:resetButton withConstant:-gap]];
    return [c autorelease];
}

-(NSArray*) constraintsFlexForTotalBlocks {
    NSMutableArray *c = [[NSMutableArray alloc]init];
    
    if(!isIpad && !isLandscape){
        //w hexa full
        [c addObjectsFromArray:[STPLayoutConstraintBuilder
                                insideLeftRightBorders:hexaTotalLabel inside:deciTotalLabel padding:0]];
        //v hexa
        [c addObject:[STPLayoutConstraintBuilder fixBottom:hexaTotalLabel
                                                     toTop:totalSlider withConstant:-gap]];
        //w deci full
        [c addObjectsFromArray:[STPLayoutConstraintBuilder
                                insideLeftRightBorders:deciTotalLabel inside:resetButton padding:0]];
        //v deci
        [c addObject:[STPLayoutConstraintBuilder fixBottom:deciTotalLabel
                                                     toTop:hexaTotalLabel withConstant:-gap]];
    } else {
        //v deci
        [c addObject:[STPLayoutConstraintBuilder fixBottom:deciTotalLabel
                                                     toTop:totalSlider withConstant:-gap]];
        if(isGeek){
            //v hexa = v deci
            [c addObject:[STPLayoutConstraintBuilder fixBottom:hexaTotalLabel
                                                      toBottom:deciTotalLabel withConstant:0]];
            //deci to left
            [c addObject:[STPLayoutConstraintBuilder fixLeft:deciTotalLabel
                                                      toLeft:resetButton withConstant:0]];
            //hexa to right
            [c addObject:[STPLayoutConstraintBuilder fixRight:hexaTotalLabel
                                                      toRight:resetButton withConstant:0]];
            //deci right -> hexa left
            [c addObject:[STPLayoutConstraintBuilder fixRight:deciTotalLabel
                                                       toLeft:hexaTotalLabel withConstant:-gap]];
            
            //w hexa = 1.6 * v deci = full  [--][----]
            [c addObject:[NSLayoutConstraint
                          constraintWithItem:hexaTotalLabel attribute:NSLayoutAttributeWidth
                          relatedBy:NSLayoutRelationEqual
                          toItem:deciTotalLabel attribute:NSLayoutAttributeWidth
                          multiplier:1.6 constant:0]];
        } else {
            //w deci full
            [c addObjectsFromArray:[STPLayoutConstraintBuilder
                                    insideLeftRightBorders:deciTotalLabel inside:resetButton padding:0]];
        }
    }
    
    [hexaTotalLabel setHidden:(!isGeek)];

    return [c autorelease];
}


-(NSArray*) constraintsFixForSegments {
    return [NSArray arrayWithObjects:
            //left & right deci1 = left & right deci 2
            [STPLayoutConstraintBuilder fixLeft:deci1SegBlock
                                         toLeft:deci2SegBlock withConstant:0],
            [STPLayoutConstraintBuilder fixRight:deci1SegBlock
                                         toRight:deci2SegBlock withConstant:0],
            //left & right hexa 1 = left & right hexa 2
            [STPLayoutConstraintBuilder fixLeft:hexa1SegBlock
                                         toLeft:hexa2SegBlock withConstant:0],
            [STPLayoutConstraintBuilder fixRight:hexa1SegBlock
                                         toRight:hexa2SegBlock withConstant:0],
            //top deci2
            [STPLayoutConstraintBuilder fixTop:deci2SegBlock
                                      toBottom:totalStepper withConstant:gap],
            //top deci1 -> bottom deci2
            [STPLayoutConstraintBuilder fixTop:deci1SegBlock
                                      toBottom:deci2SegBlock withConstant:gap],
            //top hexa1 -> bottom hexa2
            [STPLayoutConstraintBuilder fixTop:hexa1SegBlock
                                      toBottom:hexa2SegBlock withConstant:gap],
            nil];
}
-(NSArray*) constraintsFlexForSegments {
    
    int blockHeight = (isIpad)? 80 : 60;
    
    //height of segmentBlocks (constraint in subview)
    [deci1SegBlock setMinHeight:blockHeight];
    [deci2SegBlock setMinHeight:blockHeight];
    [hexa1SegBlock setMinHeight:blockHeight];
    [hexa2SegBlock setMinHeight:blockHeight];
    
    NSMutableArray *c = [[NSMutableArray alloc]init];
    

    if(!isIpad && !isLandscape){
        //top hexa2 -> bottom deci1
        [c addObject:[STPLayoutConstraintBuilder fixTop:hexa2SegBlock
                                               toBottom:deci1SegBlock withConstant:gap]];
        //left right full
        [c addObjectsFromArray:[STPLayoutConstraintBuilder
                                insideLeftRightBorders:deci2SegBlock inside:resetButton padding:0]];
        [c addObjectsFromArray:[STPLayoutConstraintBuilder
                                insideLeftRightBorders:hexa2SegBlock inside:deci2SegBlock padding:0]];
    } else {
        //top hexa2 -> top deci2
        [c addObject:[STPLayoutConstraintBuilder fixTop:hexa2SegBlock
                                                  toTop:deci2SegBlock withConstant:0]];
        //left right deci2 -> left right decitotal
        [c addObjectsFromArray:[STPLayoutConstraintBuilder
                                insideLeftRightBorders:deci2SegBlock
                                inside:deciTotalLabel padding:0]];
        //left right hexa2 -> left right hexatotal
        [c addObjectsFromArray:[STPLayoutConstraintBuilder
                                insideLeftRightBorders:hexa2SegBlock
                                inside:hexaTotalLabel padding:0]];
    }
    
    [hexa2SegBlock setHidden:(!isGeek)];
    [hexa1SegBlock setHidden:(!isGeek)];
    
    return [c autorelease];
}









/* ----------------- ACTIONS --------------------- */
- (void)deciSegmentAction{
    [[self controller]
        controlTotal: [deci2SegBlock segmentIndex] * 10 + [deci1SegBlock segmentIndex] ];
}

- (void)hexaSegmentAction{
    [[self controller]
        controlTotal: [hexa2SegBlock segmentIndex] * 16 + [hexa1SegBlock segmentIndex] ];
}

- (void)stepperAction{
    [[self controller]
        controlTotal:(int)[totalStepper value]];
}

- (void)sliderAction{
    [[self controller]
        controlTotal:(int)[totalSlider value]];
}

- (void)switchGeek{
    [self drawWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

- (void)resetTotal{
    [[self controller] controlTotal:0];
}




-(void)dealloc {
    [_controller release]; _controller = nil;
    [deciColor release]; deciColor = nil;
    [hexaColor release]; hexaColor = nil;
    [lightColor release];lightColor = nil;
    [totalStepper release];totalStepper = nil;
    [geekSwitch release];geekSwitch = nil;
    [deci1SegBlock release];deci1SegBlock = nil;
    [deci2SegBlock release];deci2SegBlock = nil;
    [hexa1SegBlock release];hexa1SegBlock = nil;
    [hexa2SegBlock release];hexa2SegBlock = nil;
    [totalSlider release];totalSlider = nil;
    [geekLabel release];geekLabel = nil;
    [deciTotalLabel release];deciTotalLabel = nil;
    [hexaTotalLabel release];hexaTotalLabel = nil;
    [resetButton release];resetButton = nil;
    [flexConstraints release];flexConstraints = nil;
    [super dealloc];
}

@end
