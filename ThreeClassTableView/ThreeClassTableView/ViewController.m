//
//  ViewController.m
//  ThreeClassTableView
//
//  Created by WP on 16/2/2.
//  Copyright © 2016年 xianlvke. All rights reserved.
//

#import "ViewController.h"
#import "WPAssociationMenuView.h"
#import "DataSoruceModel.h"
@interface ViewController ()<WPAssociationMenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong)WPAssociationMenuView *menuView;
/** 三级目录的数据  */
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuView = [WPAssociationMenuView menuViewWithDelegate:self];
    self.menuView.transformView = self.button.imageView;
    
    self.dataSource = [DataSoruceModel dataForArrayNesting];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.775 green:0.947 blue:0.836 alpha:1.000];
    

    
}


- (IBAction)clickBtnShowMenu:(UIButton *)sender {
    if (self.menuView.isShow) {
        [self.menuView dismissMenu];
        
    } else {
        [self.menuView showMenuAsDrawDownView:sender];
    }
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (self.menuView.isShow) {
        [self.menuView dismissMenu];
    }
}

#pragma mark - WPAssociationMenuViewDelegate
- (NSInteger)assciationMenuViewCountForClass_1:(WPAssociationMenuView *)asView {
    return [self.dataSource[0] count];
}

- (NSInteger)assciationMenuViewCountForClass_2:(WPAssociationMenuView *)asView atClass_1:(NSInteger)idx_1 {
    return [self.dataSource[1][idx_1] count];
}

- (NSInteger)assciationMenuViewCountForClass_3:(WPAssociationMenuView *)asView atClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 {
    return [self.dataSource[2][idx_1][idx_2] count];
    
}




- (NSString*)assciationMenuView:(WPAssociationMenuView *)asView titleForClass_1:(NSInteger)idx_1 {
    
    return self.dataSource[0][idx_1];
}

- (NSString*)assciationMenuView:(WPAssociationMenuView *)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 {
    
    return self.dataSource[1][idx_1][idx_2];
}

- (NSString*)assciationMenuView:(WPAssociationMenuView *)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3 {
    
    return self.dataSource[2][idx_1][idx_2][idx_3];
}



- (BOOL)assciationMenuView:( WPAssociationMenuView *)asView idxChooseInClass1:(NSInteger)idx_1{
    
    NSLog(@"点击 第一级 %lu",idx_1);
    return [self.dataSource[1][idx_1] count];
}

- (BOOL)assciationMenuView:(WPAssociationMenuView *)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2{
    NSLog(@"点击 第二级 %lu-%lu",idx_1,idx_2);
    return [self.dataSource[2][idx_1][idx_2] count];
}

- (BOOL)assciationMenuView:(WPAssociationMenuView *)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3{
    
    NSLog(@"点击 第三级 %lu-%lu-%lu",idx_1,idx_2,idx_3);
    
    return YES;
    
}



@end
