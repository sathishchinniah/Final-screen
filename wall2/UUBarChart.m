//
//  UUBarChart.m
//  UUChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUBarChart.h"
#import "UUChartLabel.h"
#import "UUBar.h"

@interface UUBarChart ()
{
    UIScrollView *myScrollView;
    
    UIView *view1,*view2,*view3;
}
@end

@implementation UUBarChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
//        myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(UUYLabelwidth, 0, frame.size.width-UUYLabelwidth, frame.size.height)];
        
        // graph scroll view
        myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(30, 0, frame.size.width-30, frame.size.height)];
        
        view1 = [[UIView alloc]initWithFrame:CGRectMake(-myScrollView.frame.size.width,0, myScrollView.frame.size.width, myScrollView.frame.size.height)];
        
       view2 = [[UIView alloc]initWithFrame:CGRectMake(0,0, myScrollView.frame.size.width, myScrollView.frame.size.height)];
        
        view3 = [[UIView alloc]initWithFrame:CGRectMake(myScrollView.frame.size.width,0, myScrollView.frame.size.width, myScrollView.frame.size.height)];
        
        view1.backgroundColor = [UIColor clearColor];

        view2.backgroundColor = [UIColor clearColor];

        view3.backgroundColor = [UIColor clearColor];
        
        [myScrollView addSubview:view1];

        [myScrollView addSubview:view2];

        [myScrollView addSubview:view3];

        
        
        myScrollView.userInteractionEnabled=YES;
       
            myScrollView.showsHorizontalScrollIndicator = NO;
        
            //myScrollView.userInteractionEnabled=NO;

        [self addSubview:myScrollView];
    }
    return self;
}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];
}

-(void)setYLabels:(NSArray *)yLabels
{
    NSInteger max = 0;
    NSInteger min = 1000000000;
    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            NSInteger value = [valueString integerValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    if (max < 5) {
        max = 5;
    }
    if (self.showRange) {
        _yValueMin = (int)min;
    }else{
        _yValueMin = 0;
    }
    _yValueMax = (int)max;
    
    if (_chooseRange.max!=_chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }
    

    float level = (_yValueMax-_yValueMin) /4.0;
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight /4.0;
    
    for (int i=0; i<5; i++) {
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(0.0,chartCavanHeight-i*levelHeight+5, self.frame.size.width, UULabelHeight)];
        label.textAlignment = NSTextAlignmentLeft;
        label.frame = CGRectMake(label.frame.origin.x+10,label.frame.origin.y+15,label.frame.size.width,label.frame.size.height);
        
        switch (i) {
            case 0:
            {
                label.text = @"0";

                break;
            }
            case 1:
            {
                label.text = @"500";
                break;
            }
            case 2:
            {
                label.text = @"1000";
                break;
            }
            case 3:
            {
                label.text = @"5000";
                break;
            }
            case 4:
            {
                label.text = @"10000";
                break;
            }
                
            default:
                break;
        }
        
//		label.text = [NSString stringWithFormat:@"%.1f",level * i+_yValueMin];
        
        // this will hide the label of y axis
		[self addSubview:label];
        [self drawBottomLayer:label];
    }
	
}

-(void)drawBottomLayer:(UILabel *)label
{
    CALayer *layer = [CALayer layer];
    
    layer.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y+label.frame.size.height, label.frame.size.width, 2.0);
    
    layer.backgroundColor = [[UIColor colorWithRed:(204/255.0) green:(204/255.0) blue:(204/255.0) alpha:1.0 ] CGColor];
    
    [self.layer addSublayer:layer];
}

-(void)setXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;
    NSInteger num;
    if (xLabels.count>=8) {
        num = 8;
    }else if (xLabels.count<=4){
        num = 4;
    }else{
        num = xLabels.count;
    }
    _xLabelWidth = myScrollView.frame.size.width/num;
    
    
    // remove lables for x axis
    
    for (int i=0; i<xLabels.count; i++) {
        
//        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake((i *  _xLabelWidth ), self.frame.size.height - UULabelHeight, _xLabelWidth, UULabelHeight)];
        
        
       // UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(0,0,20,30)];
        
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake((i *  _xLabelWidth ), self.frame.size.height - UULabelHeight, _xLabelWidth, UULabelHeight)];
        
    
        label.text = xLabels[i];
        
        // this will hide the label for xaxis
        [myScrollView addSubview:label];
        label.hidden = YES;
        
        
    }
    
    float max = (([xLabels count]-1)*_xLabelWidth + chartMargin)+_xLabelWidth;
    if (myScrollView.frame.size.width < max-10) {
        myScrollView.contentSize = CGSizeMake(max, self.frame.size.height);
    }
}
-(void)setColors:(NSArray *)colors
{
	_colors = colors;
}
- (void)setChooseRange:(CGRange)chooseRange
{
    _chooseRange = chooseRange;
}
-(void)strokeChart
{

    CGRect oldFrame;
    
    BOOL first = false;
    
    int num;
    num = 1;
    
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
    
    CGFloat distanceOne = [self getDistanceFactorOne];
    
    CGFloat distaceTwo = [self getDistanceFactorTwo];
	
    for (int i=0; i<_yValues.count; i++) {
        if (i==2)
            return;
        NSArray *childAry = _yValues[i];
        for (int j=0; j<childAry.count; j++) {
            NSString *valueString = childAry[j];
            float value = [valueString floatValue];
            float grade = ((float)value-_yValueMin) / ((float)_yValueMax-_yValueMin);
            
//            UUBar * bar = [[UUBar alloc] initWithFrame:CGRectMake((j+(_yValues.count==1?0.1:0.05))*_xLabelWidth +i*_xLabelWidth * 0.47, UULabelHeight, _xLabelWidth * (_yValues.count==1?0.8:0.45), chartCavanHeight)];
            if(!first)
            {
                UUBar * bar = [[UUBar alloc] initWithFrame:CGRectMake((j+(_yValues.count==1?0.1:0.05))*_xLabelWidth +i*_xLabelWidth * 0.47, 26, 40 * (_yValues.count==1?0.8:0.45), chartCavanHeight)];
                
                bar.frame = CGRectMake(bar.frame.origin.x, bar.frame.origin.y+5, bar.frame.size.width, bar.frame.size.height);
                
                oldFrame = bar.frame;
                
                first = YES;

                num++;
                
                bar.barColor = UUBlue;
                bar.grade = grade;
                [view2 addSubview:bar];
            }
            else
            {
                if(num%2==0)
                {
                    UUBar * bar = [[UUBar alloc] initWithFrame:CGRectMake((j+(_yValues.count==1?0.1:0.05))*_xLabelWidth +i*_xLabelWidth * 0.47, 26, 40 * (_yValues.count==1?0.8:0.45), chartCavanHeight)];
                    
                    bar.frame = CGRectMake(oldFrame.origin.x+oldFrame.size.width+distanceOne, bar.frame.origin.y+5, bar.frame.size.width, bar.frame.size.height);
                    
                    oldFrame = bar.frame;
                    
                    num++;
                    
                    bar.barColor = UUGreen;
                    bar.grade = grade;
                    [view2 addSubview:bar];
                }
                else
                {
                    UUBar * bar = [[UUBar alloc] initWithFrame:CGRectMake((j+(_yValues.count==1?0.1:0.05))*_xLabelWidth +i*_xLabelWidth * 0.47, 26, 40 * (_yValues.count==1?0.8:0.45), chartCavanHeight)];
                    
                    bar.frame = CGRectMake(oldFrame.origin.x+oldFrame.size.width+distaceTwo, bar.frame.origin.y+5, bar.frame.size.width, bar.frame.size.height);
                    
                    oldFrame = bar.frame;
                    
                    num++;
                    
                    bar.barColor = UUBlue;
                    bar.grade = grade;
                    [view2 addSubview:bar];
                }

            }

            
            
//            UUBar * bar = [[UUBar alloc] initWithFrame:CGRectMake((j+(_yValues.count==1?0.1:0.05))*_xLabelWidth +i*_xLabelWidth * 0.47, UULabelHeight, 17, chartCavanHeight)];
//            
//  UUBar * bar = [[UUBar alloc] initWithFrame:CGRectMake((j+(_yValues.count==1?0.1:0.05))*_xLabelWidth +i*_xLabelWidth * 0.47, 26, 17, chartCavanHeight)];
//            
//    
        

            
        }
    }
    
    [self bringSubviewToFront:myScrollView];
    
    [myScrollView scrollRectToVisible:view1.frame animated:YES];
}

-(CGFloat)getDistanceFactorOne
{
    switch ((int)[UIScreen mainScreen].bounds.size.height) {
        case 480:
        {
            return 0.8;
            break;
        }
        case 568:
        {
            return 0.8;

            break;
        }
        case 667:
        {
            return 2.0;

            break;
        }
        case 736:
        {
            return 3.0;

            break;
        }
        default:
            break;
    }
    
    return 0.0;
}
-(CGFloat)getDistanceFactorTwo
{
    switch ((int)[UIScreen mainScreen].bounds.size.height) {
        case 480:
        {
            return 3.0;
            break;
        }
        case 568:
        {
            return 3.0;
            
            break;
        }
        case 667:
        {
            return 9.0;
            
            break;
        }
        case 736:
        {
            return 13.0;
            
            break;
        }
        default:
            break;
    }
    
    return 0.0;
}


@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 
