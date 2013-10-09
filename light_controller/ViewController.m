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
        
        // 获取故事板
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // 获取故事板中某个View
        
        //第一页
        Page1 *page1 = [board instantiateViewControllerWithIdentifier:@"page1"];
        page1.view.frame =CGRectMake(0,0 , self.view.bounds.size.width,
                                     self.view.bounds.size.height);
        page1.view.backgroundColor = [UIColor whiteColor];
        [_m_sc addSubview:page1.view];//加入到ScrollView
        
        //第二页
        Page2* page2 = [board instantiateViewControllerWithIdentifier:@"page2"];
        page2.view.frame =CGRectMake(self.view.bounds.size.width,0 , self.view.bounds.size.width,
                                     self.view.bounds.size.height);
        page2.view.backgroundColor = [UIColor greenColor];
        [_m_sc addSubview:page2.view];//加入到ScrollView
        
        //第三页
        Page3* page3 = [board instantiateViewControllerWithIdentifier:@"page3"];
        page3.view.frame =CGRectMake(self.view.bounds.size.width * 2,0 , self.view.bounds.size.width,
                                     self.view.bounds.size.height);
        page3.view.backgroundColor = [UIColor blueColor];
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
        _m_pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(60,430,200,30)];//页面控制条区域
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
    NSLog(@"tapBotAction %i",index);

    NSInteger width = self.view.bounds.size.width;
    [_m_sc setContentOffset:CGPointMake(index * width, 0) animated:YES];
}
#pragma mark
#pragma mark UIScrollViewDelegate method
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int size  = self.view.frame.size.width;
    int page = self.m_sc.contentOffset.x/size;
    self.m_pageC.currentPage = page;
}
@end
