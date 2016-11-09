//
//  block.m
//  RYAADemo
//
//  Created by ruanyang on 2016/11/3.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import "block.h"
#import "LoginVC.h"
@interface block ()
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation block

void (^printTheNum)(int) = ^(int num){
    NSLog(@"%d",num);
};

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    block的核心思想：比如我打你一巴掌(发送消息),然后你说你打到我了(响应消息),那我心里就爽了(回调block).
//    block的内存空间是另外开辟的，所以不会立马执行block内的代码
    
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    self.lab.userInteractionEnabled=YES;
    [self.lab addGestureRecognizer:tap];

}
-(void)tap{
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LoginVC * b=[sb instantiateViewControllerWithIdentifier:@"loginvc"];
    __weak typeof(self) wself=self;
    b.block=^(NSString * str){
        //        NSLog(@"%@",str);
        wself.lab.text=str;
    };
    [self presentViewController:b animated:YES completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
- (IBAction)bock1:(id)sender {
    //调用
    printTheNum(5);
}
- (IBAction)block2:(id)sender {
    int a=5;
    //这个代码块没有调用，开辟空间等着
    int (^test2)(int)=^(int a){
        a=a+3;
        return a+4;
    };
    a=20;
    //调用
    NSLog(@"%d",test2(a));
}
- (IBAction)block3:(id)sender {
    int b=7;
    int (^test3)(int) = ^(int temp ){
        //b的值已经赋进来了
        return temp+b;
    };
    b=20;
    NSLog(@"%d",test3(2));
//    在这里,定义block的时候,就将b的值copy了一份,所以return temp+b;实际上是return temp+5;后面对b的改动是没有影响的.
}
- (IBAction)block4:(id)sender {
        int __block x = 100;
        void (^test4)(int) = ^(int y){
            x = x+y;//Variable is not assignable (missing __block type specifier)
            printf("The x value is %d",x);
        };
        test4(50);
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
