//
//  AFNetworkingState.h
//  sdWebImageUseDemo
//
//  Created by jssName on 2017/7/17.
//  Copyright © 2017年 jssName. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,HttpState) {
        /** 无网络 */
        HttpStateOfNotReachable     = 0,
        /** wife */
        HttpStateOfWiFi             =1,
        /** 设备自带网络 */
        HttpStateOfDeviceNetWork    = 2
    
};

@interface AFNetworkingState : NSObject

+ (instancetype)initOnece;
- (HttpState)checkNetWorkState;
@end
