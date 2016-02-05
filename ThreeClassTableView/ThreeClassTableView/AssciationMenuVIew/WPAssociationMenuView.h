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

/**
 *  获取第class级菜单的数据数量
 *
 *  @param asView 联想菜单
 *  @param idx_i   第几级
 *
 *  @return 第class级菜单的数据数量
 */
- (NSInteger)assciationMenuViewCountForClass_1:(WPAssociationMenuView *)asView;
- (NSInteger)assciationMenuViewCountForClass_2:(WPAssociationMenuView *)asView atClass_1:(NSInteger)idx_1;
- (NSInteger)assciationMenuViewCountForClass_3:(WPAssociationMenuView *)asView atClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2;


/**
 *  获取第一级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *
 *  @return 标题
 */
- (NSString*)assciationMenuView:(WPAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1;

/**
 *  获取第二级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *
 *  @return 标题
 */
- (NSString*)assciationMenuView:(WPAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2;

/**
 *  获取第三级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *  @param idx_3  第三级
 *
 *  @return 标题
 */
- (NSString*)assciationMenuView:(WPAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3;

@optional
/**
 *  取消选择
 */
- (void)assciationMenuViewCancel;

/**
 *  选择第一级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *
 *  @return 是否展示下一级
 */
- (BOOL)assciationMenuView:(WPAssociationMenuView*)asView idxChooseInClass1:(NSInteger)idx_1;
/**
 *  选择第二级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *
 *  @return 是否展示下一级
 */
- (BOOL)assciationMenuView:(WPAssociationMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2;
/**
 *  选择第三级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *  @param idx_3  第三级
 *
 *  @return 是否dismiss
 */
- (BOOL)assciationMenuView:(WPAssociationMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3;

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
