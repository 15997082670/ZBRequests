//
//  AppDelegate.h
//  ZBRequest
//
//  Created by 张斌斌 on 17/4/7.
//  Copyright © 2017年 张斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(assign,nonatomic)NetworkStatus statue;
@end

