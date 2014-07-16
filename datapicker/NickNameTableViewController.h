//
//  NickNameTableViewController.h
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/07/14.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"

@interface NickNameTableViewController : UITableViewController<UITextFieldDelegate>
{
    NSArray *dataSource;
    UITextField *nickNameTextfld;
    NSString *nickNameString;
}

@end
