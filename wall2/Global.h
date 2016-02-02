//
//  Global.h
//  wall2
//
//  Created by Divyanshu Sharma on 27/01/16.
//  Copyright © 2016 Divyanshu Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

@property(strong,nonatomic) NSNumber *numCircle;

@property(strong,nonatomic) NSNumber *numDays;

@property(nonatomic) BOOL isBlueView;
+(Global *)shareInstance;

@end
