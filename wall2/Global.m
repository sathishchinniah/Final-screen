//
//  Global.m
//  wall2
//
//  Created by Divyanshu Sharma on 27/01/16.
//  Copyright © 2016 Divyanshu Sharma. All rights reserved.
//

#import "Global.h"

@implementation Global
@synthesize numDays,numCircle,isBlueView;

+ (Global *)shareInstance {
    static dispatch_once_t onceToken;
    static Global *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[Global alloc] init];
    });
    return instance;
}

-(id)init
{
    return [super init];
}
@end
