//
//  WPAssociationMenuView.m
//  ThreeClassTableView
//
//  Created by WP on 16/2/2.
//  Copyright © 2016年 xianlvke. All rights reserved.
//

#import "WPAssociationMenuView.h"

static NSString * const WPAssociationCellID = @"WPAssociationCellID";

@interface WPAssociationMenuView()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate> {
    /** 纪录子菜单选中状态 */
    NSInteger sels[3];
    /** 3 级菜单的tableView  */
    NSMutableArray *tables;
    /** 背景View */
    UIView *bgView;
}

@end

@implementation WPAssociationMenuView

#pragma mark - lifeCycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    tables = [NSMutableArray array];
    // 初始化选择项
    for(int i=0; i!=3; ++i) {
        sels[i] = 0;
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.tableFooterView = [[UIView alloc]init];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:WPAssociationCellID];
        [tables addObject:tableView];
    }

    self.userInteractionEnabled = YES;
    
    bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor blueColor];
    bgView.userInteractionEnabled = YES;
    [bgView addSubview:tables.firstObject];

}

#pragma mark - privateMathod
- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置 bgView 的Frame
    bgView.frame = self.bounds;
    // 设置 tableView的 frame
    int __block showTableCount = 0;
    [tables enumerateObjectsUsingBlock:^(UITableView *table, NSUInteger idx, BOOL *stop) {
        if(table.superview) {
        
            showTableCount ++;
        }
    }];
    
    for(int i=0; i != showTableCount; ++i){
        UITableView *table = [tables objectAtIndex:i];
        CGRect frame = table.frame;
        frame.size.width  = bgView.frame.size.width / showTableCount;
        frame.size.height = bgView.frame.size.height;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = bgView.bounds.origin.y;
        table.frame = frame;
    }
    
}

/** 保存table选中项 */
- (void)saveSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *table, NSUInteger idx, BOOL *stop) {
        sels[idx] = table.superview ? table.indexPathForSelectedRow.row : -1;
        
    }];
}

/** 加载保存的选中项 */
- (void)loadSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *table, NSUInteger i, BOOL *stop) {
        [table selectRowAtIndexPath:[NSIndexPath indexPathForRow:sels[i]
                          inSection:0]
                           animated:NO
                     scrollPosition:UITableViewScrollPositionNone];
        // 如果table 被选中 还没有添加 且不是第一个
        if((sels[i] != -1 && !table.superview) || !i) {
            [bgView addSubview:table];
            
            [UIView animateWithDuration:0.2 animations:^{
                if (self.transformView) {
                    self.transformView.transform = CGAffineTransformMakeRotation(M_PI);
                }
            }];
        }
    }];
}

#pragma mark - publicMathod
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3 {
    sels[0] = idx_1;
    sels[1] = idx_2;
    sels[2] = idx_3;
}

- (void)showMenuAsDrawDownView:(UIView *)view {
    CGRect showFrame = self.frame;
    showFrame.origin.y = view.frame.origin.y + view.frame.size.height;
    self.frame = showFrame;
    
    if(!bgView.superview) {
        [self addSubview:bgView];
    }
    [self loadSels];
    
    // 将自己添加到最上层
    if(!self.superview) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
            self.alpha = 0.0f;
        [UIView animateWithDuration:0.25f animations:^{
            self.alpha = 1.0f;
        }];
    }
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self];
}

- (void)dismissMenu {
    if(self.superview) {
        [UIView animateWithDuration:0.25f animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [bgView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
                [view removeFromSuperview];
            }];
            [self removeFromSuperview];
            [UIView animateWithDuration:0.2 animations:^{
                if (self.transformView) {
                    self.transformView.transform = CGAffineTransformMakeRotation(0);
                }
            }];
        }];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger __block count;
    [tables enumerateObjectsUsingBlock:^(UITableView *table, NSUInteger idx, BOOL *stop) {
        if (table == tableView) {
            switch (idx) {
                case 0:
                    count = [_delegate assciationMenuViewCountForClass_1:self];
                    break;
                case 1:
                    count = [_delegate assciationMenuViewCountForClass_2:self atClass_1:sels[0]];
                    break;
                case 2:
                    count = [_delegate assciationMenuViewCountForClass_3:self atClass_1:sels[0] class_2:sels[1]];
                    break;
                default:
                    break;
            }
            *stop = YES;
        }
        
    }];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WPAssociationCellID forIndexPath:indexPath];
    if(tableView == [tables objectAtIndex:0]){
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:indexPath.row];
    }else if(tableView == [tables objectAtIndex:1]){
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)tables[0]).indexPathForSelectedRow.row class_2:indexPath.row];
    }else if(tableView == [tables objectAtIndex:2]){
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)tables[0]).indexPathForSelectedRow.row class_2:((UITableView*)tables[1]).indexPathForSelectedRow.row class_3:indexPath.row];
    }     return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 保存选中项
   [self saveSels];
    UITableView *t0 = [tables objectAtIndex:0];
    UITableView *t1 = [tables objectAtIndex:1];
    UITableView *t2 = [tables objectAtIndex:2];
    BOOL isNexClass = true;
    if(tableView == t0){
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:indexPath.row];
        }
        if(isNexClass) {
            [t1 reloadData];
            if(!t1.superview) {
                [bgView addSubview:t1];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
//            [self adjustTableViews];
        }else{
            if(t1.superview) {
                [t1 removeFromSuperview];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
//            [self saveSels];
            [self dismissMenu];
        }
    }else if(tableView == t1) {
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:indexPath.row];
        }
        if(isNexClass){
            [t2 reloadData];
            if(!t2.superview) {
                [bgView addSubview:t2];
            }
//            [self adjustTableViews];
        }else{
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
//            [self saveSels];
            [self dismissMenu];
        }
    }else if(tableView == t2) {
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:class3:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:t1.indexPathForSelectedRow.row class3:indexPath.row];
        }
        if(isNexClass) {
//            [self saveSels];
            [self dismissMenu];
        }
    }

    
    
}

@end

