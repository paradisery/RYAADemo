//
//  AccessAuthority.m
//  RYAccessAuthority
//
//  Created by ruanyang on 16/9/30.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import "AccessAuthority.h"
#import <CoreLocation/CLLocationManager.h>
#import <UserNotifications/UserNotifications.h>

@interface AccessAuthority ()

@end

@implementation AccessAuthority

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark--是否允许定位
+(BOOL) allowLocation{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        
        //定位功能可用
        NSLog(@"定位功能可用");
//        str=@"定位功能可用";
//        _gpsAllow=YES;
        return YES;
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        //定位不能用
        NSLog(@"定位不能用");
//        str=@"定位不能用";
//        _gpsAllow=NO;
        return NO;
    }else{
//        str=@"定位功能可用";
//        return str;
        return NO;
    }
//    return  str;
}
#pragma mark--是否允许推送
+(BOOL)allowPush{
    //            监视通知开关
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (granted) {
                                  //允许通知
                                  //                                  _pushAllow=YES;
                                  NSLog(@"用户允许通知!");
                                  
                              }else{
                                  //                                  _pushAllow=NO;
                                  NSLog(@"用户不允许通知!");
                                  
                                  
                              }
                              
                              if(!error)
                              {
                                  NSLog(@"授权成功");
                                  
                              }
                          }];
    
    
    //            iOS 8.0以后
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeNone) {
        NSLog(@"用户不允许通知!");
//        _pushAllow=NO;
        return NO;
    }else{
//        _pushAllow=YES;
        return YES;
    }
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
