//
//  ViewController.m
//  wall2
//
//  Created by Sathish Chinniah on 28/12/15.
//  Copyright © 2015 Sathish Chinniah. All rights reserved.
//
//////
#import "ViewController.h"
#import "Global.h"
#import "UUChart.h"
#import "UUBarChart.h"

@interface ViewController ()<UUChartDataSource>

{
    
    NSDate *firstdate;
    
    Global *global;
    
    CGMutablePathRef circlePath;
    
    
   // NSDate *firstdate;
    UUChart *chart;
    int path;
    
    int arrNum;
    
    int asd;
    
    NSArray *arrJanuary1,*arrJanuary2,*arrDecember1,*arrDecember2,*arrNovember1,*arrNovember2;

}

@end

@implementation ViewController
@synthesize flabel;
@synthesize slabel;
@synthesize tlabel;
@synthesize folabel;
@synthesize fivlabel;
@synthesize sixlabel;
@synthesize sevenlabel;
@synthesize dateLabel;
//@synthesize walletView;
@synthesize leftBtn;
@synthesize rightBtn;
@synthesize Customscrollview;
@synthesize tableView;





- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    // Do any additional setup after loading the view, typically from a nib.
    //    firstdate = [NSDate date];
    //    firstdate = [NSDate dateWithTimeInterval:-(5*86400) sinceDate:firstdate];
    
    arrNum = 0;
    
    firstdate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:-6 toDate:[NSDate date] options:nil];
    //
    [self monthArray];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM,yyyy"];
    dateLabel.text = [dateFormat stringFromDate:[NSDate date]];
    dateLabel.text = [dateFormat stringFromDate: firstdate];
    
    
    
    [self dateChange];
    
    
    
    [self setFrame];
    
    chart.layer.borderColor = [UIColor grayColor].CGColor;
    chart.layer.borderWidth = 1.0f;
    [chart showInView:self.view];

    
    
    NSArray *jsonObject;
    jsonObject = @[@{@"Id1":@"mad",
                     @"people1":@"300",@"cost":@"300"},
                   @{@"Id2":@"normal",
                     @"people2":@"9",@"total2":@6}];
    
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
    
    
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &err];
    
    
    global = [Global shareInstance];
    
    
    NSDictionary *dict = [jsonArray objectAtIndex:0];
    NSDictionary *dict2 = [jsonArray objectAtIndex:1];
    
    _lblCost1.text = [dict objectForKey:@"cost"];

    _lblCost2.text = [dict objectForKey:@"cost"];

    _lblSubCost1.text = [NSString stringWithFormat:@"(₹%@)",[dict objectForKey:@"cost"]];

    _lblSubCost2.text = [NSString stringWithFormat:@"(₹%@)",[dict objectForKey:@"cost"]];
    
    global.numDays = [NSNumber numberWithInteger:[[dict2 objectForKey:@"total2"] integerValue]];

    
    
    _lblLeftDays.text = [NSString stringWithFormat:@"%ld Days To Expire",[[dict2 objectForKey:@"total2"] integerValue]];
    
    
    // Distance between dots on circular path
    
            _arrowViewGreen.interval = 9.5;
            _arrowViewBlue.interval = 9.5;
    
    
    
    
    
    
    

    
    

    
}

-(void)viewDidAppear:(BOOL)animated
{
    sevenlabel.frame = CGRectMake(sevenlabel.frame.origin.x-8, sevenlabel.frame.origin.y, sevenlabel.frame.size.width, sevenlabel.frame.size.height);
    // Setting circle height and width here according to device size
    
    switch ((int)[UIScreen mainScreen].bounds.size.height) {
        case 480:
        {
            _ImgYConstraint1.constant = _ImgYConstraint1.constant+15;
            _ImgYConstraint2.constant = _ImgYConstraint2.constant+15;

            break;
        }
        case 568:
        {
            _ImgYConstraint1.constant = _ImgYConstraint1.constant+15;
            _ImgYConstraint2.constant = _ImgYConstraint2.constant+15;
            break;
        }
        case 667:
        {
            _widthConstraint.constant = 140;
            _heightConstraint.constant = 140;
            _ImgYConstraint1.constant = _ImgYConstraint1.constant+38;
            _ImgYConstraint2.constant = _ImgYConstraint2.constant+38;

            break;
        }
        case 736:
        {

            _widthConstraint.constant = 160;
            _heightConstraint.constant = 160;
            _ImgYConstraint1.constant = _ImgYConstraint1.constant+47;
            _ImgYConstraint2.constant = _ImgYConstraint2.constant+47;
            break;
        }
            
        default:
            break;
    }
    
    [self.view layoutIfNeeded];
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    
//    sevenlabel.frame = CGRectMake(sevenlabel.frame.origin.x-8, sevenlabel.frame.origin.y, sevenlabel.frame.size.width, sevenlabel.frame.size.height);
//}

-(void)setFrame
{
    switch ((int)[UIScreen mainScreen].bounds.size.height) {
        case 480:
        {
            chart = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(-1,self.view.frame.size.height- 270,[UIScreen mainScreen].bounds.size.width+5, 265) withSource:self
                                                   withStyle:UUChartBarStyle];
            break;
        }
        case 568:
        {
            chart = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(-1,self.view.frame.size.height- 270,[UIScreen mainScreen].bounds.size.width+5, 265) withSource:self
                                                   withStyle:UUChartBarStyle];
            break;
        }
        case 667:
        {
            chart = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(-1,self.view.frame.size.height- 270,[UIScreen mainScreen].bounds.size.width+5, 265) withSource:self
                                                   withStyle:UUChartBarStyle];
            break;
        }
        case 736:
        {
            chart = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(-1,self.view.frame.size.height- 270,[UIScreen mainScreen].bounds.size.width+5, 265) withSource:self
                                                   withStyle:UUChartBarStyle];
            
            break;
        }
        default:
            break;
    }
}

-(void)dateChange
{
    NSArray *labelArray = @[flabel, slabel, tlabel, folabel, fivlabel,sixlabel,sevenlabel];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    dateFormatter.dateFormat = @"ddMMM";
    for (NSInteger i = 0; i < 7; ++i) {
        NSDate *nextDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:i toDate:firstdate options:nil];
        UILabel *label = (UILabel *)labelArray[i];
        label.text = [dateFormatter stringFromDate:nextDate];
        if (i==6) {
            dateFormatter.dateFormat=@"MMM,yyyy";
            dateLabel.text = [[dateFormatter stringFromDate:nextDate] capitalizedString];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            
            if ([[dateFormat stringFromDate:nextDate] isEqualToString:[dateFormat stringFromDate:[NSDate date]]])
            {
                rightBtn.enabled = false;
                
                //It's the same day
                
            }
            else
            {
                rightBtn.enabled = true;
            }
        }
    }
}
- (IBAction)calRight:(id)sender {
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    firstdate = [calendar dateByAddingUnit:NSCalendarUnitDay value:7 toDate:firstdate options:nil];
    [self dateChange];
    //////
    
    NSDate *thisDate = [NSDate date];
    
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:thisDate];
    
    
    
    [self setFrame];
    
    chart.layer.borderColor = [UIColor grayColor].CGColor;
    chart.layer.borderWidth = 1.0f;
    [chart showInView:self.view];
    
    
}

- (IBAction)calLeft:(id)sender {
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    firstdate = [calendar dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:firstdate options:nil];
    
    [self dateChange];
    
    
    
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:firstdate];
    
    [self setFrame];
    
    
    chart.layer.borderColor = [UIColor grayColor].CGColor;
    chart.layer.borderWidth = 1.0f;
    [chart showInView:self.view];
    
}


#pragma mark
#pragma mark-ChartView Methods

- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    return CGRangeMake(10000, 0);
}

- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}


- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    
    return @[@"Jan11",@"Jan12",@"Jan13",@"Jan14",@"Jan15",@"Jan16",@"Jan17",@"Jan18",@"Jan19",@"Jan20",@"Jan21",@"Jan22",@"Jan23",@"Jan24"];
}

- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    //    NSArray *ary1 = @[@"2",@"4",@"6",@"8",@"10",@"12",@"14",@"16",@"14",@"12",@"10",@"8",@"6",@"4",@"2",@"2",@"14"];
    //    NSArray *ary2 = @[@"4",@"8",@"16",@"20",@"24",@"28",@"32",@"36",@"32",@"28",@"24",@"20",@"16",@"12",@"8",@"4"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:firstdate options:nil];
    
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:newDate];
    if(![self isDataAvailableAtDate:dateComp])
    {
        _lblUsage.hidden = NO;
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        [window addSubview:_lblUsage];
        
        
        return @[];
    }
    
    _lblUsage.hidden = YES;
    if(dateComp.month == 1)
    {
        return @[[arrJanuary1 objectAtIndex:0],[arrJanuary1 objectAtIndex:1]];
    }
    else if(dateComp.month == 12)
    {
        return @[[arrDecember1 objectAtIndex:0],[arrDecember1 objectAtIndex:1]];
    }
    else
    {
        return @[[arrNovember1 objectAtIndex:0],[arrNovember1 objectAtIndex:1]];
    }
    return @[[self generateArray],[self generateArray]];
}

//-(void)generateWeekDataForDate:(NSDate *)date
//{
//    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
//
//    NSInteger weeks = [self weeksOfMonth:dateComp.month inYear:dateComp.year];
//
//  //  if(dateComp.month == )
//
//}

//- (NSInteger)weeksOfMonth:(int)month inYear:(int)year{
//    NSString *dateString=[NSString stringWithFormat:@"%4d/%d/1",year,month];
//
//    NSDateFormatter *dfMMddyyyy=[NSDateFormatter new];
//    [dfMMddyyyy setDateFormat:@"yyyy/MM/dd"];
//    NSDate *date=[dfMMddyyyy dateFromString:dateString];
//
//    NSCalendar *calender = [NSCalendar currentCalendar];
//    NSRange weekRange = [calender rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
//    NSInteger weeksCount=weekRange.length;
//
//    return weeksCount;
//}
-(void)monthArray
{
    arrJanuary1 = @[@[@"1500",@"3500",@"5000",@"4700",@"8000",@"1200",@"9000"],@[@"3150",@"6543",@"7834",@"5450",@"1100",@"8008",@"4567"],@[@"3234",@"7456",@"5345",@"5453",@"3234",@"4678",@"6211",@"1200",@"3211",@"7000",@"6000",@"2500",@"5000",@"7000"]];
    
    
    
    arrDecember1 = @[@[@"1200",@"4200",@"6200",@"7200",@"8000",@"9450",@"2100"],@[@"7200",@"2500",@"3500",@"1300",@"5500",@"6500",@"9000"],@[@"4145",@"3000",@"4500",@"5100",@"9009",@"2500",@"6700"],@[@"5500",@"8000",@"7600",@"4000",@"6000",@"8234",@"4678"]];
    
    
    
    arrNovember1 = [[arrDecember1 reverseObjectEnumerator] allObjects];
}

-(NSArray *)generateArray
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:firstdate options:nil];
    
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:newDate];
    
    if(dateComp.month == 1)
    {
        return arrJanuary1;
    }
    else if (dateComp.month == 12)
    {
        return arrDecember1;
    }
    else
    {
        return arrNovember1;
    }
    
    
    return nil;
}

-(BOOL)isDataAvailableAtDate:(NSDateComponents *)date
{
    if(date.day > 1 && date.day < 10)
    {
        return NO;
    }
    if(date.month<11 && date.year<2016)
    {
        return NO;
    }
    
    return YES;
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUBlue, UUGreen];
}

//-(void)dateChange
//{
//    NSArray *labelArray = @[flabel, slabel, tlabel, folabel, fivlabel,sixlabel,sevenlabel];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    dateFormatter.dateFormat = @"ddMMM";
//    for (NSInteger i = 0; i < 7; ++i) {
//        NSDate *nextDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:i toDate:firstdate options:nil];
//        UILabel *label = (UILabel *)labelArray[i];
//        label.text = [dateFormatter stringFromDate:nextDate];
//        if (i==6) {
//            dateFormatter.dateFormat=@"MMM,yyyy";
//            dateLabel.text = [[dateFormatter stringFromDate:nextDate] capitalizedString];
//            
//            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//            [dateFormat setDateFormat:@"yyyy-MM-dd"];
//            
//            if ([[dateFormat stringFromDate:nextDate] isEqualToString:[dateFormat stringFromDate:[NSDate date]]])
//            {
//                rightBtn.enabled = false;
//                //It's the same day
//            }
//            else
//            {
//                rightBtn.enabled = true;
//            }
//        }
//    }
//}
//- (IBAction)calRight:(id)sender {
//    
//    
//    /////
//    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    firstdate = [calendar dateByAddingUnit:NSCalendarUnitDay value:7 toDate:firstdate options:nil];
//    [self dateChange];
//    //////
//    
//    
//}
//
//- (IBAction)calLeft:(id)sender {
//    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    firstdate = [calendar dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:firstdate options:nil];
//    [self dateChange];
//    
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)createCircularPath
//{
//    circlePath = CGPathCreateMutable();
//    
//    CGPathMoveToPoint(circlePath, nil, _viewGreen.center.x, _viewGreen.center.y);
//    
//    CGPathAddEllipseInRect(circlePath, nil, CGRectMake(_viewGreen.bounds.origin.x+10, _viewGreen.bounds.origin.y+10, _viewGreen.bounds.size.width-20, _viewGreen.bounds.size.height-20));
//    
//    CAShapeLayer *cLayer = [CAShapeLayer layer];
//    
//    cLayer.path = circlePath;
//    
//    cLayer.strokeColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotb.png"]] CGColor];
//    
//    [_viewGreen.layer addSublayer:cLayer];
//    
////   UIImage *img =  [self maskImage:[UIImage imageNamed:@"dotb.png"] toPath:[UIBezierPath bezierPathWithCGPath:circlePath]];
////    
//    CGPathRelease(circlePath);
//    
//}
//
//
//- (UIImage *)maskImage:(UIImage *)originalImage toPath:(UIBezierPath *)path {
//    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0);
//    [path addClip];
//    [originalImage drawAtPoint:CGPointZero];
//    UIImage *maskedImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return maskedImage;
//}

@end
