//
//  MainTabBarController.m
//  MyMovie
//
//  Created by zsm on 14-8-15.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "CityCircleVC.h"
#import "FoodandSpotVC.h"
#import "TransactionVC.h"
#import "MyVC.h"
#import "CenterVC.h"


typedef NS_ENUM(NSInteger,NTESMainTabType) {
    NTESMainTabTypeMessageList,    //聊天
    NTESMainTabTypeContact,        //通讯录
    NTESMainTabTypeChatroomList,   //聊天室
    NTESMainTabTypeSetting,        //设置
};

@interface MainTabBarController ()<AxcAE_TabBarDelegate,HyPopMenuViewDelegate>
@property (nonatomic, strong) HyPopMenuView* menu;

@end

static MainTabBarController *mainTVC = nil;

@implementation MainTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addChildViewControllers];
    _menu = [HyPopMenuView sharedPopMenuManager];
    PopMenuModel* model = [PopMenuModel
                           allocPopMenuModelWithImageNameString:@"发布主页-文字"
                           AtTitleString:@"文字"
                           AtTextColor:[UIColor grayColor]
                           AtTransitionType:PopMenuTransitionTypeCustomizeApi
                           AtTransitionRenderingColor:nil];
    
    PopMenuModel* model1 = [PopMenuModel
                            allocPopMenuModelWithImageNameString:@"发布主页-视频"
                            AtTitleString:@"视频"
                            AtTextColor:[UIColor grayColor]
                            AtTransitionType:PopMenuTransitionTypeCustomizeApi
                            AtTransitionRenderingColor:nil];
    
    PopMenuModel* model2 = [PopMenuModel
                            allocPopMenuModelWithImageNameString:@"发布主页-相册"
                            AtTitleString:@"相册"
                            AtTextColor:[UIColor grayColor]
                            AtTransitionType:PopMenuTransitionTypeCustomizeApi
                            AtTransitionRenderingColor:nil];
   
    
    _menu.dataSource = @[ model, model1, model2];
    _menu.delegate = self;
    _menu.popMenuSpeed = 12.0f;
    _menu.automaticIdentificationColor = false;
    _menu.animationType = HyPopMenuViewAnimationTypeViscous;
    
        UILabel* topView = [[UILabel alloc] init];
    topView.text = @"乡音";
    topView.font = [UIFont systemFontOfSize:32];
    topView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.frame), 92);
    topView.textAlignment = NSTextAlignmentCenter;
        _menu.topView = topView;
}

- (void)popMenuView:(HyPopMenuView*)popMenuView
didSelectItemAtIndex:(NSUInteger)index
{
    BaseNavigationController *nav;
    switch (index) {
        case 0:{
            nav = [[BaseNavigationController alloc] initWithRootViewController:[ReleaseTextVC new]];
            
        }
            
            break;
        case 1:
            nav = [[BaseNavigationController alloc] initWithRootViewController:[ReleaseVideoVC new]];

            break;
        case 2:
            nav = [[BaseNavigationController alloc] initWithRootViewController:[ReleasePhotoVC new]];

            break;
            
        default:
            break;
    }
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
}

- (void)addChildViewControllers{
    // 创建选项卡的数据 想怎么写看自己，这块我就写笨点了
    
    BaseNavigationController *nav1 = [[BaseNavigationController alloc] initWithRootViewController:[CityCircleVC new]];
    BaseNavigationController *nav2 = [[BaseNavigationController alloc] initWithRootViewController:[FoodandSpotVC new]];
    BaseNavigationController *nav3 = [[BaseNavigationController alloc] initWithRootViewController:[CenterVC new]];
    BaseNavigationController *nav4 = [[BaseNavigationController alloc] initWithRootViewController:[TransactionVC new]];
    BaseNavigationController *nav5 = [[BaseNavigationController alloc] initWithRootViewController:[MyVC new]];

    NSArray <NSDictionary *>*VCArray =
    @[@{@"vc":nav1,@"itemTitle":@"城市圈"},
      @{@"vc":nav2,@"itemTitle":@"美食美景"},
      @{@"vc":nav3,@"itemTitle":@""},
      @{@"vc":nav4,@"itemTitle":@"同城交易"},
      @{@"vc":nav5,@"itemTitle":@"我的"}];
    // 1.遍历这个集合
    // 1.1 设置一个保存构造器的数组
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    // 1.2 设置一个保存VC的数组
    NSMutableArray *tabBarVCs = @[].mutableCopy;
    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 2.根据集合来创建TabBar构造器
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        // 3.item基础数据三连
        model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTitle;
        model.titleLabel.font = [UIFont systemFontOfSize:14];
        model.itemTitle = [obj objectForKey:@"itemTitle"];
//        model.selectImageName = [obj objectForKey:@"selectImg"];
//        model.normalImageName = [obj objectForKey:@"normalImg"];
        // 4.设置单个选中item标题状态下的颜色
        model.selectColor = [UIColor blackColor];
        model.normalColor = [MyColor colorWithHexString:@"#959595"];
       
        model.normalTintColor = [UIColor whiteColor];
        
        /***********************************/
        if (idx == 2 ) { // 如果是中间的
            // 设置凸出
            model.bulgeStyle = AxcAE_TabBarConfigBulgeStyleSquare;
            // 设置凸出高度
            model.bulgeHeight = -5;
            model.bulgeRoundedCorners = 2; // 修角
            // 设置成纯文字展示
            model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTitle;
            // 文字为加号
            model.itemTitle = @"+";
            // 字号大小
            model.titleLabel.font = [UIFont systemFontOfSize:40];
            model.normalColor = [UIColor whiteColor]; // 未选中
            model.selectColor = [UIColor whiteColor];   // 选中后一致
            // 让Label上下左右全边距
            model.componentMargin = UIEdgeInsetsMake(-5, 0, 0, 0 );
            // 未选中选中为橘里橘气
            model.normalBackgroundColor = [UIColor orangeColor];
            model.selectBackgroundColor = [UIColor orangeColor];
            // 设置大小/边长
            model.itemSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 35.0 ,self.tabBar.frame.size.height - 10);
        }
        // 备注 如果一步设置的VC的背景颜色，VC就会提前绘制驻留，优化这方面的话最好不要这么写
        // 示例中为了方便就在这写了
        UIViewController *vc = [obj objectForKey:@"vc"];
       
        // 5.将VC添加到系统控制组
        [tabBarVCs addObject:vc];
        // 5.1添加构造Model到集合
        [tabBarConfs addObject:model];
    }];
    // 5.2 设置VCs -----
    // 一定要先设置这一步，然后再进行后边的顺序，因为系统只有在setViewControllers函数后才不会再次创建UIBarButtonItem，以免造成遮挡
    // 大意就是一定要让自定义TabBar遮挡住系统的TabBar
    self.viewControllers = tabBarVCs;
    //////////////////////////////////////////////////////////////////////////
    // 注：这里方便阅读就将AE_TabBar放在这里实例化了 使用懒加载也行
    // 6.将自定义的覆盖到原来的tabBar上面
    // 这里有两种实例化方案：
    // 6.1 使用重载构造函数方式：
    //    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:tabBarConfs];
    // 6.2 使用Set方式：
    self.axcTabBar = [AxcAE_TabBar new] ;
    self.axcTabBar.tabBarConfig = tabBarConfs;
    
    // 7.设置委托
    self.axcTabBar.delegate = self;
    // 8.添加覆盖到上边
    [self.tabBar addSubview:self.axcTabBar];
    [self addLayoutTabBar]; // 10.添加适配
}
// 9.实现代理，如下：
static NSInteger lastIdx = 0;
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    if (index != 2) { // 不是中间的就切换
        // 通知 切换视图控制器
        [self setSelectedIndex:index];
        lastIdx = index;
    }else{ // 点击了中间的
        [self.axcTabBar setSelectIndex:lastIdx WithAnimation:NO]; // 换回上一个选中状态
         _menu.backgroundType = HyPopMenuViewBackgroundTypeLightBlur;
        [_menu openMenu];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    if(self.axcTabBar){
        self.axcTabBar.selectIndex = selectedIndex;
    }
}

// 10.添加适配
- (void)addLayoutTabBar{
    // 使用重载viewDidLayoutSubviews实时计算坐标 （下边的 -viewDidLayoutSubviews 函数）
    // 能兼容转屏时的自动布局
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    [self.axcTabBar viewDidLayoutItems];
}
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

//单例方法
+ (instancetype)shareMainTabBarController
{
    return mainTVC;
    
}

@end
