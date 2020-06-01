//
//  UIImageView+DefaultSetting.m
//  WKDJ
//
//  Created by admin on 2020/5/31.
//  Copyright © 2020 Min zhang. All rights reserved.
//

#import "UIImageView+DefaultSetting.h"
#import <SDWebImage/SDWebImage.h>

static NSString * const kPreImageUrl = @"https://www.nmgdjkj.com";

@implementation UIImageView (DefaultSetting)

- (void)sd_defaultSettingSetImageWithUrl:(NSString *)urlString {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kPreImageUrl, urlString];
    NSURL *urlPath = [NSURL URLWithString:urlStr];
    [self sd_setImageWithURL:urlPath placeholderImage:[UIImage new]];
}

@end
