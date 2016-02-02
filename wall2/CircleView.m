//
//  CircleView.m
//
//
//  Created by Divyanshu Sharma on 27/01/16.
//  Copyright (c) 2016 Divyanshu Sharma.
//
#import "CircleView.h"
#import "UIBezierPath+Rob_points.h"
#import "Global.h"


@implementation CircleView
{
    Global *global;
}

- (void)setInterval:(CGFloat)interval {
    _interval = interval;
    [self setNeedsDisplay];
}

CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
};

// My Custom Method for drawing view in circular path,

- (void)drawRect:(CGRect)rect {
    
    global = [Global shareInstance];
    
    global.numCircle = [NSNumber numberWithInt:0];
    
    __block BOOL isTop = false;
    
    NSInteger less = 22-[global.numDays integerValue];
    
   __block  UIImage *arrow;

    arrow = [CircleView imageWithImage:[UIImage imageNamed:@"dotb.png"] scaledToSize:CGSizeMake(5, 5)];
    

    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddEllipseInRect(path, nil, CGRectMake(self.bounds.origin.x+5, self.bounds.origin.y+5, self.bounds.size.width-8.5, self.bounds.size.height-10));

//    UIBezierPath *cPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.origin.x+5, self.bounds.origin.y+5, self.bounds.size.width-10, self.bounds.size.height-10)];

    
    UIBezierPath *cPath = [UIBezierPath bezierPathWithCGPath:path];
    
    [cPath Rob_forEachPointAtInterval:self.interval perform:^(CGPoint point, CGVector vector) {
        CGContextRef gc = UIGraphicsGetCurrentContext();
        CGContextSaveGState(gc); {

            CGContextTranslateCTM(gc, point.x, point.y);
            CGContextConcatCTM(gc, CGAffineTransformMake(vector.dx, vector.dy, -vector.dy, vector.dx, 0, 0));
            CGContextTranslateCTM(gc, -0.5 * arrow.size.width, -0.5 * arrow.size.height);
            if(self.tag != 101)
            {
            if([global.numCircle integerValue]<less)
            {
                arrow = [CircleView imageWithImage:[UIImage imageNamed:@"dotb.png"] scaledToSize:CGSizeMake(5, 5)];
                global.numCircle = [NSNumber numberWithInteger:[global.numCircle integerValue]+1];
                [arrow drawAtPoint:CGPointZero];

            }
            else if([global.numCircle integerValue]>=less && [global.numCircle integerValue]<22)
            {
                arrow = [CircleView imageResize:arrow andResizeTo:CGSizeMake(3, 3)];
                global.numCircle = [NSNumber numberWithInteger:[global.numCircle integerValue]+1];
                if([global.numCircle integerValue] == 21)
                {
                    isTop = YES;
                }
                [arrow drawAtPoint:CGPointZero];
            }
            else
            {
                if(isTop)
                {
                    CGPoint point = CGPointZero;

                    if([UIScreen mainScreen].bounds.size.height == 667)
                    {
                        arrow = [CircleView topImage];
                    }
                    else
                    {
                        arrow = [CircleView imageWithImage:[UIImage imageNamed:@"dotb.png"] scaledToSize:CGSizeMake(5, 4)];
                    }
                    
                    point.y = -1.0;
                    isTop = NO;
                    global.numCircle = [NSNumber numberWithInteger:[global.numCircle integerValue]+1];
                    [arrow drawAtPoint:point];
                }
                else
                {
                    arrow = [CircleView imageWithImage:[UIImage imageNamed:@"dotb.png"] scaledToSize:CGSizeMake(5, 5)];
                    global.numCircle = [NSNumber numberWithInteger:[global.numCircle integerValue]+1];
                    [arrow drawAtPoint:CGPointZero];
                }

            }
            }
            [arrow drawAtPoint:CGPointZero];
        } CGContextRestoreGState(gc);
    }];
}


// Class method to scale image

+(UIImage *)topImage
{
    CGSize newSize = CGSizeMake(4.5, 4.8);
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [[UIImage imageNamed:@"dotb.png"] drawInRect:CGRectMake(0,-0.5,newSize.width,newSize.height)];
    
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

// class method to resize image

+(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
