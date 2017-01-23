//
//  DLHotViewModel.h
//  DLVideo
//
//  Created by DalinXie on 17/1/22.
//  Copyright © 2017年 itdarlin. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DLHotModel.h"
typedef void (^loadDate)(id success, NSError * error);

@interface DLHotViewModel : NSObject

@property (nonatomic, strong) DLHotModel * hotModel;

@property (nonatomic, strong) NSArray * dataArray;

- (void)loadData: (loadDate) block;

@end
