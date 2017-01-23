//
//  DLHotViewModel.m
//  DLVideo
//
//  Created by DalinXie on 17/1/22.
//  Copyright © 2017年 itdarlin. All rights reserved.
//

#import "DLHotViewModel.h"

@implementation DLHotViewModel

-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)loadData: (loadDate) block{
    
    [HttpTool getWithPath:API_HotLive params:nil success:^(id json) {
        
        if([json[@"dm_error"] integerValue]){
            block(nil, json);
        }
        self.dataArray = [DLHotModel  mj_objectArrayWithKeyValuesArray:json[@"lives"]];
        
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

@end
