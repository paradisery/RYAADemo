//
//  delegateVC.m
//  RYAADemo
//
//  Created by ruanyang on 2016/11/9.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import "delegateVC.h"
#import "delegate.h"

@interface delegateVC ()<VCdelegate>

@end

@implementation delegateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//雇佣方
//实现代理方法
-(void)vcSendValue:(NSString *)value{
    _lable.text=value;
      NSLog(@"%@",value);
}
- (IBAction)btn:(id)sender {
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    delegate * devc = [sb instantiateViewControllerWithIdentifier:@"dele"];
//    delegate * devc=[delegate new];
    
    devc.delegate=self;
    [self presentViewController:devc animated:YES completion:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    delegate * devc=segue.destinationViewController;
    [devc setDelegate:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
