//
//  WPAssociationMenuView.h
//  ThreeClassTableView
//
//  Created by WP on 16/2/2.
//  Copyright © 2016年 xianlvke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPAssociationMenuView;
@protocol  WPAssociationMenuViewDelegate <NSObject>



@end

/**
 *  三级子菜单
 */
@interface WPAssociationMenuView : UIView 

@property (nonatomic, weak) id<WPAssociationMenuViewDelegate> delegate;
/** 选择时可以旋转 180 度 ^ */
@property (nonatomic, weak) UIView *transformView;
/**
 *  设置选中项，default -1 未选中
 *
 *  @param idx_1  第一级选中项
 *  @param idx_2  第二级选中项
 *  @param idx_3  第三级选中项
 */
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3;
/**
 *  菜单显示在View的下面
 *
 *  @param view 显示在该view下
 */
- (void)showMenuAsDrawDownView:(UIView *) view;
/** 隐藏菜单 */
- (void)dismissMenu;

@end
