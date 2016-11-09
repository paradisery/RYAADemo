//
//  LoginVC.h
//  RYAADemo
//
//  Created by ruanyang on 2016/11/3.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
//声明Block
typedef void(^myBlock)(NSString * str);

@interface LoginVC : UIViewController
//创建对象
@property(copy,nonatomic)myBlock block;

@end
