//
//  ConstantManager.h
//  BallGame
//
//  Created by 武淅 段 on 16/5/25.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConstantManager : NSObject


@property (nonatomic) NSArray *redBalls;

+ (instancetype)shareManager;
@end
