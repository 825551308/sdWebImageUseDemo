//
//  SSJWebImageView.h
//  sdWebImageUseDemo
//
//  Created by jssName on 2017/7/18.
//  Copyright © 2017年 jssName. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,DeviceNetWorkShow){
    /** 默认显示缩略图 */
    DeviceNetWorkShowWithThumbnail = 0,
    /** 显示原图 */
    DeviceNetWorkShowWithOriginal = 1,
    /** 默认不显示 */
    DeviceNetWorkShowWithNone = 2
};
@interface SSJWebImageView : UIImageView
#pragma mark -- 必填
/** 原图图 -- 远程地址 */
@property (nonatomic,strong) NSString *webHttpOriginal;
/** 缩略图 -- 远程地址 */
@property (nonatomic,strong) NSString *webHttpThumbnail;
/** 手机自带网络显示方式 */
@property (nonatomic,assign) DeviceNetWorkShow showType;

#pragma mark -- 选填
/** placeHolder图片 */
@property (nonatomic,strong) NSString *placeholderImageName;

#pragma mark -- 调用方法
/** 展示网络图片
 *  showType:3G/4G下 展示类型;
 *  originalHttp：原图远程路径;
 *  thumbnailHttp：缩略图远程路径
 */
- (void)showImageWithShowType:(DeviceNetWorkShow)showType originalHttp:(NSString *)originalHttp thumbnailHttp:(NSString *)thumbnailHttp;

/** 清除缓存 */
- (void)clearSDWebCache:(void(^)())backBlock;

/**
 * 演示逻辑
 *  伪代码：
 *  优先级：内存／沙盒图片 > 原图 > 缩略图
 if(内存／沙盒图片 原图){
    显示原图
 }else if(wife){
    //显示原图
 }else if(4G/3G){
    if(根据用户设置，显示原图){
        //加载原图
    }else if(根据用户设置，显示缩略图){
        //显示缩略图
    }else{
        //不显示
    }
 }else{//无网络
    if(内存／沙盒图片 缩略图){
        //显示缩略图
    }
 }
 */

@end
