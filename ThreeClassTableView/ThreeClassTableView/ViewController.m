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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView = [[WPAssociationMenuView alloc]init];
    self.menuView.delegate = self;
    self.menuView.transformView = self.button.imageView;
    self.menuView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
}


- (IBAction)clickBtnShowMenu:(UIButton *)sender {
    
    [self.menuView showMenuAsDrawDownView:sender];
    
}
@end
