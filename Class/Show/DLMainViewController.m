//
//  DLMainViewController.m
//  DLVideo
//
//  Created by DalinXie on 17/1/21.
//  Copyright © 2017年 itdarlin. All rights reserved.
//

#import "DLMainViewController.h"
#import "DLTopView.h"
#import "UIView+Frame.h"

@interface DLMainViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray * arrayTitleList;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (nonatomic, strong) DLTopView * topView;

@end

@implementation DLMainViewController

-(NSArray *)arrayTitleList{
    if (!_arrayTitleList) {
        _arrayTitleList = @[@"关注",@"热门",@"附近"];
    }
    return _arrayTitleList;
}

-(DLTopView *)topView{
    if(!_topView){
        _topView = [[DLTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 20) titleName:self.arrayTitleList];
        @weakify(self);
        _topView.block = ^(NSInteger tag){
            @strongify(self);
            [self.mainScrollView setContentOffset:CGPointMake(tag * SCREEN_WIDTH, self.mainScrollView.xmg_y) animated:true];
        };
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNav];
    [self setupUI];
    [self addChildVcViewIntoScrollView:0];
}
- (void)setupNav{
    
    self.navigationItem.titleView = self.topView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
}

- (void)setupUI{
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:@[@"DLFocusViewController", @"DLHotViewController", @"DLNearViewController"]];
    
    for (NSInteger i = 0; i < array.count; i++) {
        NSString * vcName = array[i];
        UIViewController * childVc = [[NSClassFromString(vcName) alloc] init];
        //childVc.title = self.arrayTitleList[i];
        [self addChildViewController:childVc];
    }
    self.mainScrollView.frame = self.view.bounds;
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * array.count, 0);
    //self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    //self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    self.mainScrollView.scrollsToTop = NO;
    self.mainScrollView.pagingEnabled = true;

}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndDecelerating:scrollView];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat width = scrollView.xmg_width;
    
    CGFloat contentOffset = scrollView.contentOffset.x;
    
    NSInteger index = contentOffset / width;
    
    [self addChildVcViewIntoScrollView:index];
    
    [self.topView scrollControl:index];
}
- (void)addChildVcViewIntoScrollView:(NSUInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
    
    // 设置子控制器view的frame
    childVcView.frame = CGRectMake(index * self.mainScrollView.xmg_width, 0, self.mainScrollView.xmg_width, self.mainScrollView.xmg_height);
    // 添加子控制器的view到scrollView中
    //self.mainScrollView.contentOffset = CGPointMake(<#CGFloat x#>, <#CGFloat y#>)
    [self.mainScrollView addSubview:childVcView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
