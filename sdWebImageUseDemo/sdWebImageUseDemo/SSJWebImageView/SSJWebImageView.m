//
//  SSJWebImageView.m
//  sdWebImageUseDemo
//
//  Created by jssName on 2017/7/18.
//  Copyright © 2017年 jssName. All rights reserved.
//

#import "SSJWebImageView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworkingState.h"
@implementation SSJWebImageView
#pragma mark -- xib加载方式
- (void)awakeFromNib{
    [super awakeFromNib];
    HttpState httpState = [[AFNetworkingState initOnece] checkNetWorkState];
    //原图URL
    NSURL *urlBig = [NSURL URLWithString:self.webHttpOriginal];
    //缩略图URL
    NSURL *urlThumbnail = [NSURL URLWithString:self.webHttpThumbnail];
    //缺省图片
    UIImage *placeHolderImage = [UIImage imageNamed:@"placeHolderImage"];
    
    /**< 读取缓存图片 */
    UIImage *cacheImageBig = [self cacheImage:_webHttpOriginal];
    if (cacheImageBig) {
        self.image = cacheImageBig;
    }else if(httpState == HttpStateOfWiFi){
        //wife下--加载原图
        [self sd_setImageWithURL:urlBig placeholderImage:placeHolderImage options:SDWebImageRetryFailed|SDWebImageLowPriority];
    }else if(httpState == HttpStateOfDeviceNetWork){
        //如果设置的3g/4g网络下--加载原图
        if (self.showType == DeviceNetWorkShowWithOriginal) {
            [self sd_setImageWithURL:urlBig placeholderImage:placeHolderImage options:SDWebImageRetryFailed|SDWebImageLowPriority];
        }if (self.showType == DeviceNetWorkShowWithThumbnail) {
            //如果设置的3g/4g网络下--加载缩略图（先读区缩略图缓存）
            UIImage *cacheImageSmall = [self cacheImage:self.webHttpThumbnail];
            if (cacheImageSmall) {
                self.image = cacheImageSmall;/**< 读取缓存 */
            }else{
                [self sd_setImageWithURL:urlThumbnail placeholderImage:placeHolderImage options:SDWebImageRetryFailed|SDWebImageLowPriority];/**< 加载缩略图 */
            }
        }
    }else{
        //无网络
        UIImage *cacheImageSmall = [self cacheImage:self.webHttpThumbnail];
        if (cacheImageSmall) {
            self.image = cacheImageSmall;
        }
    }
}

#pragma mark --  手动调用方式
- (void)showImageWithShowType:(DeviceNetWorkShow)showType originalHttp:(NSString *)originalHttp thumbnailHttp:(NSString *)thumbnailHttp{
    
    HttpState httpState = [[AFNetworkingState initOnece] checkNetWorkState];
    //原图URL
    NSURL *urlBig = [NSURL URLWithString:self.webHttpOriginal];
    //缩略图URL
    NSURL *urlThumbnail = [NSURL URLWithString:self.webHttpThumbnail];
    //缺省图片
    NSString *placeholderName = self.placeholderImageName.length > 0 ? (self.placeholderImageName):(@"placeHolderImage");
    UIImage *placeHolderImage = [UIImage imageNamed:placeholderName];
    
    /**< 读取缓存图片 */
    UIImage *cacheImageBig = [self cacheImage:_webHttpOriginal];
    if (cacheImageBig) {
        self.image = cacheImageBig;
    }else if(httpState == HttpStateOfWiFi){
        //wife下
        [self sd_setImageWithURL:urlBig placeholderImage:placeHolderImage options:SDWebImageRetryFailed|SDWebImageLowPriority];
    }else if(httpState == HttpStateOfDeviceNetWork){
        //如果设置的3g/4g网络下--下载原图
        if (self.showType == DeviceNetWorkShowWithOriginal) {
            [self sd_setImageWithURL:urlBig placeholderImage:placeHolderImage options:SDWebImageRetryFailed|SDWebImageLowPriority];
        }if (self.showType == DeviceNetWorkShowWithThumbnail) {
            //如果设置的3g/4g网络下--下载缩略图（先读区缩略图缓存）
            UIImage *cacheImageSmall = [self cacheImage:self.webHttpThumbnail];
            if (cacheImageSmall) {
                self.image = cacheImageSmall;/**< 读取缓存 */
            }else{
                [self sd_setImageWithURL:urlThumbnail placeholderImage:placeHolderImage options:SDWebImageRetryFailed|SDWebImageLowPriority];/**< 加载缩略图 */
            }
        }
    }else{
        //无网络
        UIImage *cacheImageSmall = [self cacheImage:self.webHttpThumbnail];
        if (cacheImageSmall) {
            self.image = cacheImageSmall;
        }
    }
    
}

/** 读取缓存下来的图片 */
- (UIImage *)cacheImage:(NSString *)imageWebHttp{
    NSURL *url = [NSURL URLWithString:imageWebHttp];
    /**< 读取缓存图片 */
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString *key = [manager cacheKeyForURL:url];
    SDImageCache *catch = [SDImageCache sharedImageCache];
    UIImage *image = [catch imageFromDiskCacheForKey:key];
    return image;
}


/** 清除缓存 */
- (void)clearSDWebCache:(void(^)())backBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"缓存大小：%fMB",[[SDImageCache sharedImageCache] getSize]/1000.0/1000);
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            NSLog(@"clear后缓存大小：%fMB",[[SDImageCache sharedImageCache] getSize]/1000.0/1000);
            dispatch_async(dispatch_get_main_queue(), ^{
                backBlock();
            });
        }];
        [[SDImageCache sharedImageCache] clearMemory];
    });
}
@end
