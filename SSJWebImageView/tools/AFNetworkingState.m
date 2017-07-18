//
//  AFNetworkingState.m
//  sdWebImageUseDemo
//
//  Created by jssName on 2017/7/17.
//  Copyright © 2017年 jssName. All rights reserved.
//

#import "AFNetworkingState.h"
#import "AFNetworking.h"
#import "Reachability.h"
@interface AFNetworkingState()
@property (nonatomic, strong) AFNetworkReachabilityManager *manager;
@end
@implementation AFNetworkingState
static AFNetworkingState *aFNetworkingState;
+ (instancetype)initOnece{
    static dispatch_once_t  predicate;
    if(!aFNetworkingState){
        dispatch_once(&predicate, ^{
            aFNetworkingState = [[AFNetworkingState alloc]init];
        });
    }
    return aFNetworkingState;
}


// 判断网络
- (HttpState)checkNetWorkState{
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            NSLog(@"没有网络连接");
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"使用3G网络");
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"使用WiFi网络");
            break;
    }
    return (NSInteger)[r currentReachabilityStatus];
}

@end
