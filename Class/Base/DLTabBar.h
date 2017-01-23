//
//  DLTabBar.h
//  DLVideo
//
//  Created by DalinXie on 17/1/20.
//  Copyright © 2017年 itdarlin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DLTabBarItemType){
    DLTabBarTypeLaunch = 10,
    DLTabBarTypeLive = 100,
    DLTabBarTypeMe,
};

@class DLTabBar;

typedef void (^TabClickBlock)(DLTabBar * tabBar, DLTabBarItemType type);

@protocol DLTabBarDelegate <NSObject>

- (void)DLTabBar:(DLTabBar *) tabBar clickButton:(DLTabBarItemType) type;

@end

@interface DLTabBar : UIView

@property(nonatomic, weak) id<DLTabBarDelegate> delegate;
@property(nonatomic, copy) TabClickBlock block;

@end
