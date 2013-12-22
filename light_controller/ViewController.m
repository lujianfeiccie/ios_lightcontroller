//
//  ViewController.m
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"
#import "Page1.h"
#import "Page2.h"
#import "Page3.h"
#import "OtherTool.h"
@interface ViewController ()
@property (nonatomic,strong)UIScrollView *m_sc;//滚动视图
@property (nonatomic,strong)UIPageControl *m_pageC;//滚动指示器
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self buildLayout];
    [self MyLog:@"viewdidload"];
    
    //加入设置按钮
    UIBarButtonItem *barsettingButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Public_Setting", STRING_TABLE, nil) style:UIBarButtonItemStyleBordered target:self action:@selector(settingbtnClick)];
    [OtherTool setToolBarBtn:barsettingButton];
    self.navigationItem.leftBarButtonItem = barsettingButton;
}


-(void) settingbtnClick{
    // NSLog(@"settingclick");
    // 获取故事板中某个View
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"settinglist"];
    
    [[mApp navController] pushViewController:next animated:YES];
}

-(void)buildLayout
{
    self.m_sc.delegate =self;
    [self.m_pageC addTarget:self action:@selector(tapBotAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.m_sc];
    [self.view addSubview:self.m_pageC];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIScrollView *)m_sc
{
    if (!_m_sc)
    {
        _m_sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height)];
        [_m_sc setContentSize:CGSizeMake(self.view.frame.size.width * NUM_OF_PAGES,self.view.frame.size.height)];
        
        [self MyLog:@"get storyboard"];
        if(mApp==nil){
            mApp=[[UIApplication sharedApplication] delegate];
            mApp.delegateForScrollPage = self;
        }
        // 获取故事板
        UIStoryboard *board = mApp.storyBoard;
        // 获取故事板中某个View
        
        //第一页
        Page1 *page1 = [board instantiateViewControllerWithIdentifier:@"page1"];
        page1.view.frame =CGRectMake(0,0 , self.view.bounds.size.width,
                                     self.view.bounds.size.height);
        
      //  NSLog(@"rootview bounds width=%f height=%f",self.view.bounds.size.width,self.view.bounds.size.height);
       // NSLog(@"rootview frame width=%f height=%f",self.view.frame.size.width,self.view.frame.size.height);
        page1.view.backgroundColor = [UIColor blackColor];
        [_m_sc addSubview:page1.view];//加入到ScrollView
        
        //第二页
        Page2* page2 = [board instantiateViewControllerWithIdentifier:@"page2"];
        page2.view.frame =CGRectMake(self.view.bounds.size.width,0 , self.view.bounds.size.width,
                                     self.view.bounds.size.height);
        page2.view.backgroundColor = [UIColor blackColor];
        [_m_sc addSubview:page2.view];//加入到ScrollView
        
        //第三页
       Page3* page3 = [board instantiateViewControllerWithIdentifier:@"page3"];
        page3.view.frame =CGRectMake(self.view.bounds.size.width * 2,0 , self.view.bounds.size.width,
                                     self.view.bounds.size.height);
        page3.view.backgroundColor = [UIColor blackColor];
        [_m_sc addSubview:page3.view];//加入到ScrollView

       
        _m_sc.showsHorizontalScrollIndicator =NO; //是否显示水平滚动条
        _m_sc.showsVerticalScrollIndicator =NO;//是否垂直水平滚动条
        _m_sc.pagingEnabled =YES;  //是否翻页
        _m_sc.scrollEnabled =YES;  //是否可滚动
    }
    return _m_sc;
}

-(UIPageControl *)m_pageC
{
    if (!_m_pageC)
    {
        NSInteger heightOffset = 70;
               /* if (iPhone5) {
            heightOffset = 50;
        }*/
        if (IsIOS7) {
            heightOffset = 90;
        }
        _m_pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(60,self.view.frame.size.height-heightOffset,200,30)];//页面控制条区域
        
        [self MyLog:[NSString stringWithFormat:@"viewheight:%f",self.view.frame.size.height]];
        _m_pageC.backgroundColor = [UIColor clearColor]; //透明背景
        _m_pageC.currentPageIndicatorTintColor = [UIColor whiteColor];//当前页面圆点颜色
        _m_pageC.pageIndicatorTintColor = [UIColor blackColor];//未选中圆点颜色
        _m_pageC.numberOfPages = NUM_OF_PAGES;//页面数
        
    }
    return _m_pageC;
}
- (void)tapBotAction:(id)sender{
   
   // int index = [(UIButton *)sender tag];
    NSInteger index = _m_pageC.currentPage;
    [self MyLog:[NSString stringWithFormat:@"tapBotAction %i",index ]];

    NSInteger width = self.view.bounds.size.width;
    [_m_sc setContentOffset:CGPointMake(index * width, 0) animated:YES];
}
-(void)onPageScrollEnable: (Boolean) enable{
    _m_sc.pagingEnabled =enable;  //是否翻页
    _m_sc.scrollEnabled =enable;  //是否可滚动
}
#pragma mark
#pragma mark UIScrollViewDelegate method
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int size  = self.view.frame.size.width;
    int page = self.m_sc.contentOffset.x/size;
    self.m_pageC.currentPage = page;
}

-(void) MyLog: (NSString*) msg{
    #if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
    #endif
}
@end
