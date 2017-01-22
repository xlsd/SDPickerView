//
//  ViewController.m
//  PickerView
//
//  Created by 薛林 on 17/1/22.
//  Copyright © 2017年 xuelin. All rights reserved.
//

#import "ViewController.h"
#import "PlanPickview.h"

@interface ViewController ()<PlanViewDelegate>
@property (nonatomic, strong) PlanPickview *planView;//计划小弹窗
@property (nonatomic, strong) UIButton *coverBtn;//遮盖层按钮
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];\
    button.center = self.view.center;
    [self.view addSubview:button];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addCoverView) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addCoverView {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    UIButton *coverBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    coverBtn.backgroundColor = [UIColor blackColor];
    coverBtn.alpha = 0.5;
    self.coverBtn = coverBtn;
    //创建计划窗口
    PlanPickview *coverView = [[PlanPickview alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 275) * 0.5, (self.view.frame.size.height - 250) * 0.5, 275, 250)];
    coverView.delegate = self;
    self.planView = coverView;
    [window addSubview:coverBtn];
    [window addSubview:self.planView];
    [coverBtn addTarget:self action:@selector(clickCoverBtn:) forControlEvents:UIControlEventTouchUpInside];
}
//点击遮盖层
- (void)clickCoverBtn:(UIButton *)button {
    
    [button removeFromSuperview];
    [self.planView removeFromSuperview];
}

#pragma mark - delegate

- (void)learnPalnRateOneDay:(NSString *)planNum {
    [self clickCoverBtn:self.coverBtn];
    NSLog(@"每天练习:%@关",planNum);
}

@end
