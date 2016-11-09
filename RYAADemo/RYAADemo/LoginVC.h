//
//  LoginVC.h
//  RYAADemo
//
//  Created by ruanyang on 2016/11/3.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myBlock)(NSString * str);
typedef void(^getLoginResultBlock)(BOOL isLogin);

@interface LoginVC : UIViewController

@property(copy,nonatomic)myBlock block;

@end
