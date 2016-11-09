//
//  delegate.m
//  RYAADemo
//
//  Created by ruanyang on 2016/11/9.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import "delegate.h"

@interface delegate ()

@end

@implementation delegate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor=[UIColor redColor];
}

- (IBAction)btn:(id)sender {
    if ([_delegate respondsToSelector:@selector(vcSendValue:)]) {
         [_delegate vcSendValue:_tf.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
