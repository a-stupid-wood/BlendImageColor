//
//  ViewController.m
//  BlendImageColor
//
//  Created by zj on 2017/10/10.
//  Copyright © 2017年 zj. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+tint.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * msgLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createUI];
}

- (void)createUI
{
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image.png"]];
    _imageView.center = self.view.center;
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBlendMode:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [_imageView addGestureRecognizer:tap];
    [self.view addSubview:_imageView];
    
    _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_imageView.frame) + 20, CGRectGetWidth(self.view.frame) - 40, 120)];
    _msgLabel.numberOfLines = 0;
    _msgLabel.text = @"在屏幕中绘图时设置透明度；点击图片切换为混合模式绘制的图片";
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    _msgLabel.textColor = [UIColor blackColor];
    _msgLabel.layer.borderColor = [UIColor grayColor].CGColor;
    _msgLabel.layer.borderWidth = 1.0;
    [self.view addSubview:_msgLabel];
}

- (void)changeBlendMode:(UIGestureRecognizer*)gesture
{
    static CGBlendMode blendMode = kCGBlendModeNormal;
    NSString *strMsg;
    switch (blendMode) {
        case kCGBlendModeNormal:
            strMsg = @"kCGBlendModeNormal:正常；也是默认的模式。前景图会覆盖背景图";
            break;
        case kCGBlendModeMultiply:
            strMsg = @"kCGBlendModeMultiply:正片叠底；混合了前景和背景的颜色，最终颜色比原来的都暗";
            break;
        case kCGBlendModeScreen:
            strMsg = @"kCGBlendModeScreen:滤色；把前景和背景图的颜色先反过来，然后混合";
            break;
        case kCGBlendModeOverlay:
            strMsg = @"kCGBlendModeOverlay:覆盖：能保留灰度信息，结合kCGBlendModeDestinationIn能保留透明度信息，在imageWithBlendMode方法中两次执行drawInRect方法实现我们的基本需求";
            break;
        case kCGBlendModeDarken:
            strMsg = @"kCGBlendModeDarken:变暗";
            break;
        case kCGBlendModeLighten:
            strMsg = @"kCGBlendModeLighten:变亮";
            break;
        case kCGBlendModeColorDodge:
            strMsg = @"kCGBlendModeColorDodge:颜色变淡";
            break;
        case kCGBlendModeColorBurn:
            strMsg = @"kCGBlendModeColorBurn:颜色加深";
            break;
        case kCGBlendModeHardLight:
            strMsg = @"kCGBlendModeHardLight:强光";
            break;
        case kCGBlendModeSoftLight:
            strMsg = @"kCGBlendModeSoftLight:柔光";
            break;
        case kCGBlendModeDifference:
            strMsg = @"kCGBlendModeDifference:插值";
            break;
        case kCGBlendModeExclusion:
            strMsg = @"kCGBlendModeExclusion:排除";
            break;
        case kCGBlendModeHue:
            strMsg = @"kCGBlendModeHue:色调";
            break;
        case kCGBlendModeSaturation:
            strMsg = @"kCGBlendModeSaturation:饱和度";
            break;
        case kCGBlendModeColor:
            strMsg = @"kCGBlendModeColor:颜色";
            break;
        case kCGBlendModeLuminosity:
            strMsg = @"kCGBlendModeLuminosity:亮度";
            break;
            
            //Apple额外定义的枚举
            //R: premultiplied result, 表示混合结果
            //S: Source, 表示源颜色(Sa对应透明度值: 0.0-1.0)
            //D: destination colors with alpha, 表示带透明度的目标颜色(Da对应透明度值: 0.0-1.0)
        case kCGBlendModeClear:
            strMsg = @"kCGBlendModeClear:R = 0";
            break;
        case kCGBlendModeCopy:
            strMsg = @"kCGBlendModeCopy:R = S";
            break;
        case kCGBlendModeSourceIn:
            strMsg = @"kCGBlendModeSourceIn:R = S * Da";
            break;
        case kCGBlendModeSourceOut:
            strMsg = @"kCGBlendModeSourceOut:R = S * (1 - Da)";
            break;
        case kCGBlendModeSourceAtop:
            strMsg = @"kCGBlendModeSourceAtop:R = S * Da + D * (1 - Da)";
            break;
        case kCGBlendModeDestinationOver:
            strMsg = @"kCGBlendModeDestinationOver:R = S * (1 - Da) + D";
            break;
        case kCGBlendModeDestinationIn:
            strMsg = @"kCGBlendModeDestinationIn: R = D * Sa;保留透明度信息";
            break;
        case kCGBlendModeDestinationOut:
            strMsg = @"kCGBlendModeDestinationOut: R = D * (1 - Sa)";
            break;
        case kCGBlendModeDestinationAtop:
            strMsg = @"kCGBlendModeDestinationAtop: R = S * (1 - Da) + D * Sa";
            break;
        case kCGBlendModeXOR:
            strMsg = @"kCGBlendModeXOR: R = S * (1 - Da) + D * (1 - Sa)";
            break;
        case kCGBlendModePlusDarker:
            strMsg = @"KCGBlendModePlusDarker: R = MAX(0, (1 - D) + (1 - S))";
            break;
        case kCGBlendModePlusLighter:
            strMsg = @"kCGBlendModePlusLighter: R = MIN(1, S + D)（最后一种混合模式）";
            break;
        default:
            break;
    }
    _imageView.image = [[UIImage imageNamed:@"image.png"] imageWithTintColor:[UIColor orangeColor] blendMode:blendMode];
    _msgLabel.text = strMsg;
    
    blendMode ++;
    if (blendMode > kCGBlendModePlusLighter) {
        blendMode = kCGBlendModeNormal;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
