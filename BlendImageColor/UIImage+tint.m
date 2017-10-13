//
//  UIImage+tint.m
//  BlendImageColor
//
//  Created by zj on 2017/10/10.
//  Copyright © 2017年 zj. All rights reserved.
//

#import "UIImage+tint.h"

@implementation UIImage (tint)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];//填充颜色
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    //设置绘画透明混合模式和透明度
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    if (blendMode == kCGBlendModeOverlay) {
        //保留透明度信息
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    UIImage * tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
