//
//  SettingViewController.m
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/07/04.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//

#import "SettingViewController.h"
#import "NickNameTableViewController.h"


@implementation SettingViewController

@synthesize nickNameString_;

//イニシャライザ
-(id)init{
    self = [super init];
    if (self) {
    }
    return self;
}





-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"設定";
    dataSource  = [[NSArray alloc] initWithObjects:@"ニックネーム",@"音楽",@"音量",nil];
    
   }


//テーブルのセル数を返す
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataSource count];
}

//インデックスのパスを指定
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    
    cell.textLabel.text = [dataSource objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {

        UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 30)];
        nickNameLabel.text = @"aaaa";
        NSLog(@"%@",nickNameLabel.text);
        
        if (nickNameString_ != nil) {
        nickNameLabel.text =nickNameString_;
        }
        [cell.contentView addSubview:nickNameLabel];
        
    }
    

    [self updateCell:cell atIndexPath:indexPath];
    
    return  cell;
}


//セルの遷移処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    NSLog(@"%@",nickNameString_);
    
    NSArray *transitionArray = [NSArray arrayWithObjects:@"NickNameTable", nil];
    if (indexPath.row == 0) {
        NickNameTableViewController *nickname = [self.storyboard instantiateViewControllerWithIdentifier:transitionArray[indexPath.row]];
        [self.navigationController pushViewController:nickname animated:YES];
        
        
    }
    
}


//update
-(void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath{
    
}

-(void)upDateVIsibleCells{
    for (UITableViewCell *cell in [self.tableView visibleCells]) {
        [self updateCell:cell atIndexPath:[self.tableView indexPathForCell:cell]];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

