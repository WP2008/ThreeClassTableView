//
//  DataSoruceModel.m
//  ThreeClassTableView
//
//  Created by WP on 16/2/6.
//  Copyright © 2016年 xianlvke. All rights reserved.
//

#import "DataSoruceModel.h"


@implementation DataSoruceModel



+ (NSArray *)dataForArrayNesting {
    //class1
    NSArray <NSString *>* titlesFor_100 = @[@"1", @"2"];
    //class2
    NSArray <NSString *>* titlesFor_110 = @[@"1.1", @"1.2", @"1.3", @"1.4"];
    NSArray <NSString *>* titlesFor_120 = @[@"2.1", @"2.2", @"2.3"];
    //class3
    NSArray <NSString *>* titlesFor_111 = @[@"1.1.1", @"1.1.2"];
    NSArray <NSString *>* titlesFor_112 = @[@"1.2.1", @"1.2.2", @"1.2.3", @"1.2.4"];
    NSArray <NSString *>* titlesFor_113 = @[@"1.3.1", @"1.3.2", @"1.3.3", @"1.3.4" , @"1.3.5"];
    NSArray <NSString *>* titlesFor_114 = @[@"1.4.1"];
    
    NSArray <NSString *>* titlesFor_121 = @[@"2.1.1", @"2.1.2"];
    NSArray <NSString *>* titlesFor_122 = @[@"2.2.1", @"2.2.2", @"2.2.3", @"2.2.4"];
    NSArray <NSString *>* titlesFor_123 = @[@"2.3.1", @"2.3.2", @"2.3.3"];

    //  使用数组套数组的格式
    NSMutableArray *dataSource = [NSMutableArray array];
    [dataSource addObject:titlesFor_100];
    [dataSource addObject:@[titlesFor_110, titlesFor_120 ]];
    [dataSource addObject:@[
                                 @[ titlesFor_111,
                                    titlesFor_112,
                                    titlesFor_113,
                                    titlesFor_114 ],
                                 @[
                                     titlesFor_121,
                                     titlesFor_122,
                                     titlesFor_123
                                     ]
                                 ]];
    return dataSource;
}
@end
