//
//  OpenGifyViewController.m
//  BallGame
//
//  Created by 武淅 段 on 16/5/25.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "OpenGifyViewController.h"
#import "ConstantManager.h"
#import "CustomToast.h"

@interface OpenGifyViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, assign) NSInteger count;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *allLabel;
@property (nonatomic) NSMutableArray *records;
@property (nonatomic, assign) NSInteger one;
@property (nonatomic, assign) NSInteger two;
@property (nonatomic, assign) NSInteger three;
@property (nonatomic, assign) NSInteger four;
@property (nonatomic, assign) NSInteger five;
@property (nonatomic, assign) NSInteger six;

@end

@implementation OpenGifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_signleNum && [ConstantManager shareManager].redBalls.count != 7){
        [CustomToast showHudToastWithString:@"请选择号码!"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入您想开奖的次数:" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
        
    }];
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *field = alert.textFields[0];
        NSString *text = field.text;
        if(text.length>0){
            self.count = text.integerValue;
            [self openGift];
        }
        
    }];
    [alert addAction:done];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void) openGift
{
    _one = 0;
    _two = 0;
    _three = 0;
    _four = 0;
    _five = 0;
    _six = 0;
    NSMutableArray *arr = [NSMutableArray new];
    _records = [NSMutableArray new];
    if(_signleNum){
        
        for(NSInteger  i = 0;i < _count;i++){
            
            [arr removeAllObjects];
            while(arr.count<6){
                NSInteger n = arc4random()%33+1;
                if(![arr containsObject:@(n)]){
                    [arr addObject:@(n)];
                }
            }
            NSInteger b = arc4random()%16+1;
            [arr addObject:@(b)];
            
           
            int rank = [self caculateArrayA:arr andArrayB:[ConstantManager shareManager].redBalls];
            if(rank > 0){
                switch (rank) {
                    case 1:
                        _one++;
                        break;
                    case 2:
                        _two++;
                        break;
                    case 3:
                        _three++;
                        break;
                    case 4:
                        _four++;
                        break;
                    case 5:
                        _five++;
                        break;
                    case 6:
                        _six++;
                        break;
                    default:
                        break;
                }
                NSString *record = [NSString stringWithFormat:@"第%ld局, %d等奖", i+1, rank];
                NSLog(@"%@", record);
                [_records addObject:record];
                [self.tableView reloadData];
            }
            
        }
    }
    else{
        for(NSInteger  i = 0;i < _count;i++){
            
            [arr removeAllObjects];
            while(arr.count<6){
                NSInteger n = arc4random()%33+1;
                if(![arr containsObject:@(n)]){
                    [arr addObject:@(n)];
                }
            }
            NSInteger b = arc4random()%16+1;
            [arr addObject:@(b)];
            
            NSMutableArray *tem = [NSMutableArray new];
            while(tem.count<6){
                NSInteger n = arc4random()%33+1;
                if(![tem containsObject:@(n)]){
                    [tem addObject:@(n)];
                }
            }
            b = arc4random()%16+1;
            [tem addObject:@(b)];
            
            int rank = [self caculateArrayA:arr andArrayB:tem];
            if(rank > 0){
                switch (rank) {
                    case 1:
                        _one++;
                        break;
                    case 2:
                        _two++;
                        break;
                    case 3:
                        _three++;
                        break;
                    case 4:
                        _four++;
                        break;
                    case 5:
                        _five++;
                        break;
                    case 6:
                        _six++;
                        break;
                    default:
                        break;
                }
                NSString *record = [NSString stringWithFormat:@"第%ld局, %d等奖", i+1, rank];
                NSLog(@"%@", record);
                [_records addObject:record];
                [self.tableView reloadData];
            }
            
        }
    }
    
    signed long long bingo = _six*5+_five*10+_four*200+_three*3000+1000000*_two+5000000*_one;
    [_allLabel setText:[NSString stringWithFormat:@"总结: 本次共模拟开奖%ld次\n 您中得6等奖%ld次, 5等奖%ld次, 4等奖%ld次, 3等奖%ld次, 2等奖%ld次, 1等奖%ld次\n 累计投入资金%ld元, 获益%lld元(2元一注), 净获利%lld元", _count, _six, _five, _four, _three,_two,_one, _count*2, bingo, bingo-_count*2]];
}




- (int) caculateArrayA : (NSArray *)A andArrayB : (NSArray *)B
{
    int red = 0;
    int blue = 0;
    for(int i = 0; i < 6;i++){
        NSNumber *a = A[i];
        for(int j = 0;j < 6;j++){
            NSNumber *b = B[j];
            if(a.integerValue == b.integerValue){
                red++;
            }
        }
    }
    NSNumber *a1 = [A lastObject];
    NSNumber *b1 = [B lastObject];
    if(a1.integerValue == b1.integerValue){
        blue = 1;
    }
    
    int rank = 0;
    
    if(red == 6 && blue == 1){
        
        rank = 1;
    }
    else if(red == 6 && blue == 0){
        
        rank = 2;
    }
    else if(red == 5 && blue == 1){
        
        rank = 3;
    }
    else if(red == 5 || (red == 4 && blue == 1)){
        
        rank = 4;
    }
    else if(red == 4 || (red == 3 && blue == 1)){
        rank = 5;
    }
    else if(blue == 1){
        rank = 6;
    }
    
    return rank;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.textLabel setText:_records[indexPath.row]];
    return cell;
}

@end
