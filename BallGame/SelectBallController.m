//
//  SelectBallController.m
//  BallGame
//
//  Created by 武淅 段 on 16/5/25.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "SelectBallController.h"
#import "CustomToast.h"
#import "ConstantManager.h"

@interface SelectBallController ()


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *redBalls;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *blueBalls;
@property (nonatomic) NSMutableArray *selectRedBalls;
@property (nonatomic, assign) NSInteger selectedBlueBall;

@end

@implementation SelectBallController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectRedBalls = [NSMutableArray new];
    _selectedBlueBall = -1;
    for(int i = 0; i< _redBalls.count;i++){
        UIButton *button = _redBalls[i];
        button.tag = i+1;
        [button setTitle:[NSString stringWithFormat:@"%.2d", i+1] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor redColor]];
        [button addTarget:self action:@selector(didTapBall:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    for(int i = 0; i< _blueBalls.count;i++){
        UIButton *button = _blueBalls[i];
        button.tag = i+100+1;
        [button setTitle:[NSString stringWithFormat:@"%.2d", i+1] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor blueColor]];
        [button addTarget:self action:@selector(didTapBall:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)didTapBall : (id)sender
{
    UIButton *button = sender;
    
    if(button.tag <100){
        if(!button.selected && ![_selectRedBalls containsObject:@(button.tag)] && _selectRedBalls.count<6){
            [_selectRedBalls addObject:@(button.tag)];
            button.selected = !button.selected;
        }
        else if(button.selected && [_selectRedBalls containsObject:@(button.tag)]){
            [_selectRedBalls removeObject:@(button.tag)];
            button.selected = !button.selected;
        }
    }
    else{
        for(UIButton *b in _blueBalls){
            if(b.tag == button.tag){
                b.selected = YES;
                _selectedBlueBall = b.tag-100;
            }
            else{
                b.selected = NO;
            }
        }
        
    }
}

- (IBAction)tapDone:(id)sender {
    
    if(_selectRedBalls.count != 6 || _selectedBlueBall == -1){
        [CustomToast showHudToastWithString:@"请正确选择"];
        return ;
    }
    //sort
    [_selectRedBalls sortUsingComparator:^NSComparisonResult(NSNumber  *obj1, NSNumber  *obj2) {
        return obj1.integerValue>obj2.integerValue;
    }];
    
    [_selectRedBalls addObject:@(_selectedBlueBall)];
    [ConstantManager shareManager].redBalls = [NSArray arrayWithArray:_selectRedBalls];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
