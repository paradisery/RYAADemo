//
//  AccessAuthority.h
//  RYAccessAuthority
//
//  Created by ruanyang on 16/9/30.
//  Copyright © 2016年 mengtukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccessAuthority : UIViewController

//bool allowLocation;
+(BOOL)allowLocation;
+(BOOL)allowPush;

@end
