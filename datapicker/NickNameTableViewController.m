//
//  NickNameTableViewController.m
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/07/14.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//

#import "NickNameTableViewController.h"



@interface NickNameTableViewController ()


@end

@implementation NickNameTableViewController

@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"ニックネーム";
    dataSource  = [[NSArray alloc] initWithObjects:@"ニックネーム",nil];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = @"cell";
    UILabel *nickNameLabel;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    
    cell.textLabel.text = [dataSource objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIFont *textfont = [UIFont systemFontOfSize:17.0];
    
    //ラベル
    nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 130, 50)];
    nickNameLabel.backgroundColor = [UIColor clearColor];
    [nickNameLabel setFont:textfont];
    [cell.contentView addSubview:nickNameLabel];
    
    //テキスト
    nickNameTextfld = [[UITextField alloc] initWithFrame:CGRectMake(200, 0, 140, 50)];
    nickNameTextfld.delegate = self;
    [nickNameTextfld setFont:textfont];
    nickNameTextfld.autocapitalizationType = UITextAutocapitalizationTypeNone;
    nickNameTextfld.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    
    if (indexPath.row == 0) {
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        if(userdefaults == nil){
            nickNameTextfld.placeholder = @"default";
        }
        nickNameTextfld.placeholder = [userdefaults objectForKey:@"nickName"];
        nickNameTextfld.returnKeyType = UIReturnKeyDone;
        nickNameTextfld.secureTextEntry = NO;
        
        
        
        
        
        
    }
    [cell.contentView addSubview:nickNameTextfld];
    
    [self updateCell:cell atIndexPath:indexPath];

    
    
    return cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == nickNameTextfld) {
        
        nickNameString = nickNameTextfld.text;
        NSLog(@"%@",nickNameString);
        [textField resignFirstResponder];
        
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nickNameString forKey:@"nickName"];
    
    
    [delegate nicknametableviewcontroller:self didClose:nickNameString];

  
    
    
    
    
    return  YES;
}

//デリゲートメソッドの実装



-(void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath{
    
}

-(void)upDateVIsibleCells{
    for (UITableViewCell *cell in [self.tableView visibleCells]) {
        [self updateCell:cell atIndexPath:[self.tableView indexPathForCell:cell]];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
