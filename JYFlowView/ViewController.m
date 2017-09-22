//
//  ViewController.m
//  JYFlowView
//
//  Created by 伟运体育 on 2017/9/22.
//  Copyright © 2017年 伟运体育. All rights reserved.
//

#import "ViewController.h"
#import "SportsFlowView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    //流动视图
    SportsFlowView *flowView = [[SportsFlowView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 110)];
    [self.view addSubview:flowView];
    [flowView scrolllToIndex:2];
    
    flowView.selectSportBlock = ^(NSString *sport) {
        NSLog(@"%@",sport);
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
