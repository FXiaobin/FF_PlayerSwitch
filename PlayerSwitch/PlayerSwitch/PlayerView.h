//
//  PlayerView.h
//  PlayerSwitch
//
//  Created by mac on 2018/10/29.
//  Copyright © 2018 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerView : UIView


@property (nonatomic,strong) UIImageView *coverIcon;


@property (nonatomic,strong) UIButton *backBtn;


@property (nonatomic,strong) UIButton *playBtn;

@property (nonatomic,strong) UIButton *switchBtn;


@property (nonatomic,strong) UIView *bottomBar;


@property (nonatomic,copy) void (^switchBtnActionBlock) (PlayerView *playerV,NSInteger tag);

@end

NS_ASSUME_NONNULL_END
