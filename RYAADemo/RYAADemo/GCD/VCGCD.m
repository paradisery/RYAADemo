//
//  VCGCD.m
//  RYAADemo
//
//  Created by ruanyang on 2016/11/2.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import "VCGCD.h"

@interface VCGCD ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation VCGCD

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
/*
    1、你们项目中为什么多线程用GCD而不用NSOperation呢? 你有没有发现国外的大牛他们多线程都是用NSOperation? 你能告诉我他们这样做的理由吗?
    
    关系:①:先搞清两者的关系,NSOpertaionQueue用GCD构建封装的，是GCD的高级抽象!
    
    ②:GCD仅仅支持FIFO队列，而NSOperationQueue中的队列可以被重新设置优先级，从而实现不同操作的执行顺序调整。GCD不支持异步操作之间的依赖关系设置。如果某个操作的依赖另一个操作的数据（生产者-消费者模型是其中之一），使用NSOperationQueue能够按照正确的顺序执行操作。GCD则没有内建的依赖关系支持。
    
    ③:NSOperationQueue支持KVO，意味着我们可以观察任务的执行状态。
    
    了解以上不同，我们可以从以下角度来回答
    
    性能:①:GCD更接近底层，而NSOperationQueue则更高级抽象，所以GCD在追求性能的底层操作来说，是速度最快的。这取决于使用Instruments进行代码性能分析，如有必要的话
    
    ②:从异步操作之间的事务性，顺序行，依赖关系。GCD需要自己写更多的代码来实现，而NSOperationQueue已经内建了这些支持
    
    ③:如果异步操作的过程需要更多的被交互和UI呈现出来，NSOperationQueue会是一个更好的选择。底层代码中，任务之间不太互相依赖，而需要更高的并发能力，GCD则更有优势
    
    👍最后的一句话:别忘了高德纳的教诲：“在大概97%的时间里，我们应该忘记微小的性能提升。过早优化是万恶之源。”只有Instruments显示有真正的性能提升时才有必要用低级的GCD。
    
    
    原文链接：http://www.jianshu.com/p/682de90106b5
*/
   
    
    //多张图片下载问题，分割下载，group
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
- (IBAction)btn:(id)sender {
    [self downLoad];
}

-(void)downLoad{
    dispatch_async(dispatch_queue_create("123", DISPATCH_QUEUE_CONCURRENT), ^{
        NSLog(@"start");
    });
    
    dispatch_barrier_async(dispatch_queue_create("123", DISPATCH_QUEUE_CONCURRENT), ^{
        NSLog(@"*********************************");
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 网络图片 url
        NSURL *url = [NSURL URLWithString:@"http://imgsrc.baidu.com/forum/w%3D580/sign=4c0ce3a63b01213fcf334ed464e736f8/832d7bf40ad162d933cfb56313dfa9ec8a13cd56.jpg"];
        //http://img2.imgtn.bdimg.com/it/u=2912233439,2907667129&fm=21&gp=0.jpg
        //http://imgsrc.baidu.com/forum/w%3D580/sign=4c0ce3a63b01213fcf334ed464e736f8/832d7bf40ad162d933cfb56313dfa9ec8a13cd56.jpg
        // 下载二进制数据到本地
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 获取图片
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        // 回到主线程刷新 UI 图片
        dispatch_async(dispatch_get_main_queue(), ^{
                        self.imageView.image = image;
        });
    });
}
-(void)serialSync{
    
    dispatch_queue_t queue=dispatch_queue_create("helloworld", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        NSLog(@"1-%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-%@",[NSThread currentThread]);
    });
    
    NSLog(@"over");
}
-(void)serialAsync{
    
    dispatch_queue_t queue=dispatch_queue_create("yeah", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"1111-%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2222-%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3333-%@",[NSThread currentThread]);
    });
    NSLog(@"over");
}
-(void)concurrentSync{
    dispatch_queue_t queue=dispatch_queue_create("yyyyyyy", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"11111111-%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"22222222-%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"33333333-%@",[NSThread currentThread]);
    });
    NSLog(@"over");
}
-(void)concurrentAsync{
    dispatch_queue_t queue=dispatch_queue_create("zzzzzz", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"zzzzzz1-%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"zzzzzz2-%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"zzzzzz3-%@",[NSThread currentThread]);
    });
    NSLog(@"over");
}
-(void)mainSync{
    NSLog(@"---start---");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"download1- %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download2- %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3- %@", [NSThread currentThread]);
    });
    NSLog(@"---end---");
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
