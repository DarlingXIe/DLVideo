//
//  DLTopView.h
//  DLVideo
//
//  Created by DalinXie on 17/1/22.
//  Copyright © 2017年 itdarlin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickButton)(NSInteger tag);

@interface DLTopView : UIView

-(instancetype)initWithFrame:(CGRect)frame titleName:(NSArray *)titleArray;

@property(nonatomic,copy) clickButton block;

//滑动的时候把tag给DLTopView;创建方法
-(void)scrollControl:(NSInteger) tag;

@end
