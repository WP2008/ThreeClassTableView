//
//  ViewController.m
//  ThreeClassTableView
//
//  Created by WP on 16/2/2.
//  Copyright © 2016年 xianlvke. All rights reserved.
//

#import "ViewController.h"
#import "WPAssociationMenuView.h"
@interface ViewController ()<WPAssociationMenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong)WPAssociationMenuView *menuView;

/** 三级目录的数据  */
@property (nonatomic, strong) NSMutableArray<NSArray*> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView = [[WPAssociationMenuView alloc]init];
    self.menuView.delegate = self;
    self.menuView.transformView = self.button.imageView;
    self.menuView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    
    
    
    NSArray <NSString *>* class1_Title = @[@"区域", @"地铁"];
    NSArray <NSString *>* class11_Title = @[@"铁西区", @"大东区", @"沈河区", @"于洪区"];
    NSArray <NSString *>* class12_Title = @[@"附近",@"沈阳北站",@"沈阳南站",@"中街站",@"西直门",@"兜率宫"];
    
    
    
    NSArray <NSString *>* class121Title = @[@"100",@"101米",@"102米",@"103米",@"104米", @"105米", @"106米"];
    NSArray <NSString *>* class122Title = @[@"100",@"101米",@"102米",@"103米",@"104米", @"105米", @"106米", @"107米"];
    NSArray <NSString *>* class123Title = @[@"100",@"101米",@"102米",@"103米",@"104米", @"105米", @"106米", @"107米", @"108米"];
    NSArray <NSString *>* class124Title = @[@"100",@"101米",@"102米",@"103米",@"104米", @"105米", @"106米", @"107米", @"108米", @"109米"];
    NSArray <NSString *>* class125Title = @[@"100",@"101米",@"102米",@"103米",@"104米", @"105米", @"106米", @"107米", @"108米", @"109米", @"110米"];
    NSArray <NSString *>* class126Title = @[@"100",@"101米",@"102米",@"103米",@"104米", @"105米", @"106米", @"107米", @"108米", @"109米", @"110米",@"120213"];
    
    /** 使用数组套数组的格式 */
    
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObject:class1_Title];
    [self.dataSource addObject:@[ class11_Title, class12_Title ]];
    [self.dataSource addObject:@[
                                 @[ class121Title,
                                    class122Title,
                                    class123Title,
                                    class124Title ],
                                 @[
                                     class121Title,
                                     class122Title,
                                     class123Title,
                                     class124Title,
                                     class125Title,
                                     class126Title
                                     ]
                                 ]];
    
}


- (IBAction)clickBtnShowMenu:(UIButton *)sender {
    
    [self.menuView showMenuAsDrawDownView:sender];
    
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
    return [self.dataSource[1][idx_1] count];
}

- (BOOL)assciationMenuView:(WPAssociationMenuView *)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2{
    return [self.dataSource[2][idx_1][idx_2] count];
}

- (BOOL)assciationMenuView:(WPAssociationMenuView *)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3{
    return YES;
    
}



@end
