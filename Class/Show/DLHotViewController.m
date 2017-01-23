//
//  DLHotViewController.m
//  DLVideo
//
//  Created by DalinXie on 17/1/21.
//  Copyright © 2017年 itdarlin. All rights reserved.
//

#import "DLHotViewController.h"
#import "DLHotViewModel.h"
@interface DLHotViewController ()

@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, strong) DLHotViewModel * hotVModel;

@end

@implementation DLHotViewController

-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

-(DLHotViewModel *)hotVModel{
    if(!_hotVModel){
        _hotVModel = [DLHotViewModel new];
    }
    return _hotVModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self setupUI];
    [self loadData];
}
-(void)setupUI{
    
}
-(void)loadData{
    
    [self.hotVModel loadData:^(id success, NSError *error) {
        if(!error){
            self.dataArray = success;
        }else{
            NSLog(@"%@", error);
        }
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
