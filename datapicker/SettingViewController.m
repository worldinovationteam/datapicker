//
//  SettingViewController.m
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/07/04.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//

#import "SettingViewController.h"



@implementation SettingViewController




/*--イニシャライザ
-(id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

--*/



-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = @"設定";
    dataSource  = [[NSArray alloc] initWithObjects:@"ニックネーム",@"キャラクターの使用について",nil];
    
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
    
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    cell.textLabel.text = [dataSource objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
       
        nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 30)];
        
        if (userdefaults == nil) {
            nickNameLabel.text = @"default";
        }
                
        nickNameLabel.text = [userdefaults objectForKey:@"nickName"];
        
        NSLog(@"%@",nickNameLabel.text);
        
        
        [cell.contentView addSubview:nickNameLabel];
        
    }
    
    
    
    return  cell;
}


//セルの遷移処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
   
    
    NSArray *transitionArray = [NSArray arrayWithObjects:@"NickNameTable", nil];
    if (indexPath.row == 0) {
        
        NickNameTableViewController *nickname = [self.storyboard instantiateViewControllerWithIdentifier:transitionArray[indexPath.row]];
        nickname.delegate = self;
        [self.navigationController pushViewController:nickname animated:YES];
        
        
    }
    
    
    if (indexPath.row == 1) {
        CharacterViewController *character = [[CharacterViewController alloc] init];
        character.modalTransitionStyle =UIModalTransitionStyleCrossDissolve;
        [self presentViewController:character animated:YES completion:nil];
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


//デリゲードメソッドを呼び出す
-(void)nicknametableviewcontroller:(NickNameTableViewController *)nicknametableviewcontroller didClose:(NSString *)message{
    
    nickNameLabel.text = message;
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

