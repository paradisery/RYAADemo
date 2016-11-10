//
//  sharedInstance.h
//  RYAADemo
//
//  Created by ruanyang on 2016/11/8.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#define SingleImplementation(sharedInstance)  +(instancetype)sharedInstance
#import <Foundation/Foundation.h>

@interface sharedInstance : NSObject
@property(nonatomic,strong)NSString * useName;
+(instancetype)sharedInstance;

@end
