//
//  BaseTabBarViewController.m
//  DLVideo
//
//  Created by DalinXie on 17/1/20.
//  Copyright © 2017年 itdarlin. All rights reserved.
//
/**
 *  
 *
 */
#import "BaseTabBarViewController.h"
#import "DLTabBar.h"
#import "DLBaseNavigationViewController.h"
#import "DLLaunchViewController.h"
@interface BaseTabBarViewController ()<DLTabBarDelegate>
@property (nonatomic, strong) DLTabBar * DLtabBar;

@end

@implementation BaseTabBarViewController

- (DLTabBar *)DLtabBar{
    if(!_DLtabBar){
        _DLtabBar = [[DLTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _DLtabBar.delegate = self;
    }
    return _DLtabBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildVc];
    [self setupUI];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
}

-(void)setupUI{
    
    [self.tabBar addSubview:self.DLtabBar];
    
}
-(void)addChildVc{
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:@[@"DLMainViewController",@"DLMeViewController"]];
    for(NSInteger i = 0; i < array.count; i++){
        NSString * vcName = array[i];
        UIViewController * vc = [[NSClassFromString(vcName) alloc] init];
        DLBaseNavigationViewController * navVc = [[DLBaseNavigationViewController alloc] initWithRootViewController:vc];
        [array replaceObjectAtIndex:i withObject:navVc];
    }
    self.viewControllers = array;
}

- (void)DLTabBar:(DLTabBar *) tabBar clickButton:(DLTabBarItemType) type{
    
    if(type != DLTabBarTypeLaunch){
        self.selectedIndex = type - DLTabBarTypeLive;
        return;
    }
    DLLaunchViewController * launchView = [[DLLaunchViewController alloc] init];
    [self presentViewController:launchView animated:true completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
