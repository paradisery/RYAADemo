//
//  delegate.h
//  RYAADemo
//
//  Created by ruanyang on 2016/11/9.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VCdelegate <NSObject>

-(void)vcSendValue:(NSString *)value;

@end

@interface delegate : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tf;

@property(weak,nonatomic)id<VCdelegate>delegate;

@end
