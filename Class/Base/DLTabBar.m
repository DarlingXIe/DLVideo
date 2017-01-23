//
//  DLTabBar.m
//  DLVideo
//
//  Created by DalinXie on 17/1/20.
//  Copyright © 2017年 itdarlin. All rights reserved.
//
/**
 *  思路：1.直接定义直播按钮加到tabBar的中间。直接在系统的tabbar上盖已成view。
            如果需要设置文字在下面,需要自定义btn，修改frame
 *        2.用setValueForKey去替换系统的tabbar。然后布局上面的子空间。
 */
#import "DLTabBar.h"

@interface DLTabBar()

@property (nonatomic, strong) UIImageView * backImageView;

@property (nonatomic, strong) NSArray * arrayList;

@property (nonatomic, strong) UIButton * lastItem;

@property (nonatomic, strong) UIButton * cameraButton;

@end

@implementation DLTabBar
// 加载backgroundImage;
- (UIImageView*)backImageView{
    if(!_backImageView){
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _backImageView;
}
//数组tabBar按钮资源
- (NSArray *)arrayList{
    if(!_arrayList){
        _arrayList = @[@"tab_live", @"tab_me"];
    }
    return _arrayList;
}
#pragma mark: 中间的按键
-(UIButton *)cameraButton{
    if(!_cameraButton){
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        _cameraButton.tag = DLTabBarTypeLaunch;
        [self.cameraButton sizeToFit];
        [_cameraButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.backImageView];
        for (NSInteger i = 0; i < self.arrayList.count; i++) {
            
            UIButton * BtnItem = [UIButton buttonWithType:UIButtonTypeCustom];
            BtnItem.adjustsImageWhenHighlighted = false;
            [BtnItem setImage:[UIImage imageNamed:self.arrayList[i]] forState:UIControlStateNormal];
            [BtnItem setImage:[UIImage imageNamed:[self.arrayList[i]
            stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            [BtnItem addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            BtnItem.tag = DLTabBarTypeLive + i;
            if(i == 0){
                BtnItem.selected = true;
                self.lastItem = BtnItem;
            }
            [self addSubview:BtnItem];
        }
        [self addSubview:self.cameraButton];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backImageView.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width/self.arrayList.count;
    for (NSInteger i = 0; i < [self subviews].count; i++) {
        UIView * btn = [self subviews][i];
        if([btn isKindOfClass:[UIButton class]]){
            btn.frame = CGRectMake((btn.tag - DLTabBarTypeLive) * width, 0, width, self.bounds.size.height);
        }
    }
    [self.cameraButton sizeToFit];
    self.cameraButton.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - 50);
}

#pragma mark: -clickButton
-(void)clickButton:(UIButton *) button{
    
    if([self.delegate respondsToSelector:@selector(DLTabBar:clickButton:)]){
        [self.delegate DLTabBar:self clickButton:button.tag];
    }
    //用block
    if(self.block){
        self.block(self, button.tag);
    }
    
    if(button.tag == DLTabBarTypeLaunch){
        return;
    }
    self.lastItem.selected = false;
    button.selected = true;
    self.lastItem = button;
   
    [UIView animateWithDuration:0.2 animations:^{
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
             button.transform = CGAffineTransformIdentity;
        }];
    }];
}
@end
