//
//  delegate.h
//  RYAADemo
//
//  Created by ruanyang on 2016/11/9.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

//被雇佣方

//声明代理协议// 新建一个协议，协议的名字一般是由“类名+Delegate”
@protocol VCdelegate <NSObject>
// 代理传值方法
-(void)vcSendValue:(NSString *)value;

@end

@interface delegate : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tf;
//创建对象// 委托代理人，代理一般需使用弱引用(weak)
@property(weak,nonatomic)id<VCdelegate>delegate;
//声明delegate时请用assign(MRC)或者weak(ARC)

@end
