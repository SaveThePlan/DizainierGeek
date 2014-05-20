//
//  STPSegmentBox.m
//  DizainierGeek
//
//  Created by Nanook on 19/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPSegmentBox.h"
#import "STPSegmentBlock.h"
@interface STPSegmentBox(){
    STPSegmentBlock *deci1SegBlock,
                    *deci2SegBlock,
                    *hexa1SegBlock,
                    *hexa2SegBlock;
    BOOL isGeek;
}

@end

@implementation STPSegmentBox

- (id)init {
    self = [super init];
    if (self) {
        
        NSArray *deciArray = [[NSArray arrayWithObjects: @"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil] retain];
        NSArray *hexaArray = [[NSArray arrayWithObjects: @"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", @"A", @"B", @"C", @"D", @"E", @"F", nil] retain];
        
        deci2SegBlock = [[STPSegmentBlock alloc] initWithItems:deciArray];
        [deci2SegBlock setTitle:@"Dizaines"];
        [deci2SegBlock setColor:[UIColor blueColor]];
        [self addSubview:deci2SegBlock];
        
        deci1SegBlock = [[STPSegmentBlock alloc] initWithItems:deciArray];
        [deci1SegBlock setTitle:@"Unités"];
        [deci1SegBlock setColor:[UIColor blueColor]];
        [self addSubview:deci1SegBlock];
        
        hexa2SegBlock = [[STPSegmentBlock alloc] initWithItems:hexaArray];
        [hexa2SegBlock setTitle:@"Rang 2 hexa"];
        [hexa2SegBlock setColor:[UIColor purpleColor]];
        [self addSubview:hexa2SegBlock];
        
        hexa1SegBlock = [[STPSegmentBlock alloc] initWithItems:hexaArray];
        [hexa1SegBlock setTitle:@"Rang 1 hexa"];
        [hexa1SegBlock setColor:[UIColor purpleColor]];
        [self addSubview:hexa1SegBlock];

        //free memory
        [deci1SegBlock release];
        [deci2SegBlock release];
        [hexa1SegBlock release];
        [hexa2SegBlock release];
        [deciArray release];
        [hexaArray release];
    }
    return self;
}

-(void)setIsGeek:(BOOL)geek {
    isGeek = geek;
}

-(void)setDeciAction:(id)target action:(SEL)action{
    [deci1SegBlock addTarget:target action:action];
    [deci2SegBlock addTarget:target action:action];
}

-(void)setHexaAction:(id)target action:(SEL)action {
    [hexa1SegBlock addTarget:target action:action];
    [hexa2SegBlock addTarget:target action:action];
}

- (int)getValueDeci{
    return [deci2SegBlock segmentIndex] * 10 + [deci1SegBlock segmentIndex];
}

- (int)getValueHexa{
    return [hexa2SegBlock segmentIndex] * 16 + [hexa1SegBlock segmentIndex];
}

-(void)setValue:(int)val{
    [deci1SegBlock setSegmentIndex: val % 10];
    [deci2SegBlock setSegmentIndex: val / 10];
    [hexa1SegBlock setSegmentIndex: val % 16];
    [hexa2SegBlock setSegmentIndex: val / 16];
}

-(void)setFrame:(CGRect)frame {
    
    int lineHeight = frame.size.height;
    
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y,
                               frame.size.width, lineHeight * 8 + 3 * _gap)];

    int frameX = [self bounds].origin.x;
    int frameY = [self bounds].origin.y;
    int frameW = [self bounds].size.width;
    int frameH = [self bounds].size.height;

    [deci2SegBlock setFrame:CGRectMake(frameX, frameY, frameW, 2 * lineHeight)];
    [deci1SegBlock setFrame:CGRectMake(frameX,
                                       [deci2SegBlock frame].origin.y + [deci2SegBlock frame].size.height + _gap,
                                       frameW, 2 * lineHeight)];
    
    if(isGeek){
        [hexa2SegBlock setHidden:NO];
        [hexa1SegBlock setHidden:NO];
        
        [hexa2SegBlock setFrame:CGRectMake(x,
                                           [deci1SegBlock frame].origin.y + [deci1SegBlock frame].size.height + gap,
                                           w,
                                           2 * lineHeight)];
        
        [hexa1SegBlock setFrame:CGRectMake(x,
                                           [hexa2SegBlock frame].origin.y + [hexa2SegBlock frame].size.height + gap,
                                           w,
                                           2 * lineHeight)];
    } else {
        [hexa2SegBlock setHidden:YES];
        [hexa1SegBlock setHidden:YES];
        [hexa1SegBlock setFrame:CGRectMake(0, 0, 0, 0)];
        [hexa2SegBlock setFrame:CGRectMake(0, 0, 0, 0)];
    }
    
}


@end
