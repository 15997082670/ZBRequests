//
//  newCell.h
//  ZBRequest-master
//
//  Created by 张斌斌 on 17/3/23.
//  Copyright © 2017年 张斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newsBox.h"
#import "Masonry.h"
@interface newCell : UITableViewCell
@property(strong,nonatomic)UIImageView*LeftImage;
@property (strong, nonatomic)UILabel *title;
@property (strong, nonatomic)UILabel *company;
@property(strong,nonatomic)UILabel *time;

- (void)reloadDataWithBox:(newsBox *)box;

+ (instancetype)theShareCellWithTableView:(UITableView *)tableView;
@end
