//
//  ViewController.m
//  微信浮窗公开课
//
//  Created by 八点钟学院 on 2018/5/30.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "ViewController.h"
#import "EOCNextViewController.h"
#import "EOCWeChatFloatingBtn.h"

@interface UINavigationController (EOC)

@end

@implementation UINavigationController (EOC)

- (UIViewController *)childViewControllerForStatusBarStyle {
    
    if (self.navigationController.topViewController == self.childViewControllers[0]) {
        return self.childViewControllers[0];
    }
    
    return self.childViewControllers.lastObject;
    
}

@end

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self customNavigationBar];
    
    [self.view addSubview:self.table];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}

#pragma mark - 自定义导航栏
- (void)customNavigationBar {
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 64.f)];
    navView.backgroundColor = [UIColor colorWithRed:74.f/255.f green:74.f/255.f blue:74.f/255.f alpha:1.f];
    
    [self.view addSubview:navView];
    
}

#pragma mark - UITableView delegate && datasource method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = @"八点钟学院";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EOCNextViewController *nextViewCtrl = [EOCNextViewController new];
    [self.navigationController pushViewController:nextViewCtrl animated:YES];
    
}

#pragma mark - UITableView getter method
- (UITableView *)table {
    
    if (!_table) {
    
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 64.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        
    }
    
    return _table;
}


@end
