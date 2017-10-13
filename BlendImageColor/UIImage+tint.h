//
//  UIImage+tint.h
//  BlendImageColor
//
//  Created by zj on 2017/10/10.
//  Copyright © 2017年 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (tint)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

@end
