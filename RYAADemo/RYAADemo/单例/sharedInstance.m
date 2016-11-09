//
//  sharedInstance.m
//  RYAADemo
//
//  Created by ruanyang on 2016/11/8.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//


#define SingleImplementation(sharedInstance)  +(instancetype)sharedInstance
#import "sharedInstance.h"

static sharedInstance * _instance;

@implementation sharedInstance
     //第一种写法
+(id)sharedInstance{
    @synchronized (self) {
        if (_instance ==nil) {
            _instance =[[sharedInstance alloc]init];
        }
    }
    return _instance;
}
     //第二种写法
/*
+(sharedInstance *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[sharedInstance alloc]init];
    });
    return _instance;
}
 */
@end
