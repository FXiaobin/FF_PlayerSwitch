//
//  AppDelegate.h
//  PlayerSwitch
//
//  Created by mac on 2018/10/29.
//  Copyright © 2018 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

///视频播放器旋转的属性
@property (nonatomic, assign) BOOL allowRotation;

@end

