//
//  SettingViewController.h
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/07/04.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NickNameTableViewController.h"
#import "Characterviewcontroller.h"


@interface SettingViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,NickNameDelegate>
{
    NSArray *dataSource;
    UILabel *nickNameLabel;
    
}


@end
