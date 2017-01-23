//
//  DLTopView.m
//  DLVideo
//
//  Created by DalinXie on 17/1/22.
//  Copyright © 2017年 itdarlin. All rights reserved.
//

#import "DLTopView.h"

@interface DLTopView()

@property (nonatomic, strong) NSMutableArray * ButtonArray;

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) UIButton * lastBtm;

@end


@implementation DLTopView

-(NSArray *)ButtonArray{
    if(!_ButtonArray){
        _ButtonArray = [NSMutableArray array];
    }
    return _ButtonArray;
}

-(instancetype)initWithFrame:(CGRect)frame titleName:(NSArray *)titleArray{
    
    if([super initWithFrame:frame]){
        [self setupUI:titleArray];
    }
    return self;
}

-(void)setupUI:(NSArray *)titleArray{
    
    CGFloat W = self.xmg_width / titleArray.count;
    
    CGFloat H = self.height;
    
    for(NSInteger i = 0; i < titleArray.count ; i ++){
        
        UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.ButtonArray addObject:titleButton];
        [titleButton setTitle:titleArray[i] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleButton.tag = i;
        titleButton.frame = CGRectMake(i * W, 0, W, H);
        [titleButton addTarget:self action:@selector(clickItems:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titleButton];
        
        if(i == 0) {
            
            [titleButton.titleLabel sizeToFit];
            CGFloat H = 2;
            CGFloat Y = titleButton.titleLabel.bottom + 5;
            
            self.lineView = [[UIView alloc] init];
            self.lineView.backgroundColor = [UIColor whiteColor];
            self.lineView.height = H;
            
            self.lineView.width = titleButton.titleLabel.width;
            self.lineView.centerX = titleButton.centerX;
            self.lineView.xmg_y = Y;
            [self addSubview:self.lineView];
            titleButton.selected = true;
            self.lastBtm = titleButton;
        }
    }     
}

#pragma mark- :clickButton
-(void)clickItems:(UIButton *) button{
    
    if(self.lastBtm){
        self.lastBtm.selected = false;
        button.selected = true;
        self.lastBtm = button;
    }
    if(self.block){
        self.block(button.tag);
    }
    [UIView animateWithDuration:0.5 animations:^{
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        button.transform = CGAffineTransformIdentity;
    }];
    [UIView animateWithDuration:0.3 animations:^{
      
        self.lineView.centerX = button.centerX;
    }];
    //button.selected = !button.selected;
}

-(void)scrollControl:(NSInteger)tag{
    
    UIButton * tempButton =  self.ButtonArray[tag];
    
    if(self.lastBtm){
        self.lastBtm.selected = false;
        tempButton.selected = true;
        self.lastBtm = tempButton;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.centerX = tempButton.centerX;
        tempButton.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }completion:^(BOOL finished) {
        tempButton.transform = CGAffineTransformIdentity;
    }];
   
}

@end
