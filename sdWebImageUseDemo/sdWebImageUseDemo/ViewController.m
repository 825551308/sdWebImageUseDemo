//
//  ViewController.m
//  sdWebImageUseDemo
//
//  Created by jssName on 2017/7/17.
//  Copyright © 2017年 jssName. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "AFNetworkingState.h"
#import "SSJWebImageView.h"
@interface ViewController ()
@property (nonatomic,weak) IBOutlet SSJWebImageView *showImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *httpOriginal = @"https://raw.githubusercontent.com/825551308/webFileSource/master/webFileSource/image/image01_big.png";
    NSString *httpThumbnail = @"https://raw.githubusercontent.com/825551308/webFileSource/master/webFileSource/image/image01_small.png";
    self.showImageView.placeholderImageName = @"customPlaceHolderImage";
    [self.showImageView showImageWithShowType:DeviceNetWorkShowWithThumbnail originalHttp:httpOriginal thumbnailHttp:httpThumbnail];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 清除缓存 */
- (IBAction)clearSDWebCache:(id)sender {
    [self.showImageView clearSDWebCache:^{
        NSLog(@"清除完成，准备干点什么！");
    }];
}

@end
