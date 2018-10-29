//
//  ViewController.m
//  PlayerSwitch
//
//  Created by mac on 2018/10/29.
//  Copyright © 2018 healifeGroup. All rights reserved.
//

#import "ViewController.h"

#import "PlayerView.h"

#import "AppDelegate.h"

@interface ViewController ()


@property (nonatomic,strong) PlayerView *playerView;

@property (nonatomic,assign) BOOL isFull;

@property (nonatomic,strong) UIButton *switchBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.playerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 240);
    [self.view addSubview:self.playerView];
    
    __weak typeof(self) weakSelf = self;
    self.playerView.switchBtnActionBlock = ^(PlayerView * _Nonnull playerV, NSInteger tag) {
    
        if (tag == 0) { //返回
            if (weakSelf.isFull) {
                weakSelf.isFull = NO;
                AppDelegate  *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                delegate.allowRotation = NO;
                /// 2 - 1.
                [weakSelf changeToOrientation:UIDeviceOrientationPortrait];
                
                ///或者： 2 - 2.
                //[weakSelf setForceDeviceOrientation:UIDeviceOrientationPortrait];
                
            }else{
                //[weakSelf.navigationController popViewControllerAnimated:YES];
                NSLog(@"-------- 返回操作 ----");
            }
            
        }else if (tag == 1) {   //播放暂停
            
            
        }else if (tag == 2) {   //切换屏幕
            
            weakSelf.isFull = !weakSelf.isFull;
            
            if (weakSelf.isFull) {
                /// 1. 切换横竖屏方向
                AppDelegate  *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                delegate.allowRotation = YES;
                /// 2 - 1.
                //[weakSelf changeToOrientation:UIDeviceOrientationLandscapeLeft];
                
                ///或者： 2 - 2.
                [weakSelf setForceDeviceOrientation:UIDeviceOrientationLandscapeLeft];
                
                
            }else{
                
                AppDelegate  *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                delegate.allowRotation = NO;
                /// 2 - 1.
                [weakSelf changeToOrientation:UIDeviceOrientationPortrait];
                
                ///或者： 2 - 2.
                //[weakSelf setForceDeviceOrientation:UIDeviceOrientationPortrait];
                
            }
        }
        
        
    };
 
}

/// 2 - 1. 手动切换设备方向
- (void)changeToOrientation:(UIDeviceOrientation)orientation{
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

// 2 - 2. 强制切换设备方向 (这个方法和上面手动切换设备方向的方法 使用其中一个就行了)
- (void)setForceDeviceOrientation:(UIDeviceOrientation)deviceOrientation{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:deviceOrientation] forKey:@"orientation"];
}


#pragma mark - <播放器横竖屏切换及iPhone X适配>
// 3. 横竖屏适配 --- 重写系统方法
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) { // 转至竖屏
        
        self.playerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 240);
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        
    } else if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) { // 转至横屏

        self.playerView.frame = [UIScreen mainScreen].bounds;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    
    ///横屏以后默认会隐藏状态栏 需要重新显示
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.userInteractionEnabled = NO;  //需要禁掉 不然状态栏下的按钮被遮挡不能响应事件
    statusBar.alpha = 1.f;
    statusBar.hidden = NO;
}

#pragma mark - lazy

-(PlayerView *)playerView{
    if (_playerView == nil) {
        _playerView = [[PlayerView alloc] init];
        _playerView.backgroundColor = [UIColor orangeColor];
    }
    return _playerView;
}



@end
