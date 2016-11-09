//
//  ViewController.m
//  RYAADemo
//
//  Created by ruanyang on 16/10/9.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
       //并行执行线程1
        sleep(1);
        NSLog( @"1%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        //并行执行线程2
        sleep(2);
        NSLog( @"2%@",[NSThread currentThread]);

    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        //汇总结果
        NSLog( @"3%@",[NSThread currentThread]);

    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
