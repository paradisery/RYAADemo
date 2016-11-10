//
//  VCKVO.m
//  RYAADemo
//
//  Created by ruanyang on 2016/11/2.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import "VCKVO.h"
#import "kvo.h"
#import "sharedInstance.h"
#import "LoginVC.h"
@interface VCKVO ()
@property(nonatomic,strong)kvo * mykvo;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UILabel *nsudLabel;

@end

@implementation VCKVO

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    在MVC设计架构下的项目，KVO机制很适合实现mode模型和view视图之间的通讯。
//    
//    例如：代码中，在模型类A创建属性数据，在控制器中创建观察者，一旦属性数据发生改变就收到观察者收到通知，通过KVO再在控制器使用回调方法处理实现视图B的更新；
//    KVO 的实现依赖于 Objective-C 强大的 Runtime
    
    
//    key-value observing：监听某个对象的某个属性发生变化，当发生变化，观察者会调用相应函数
//    当某个类的属性对象第一次被观察时，系统就会在运行期动态地创建该类的一个派生类，在这个派生类中重写基类中任何被观察属性的setter 方法。派生类在被重写的setter方法内实现真正的通知机制
    
    
    self.mykvo=[[kvo alloc]init];
    
    [self.mykvo addObserver:self forKeyPath:@"kk" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}
- (IBAction)btn:(id)sender {
    self.mykvo.kk++;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"kk"]) {
        _lab.text=[NSString stringWithFormat:@"%@",[change valueForKey:@"new"]];
        _oldLable.text=[NSString stringWithFormat:@"%@",[change valueForKey:@"old"]];
        id oldState = [change objectForKey:NSKeyValueChangeOldKey];
        NSLog(@"old----------%@",oldState);
        id newState = [change objectForKey:NSKeyValueChangeNewKey];
        NSLog(@"new-----------%@",newState);
        
    }
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"kk"];
}

-(void)viewWillAppear:(BOOL)animated{
//单例
    sharedInstance * ry=[sharedInstance sharedInstance];
    _shareLabel.text=ry.useName;
//NSUserDefaults
    NSUserDefaults * nsud=[NSUserDefaults standardUserDefaults];
    _nsudLabel.text=[nsud objectForKey:@"userName"];
    
}
- (IBAction)goLoginVC:(id)sender {
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginVC * lvc=[sb instantiateViewControllerWithIdentifier:@"loginvc"];
    [self presentViewController:lvc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self removeObserver:self forKeyPath:@"kk"];
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
