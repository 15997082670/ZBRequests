//
//  newCell.m
//  ZBRequest-master
//
//  Created by 张斌斌 on 17/3/23.
//  Copyright © 2017年 张斌. All rights reserved.
//

#import "newCell.h"
#import "UIImageView+WebCache.h"
#define ZB_SCREEN_W   [UIScreen mainScreen].bounds.size.width
#define ZB_SCREEN_H [UIScreen mainScreen].bounds.size.height
#define ZB_CAL(b)  ZB_SCREEN_H*b/736
#define ZB_NUMBER(a) [NSNumber numberWithFloat:ZB_CAL(a)]
@implementation newCell

+ (instancetype)theShareCellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"newCell";
    newCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[newCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;;
    }
    cell.opaque=YES;
    cell.layer.drawsAsynchronously=YES;
    cell.layer.rasterizationScale=[UIScreen mainScreen].scale;
    return cell;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
        
    {
        
        [self createView];
        self.contentView.backgroundColor=[UIColor whiteColor];
        
    }
    
    return self;
    
}



-(void)createView
{
    
    
    
    
    _LeftImage=[UIImageView new];
   
    [self.contentView addSubview:_LeftImage];
    [_LeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(ZB_CAL(10));
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(ZB_CAL(-10));
        make.width.mas_equalTo(ZB_CAL(100));
        make.top.equalTo(self.contentView.mas_top).with.offset(ZB_CAL(10));
    }];
    
    
    
    
    
    //愿望描述
    
    _title =[UILabel new];
    _title.backgroundColor=[UIColor whiteColor];
    _title.textColor=[UIColor blackColor];
    _title.numberOfLines=0;
    _title.font=[UIFont systemFontOfSize:ZB_CAL(15)];
    _title.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make)
     {
         
         make.left.equalTo(_LeftImage.mas_right).offset(ZB_CAL(10));
         make.right.equalTo(self.contentView.mas_right).offset(ZB_CAL(-10));
         make.top.equalTo(self.contentView.mas_top).offset(ZB_CAL(10));
        // make.height.equalTo(ZB_NUMBER(20));
         
         
     }];
    
    

    
    
    
    
    
    //愿望描述
    _company=[UILabel new];
    _company.font=[UIFont systemFontOfSize:ZB_CAL(13)];
    _company.textAlignment=NSTextAlignmentRight;
    _company.backgroundColor=[UIColor whiteColor];
    _company.textColor=[UIColor grayColor];
    
    [self.contentView addSubview:_company];
    [_company mas_makeConstraints:^(MASConstraintMaker *make)
     {
         
         make.right.equalTo(self.contentView.mas_right).with.offset(ZB_CAL(-10));
         make.bottom.equalTo(self.contentView.mas_bottom);
         make.height.equalTo(ZB_NUMBER(25));
         make.width.equalTo(ZB_NUMBER(150));
         
         
     }];
    
    
  
    
 
  
    
    
    
}


- (void)reloadDataWithBox:(newsBox *)box{
    [_LeftImage sd_setImageWithURL:[NSURL URLWithString:box.picUrl]];
    _title.text=box.title;
    _company.text=box.ctime;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
