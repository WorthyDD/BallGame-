//
//  ConstantManager.m
//  BallGame
//
//  Created by 武淅 段 on 16/5/25.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "ConstantManager.h"

@implementation ConstantManager


+ (instancetype)shareManager
{
    static ConstantManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ConstantManager alloc]init];
    });
    return manager;
}
@end
