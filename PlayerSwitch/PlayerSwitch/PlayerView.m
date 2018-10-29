//
//  PlayerView.m
//  PlayerSwitch
//
//  Created by mac on 2018/10/29.
//  Copyright © 2018 healifeGroup. All rights reserved.
//

#import "PlayerView.h"
#import <Masonry.h>

@implementation PlayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
      
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        
        [self addSubview:self.coverIcon];
        [self addSubview:self.backBtn];
        [self addSubview:self.bottomBar];
        
        UIView *blackView = [UIView new];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.5;
        [self.bottomBar addSubview:blackView];
        
        [self.bottomBar addSubview:self.playBtn];
        [self.bottomBar addSubview:self.switchBtn];
        
        [self.coverIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(25);
            make.width.and.height.mas_equalTo(30);
        }];
        
        [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(40);
        }];
        
        [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bottomBar).insets(UIEdgeInsetsZero);
        }];
        
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomBar).offset(15);
            make.centerY.equalTo(self.bottomBar);
            make.width.and.height.mas_equalTo(30);
        }];
        
        [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bottomBar.mas_right).offset(-15);
            make.centerY.equalTo(self.bottomBar);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(30);
        }];
        
    }
    return self;
}

-(void)switchBtnAction:(UIButton *)sender{
    NSInteger tag = sender.tag - 3000;
    if (self.switchBtnActionBlock) {
        self.switchBtnActionBlock(self,tag);
    }
}

-(UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] init];
        _backBtn.backgroundColor = [UIColor grayColor];
        [_backBtn setTitle:@"🔙" forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.tag = 3000;
    }
    return _backBtn;
}

-(UIButton *)playBtn{
    if (_playBtn == nil) {
        _playBtn = [[UIButton alloc] init];
        _playBtn.backgroundColor = [UIColor grayColor];
        [_playBtn setTitle:@"▶️" forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _playBtn.tag = 3001;
    }
    return _playBtn;
}

-(UIButton *)switchBtn{
    if (_switchBtn == nil) {
        _switchBtn = [[UIButton alloc] init];
        _switchBtn.backgroundColor = [UIColor grayColor];
        [_switchBtn setTitle:@"切换" forState:UIControlStateNormal];
        [_switchBtn addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _switchBtn.tag = 3002;
    }
    return _switchBtn;
}

-(UIView *)bottomBar{
    if (_bottomBar == nil) {
        _bottomBar = [UIView new];
    }
    return _bottomBar;
}

-(UIImageView *)coverIcon{
    if (_coverIcon == nil) {
        _coverIcon = [UIImageView new];
        _coverIcon.image = [UIImage imageNamed:@"cover_default"];
    }
    return _coverIcon;
}

@end
