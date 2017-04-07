//
//  ViewController.m
//  ZBRequest
//
//  Created by 张斌斌 on 17/4/7.
//  Copyright © 2017年 张斌. All rights reserved.
//

#import "ViewController.h"
#import "httpTool.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "newsBox.h"
#import "YYCache.h"
#import "newCell.h"
@interface ViewController ()<
UITableViewDataSource,
UITableViewDelegate,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>
@property(strong,nonatomic)UITableView*myTableview;
@property(strong,nonatomic)NSMutableArray *dataArry;
@property(copy,nonatomic)NSString *content;
@property(assign,nonatomic)int num;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block typeof(self)weakSelf=self;
    self.content=@"keji";
    self.num=10;
    _dataArry=[NSMutableArray array];
    [self.view addSubview:self.myTableview];
    
    //先加载缓存
    YYCache *cache=[YYCache cacheWithName:@"theNewsList"];
    if ([cache containsObjectForKey:self.content]) {
        [self analysisDataWithDictionary:(NSDictionary*)[cache objectForKey:self.content] andType:YES];
        [self.myTableview reloadData];
    }
    // 下拉刷新
    self.myTableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([weakSelf checkeNetStatue]) {
            [weakSelf loadDataWithBool:YES];
        }else{
            [weakSelf.myTableview.mj_header endRefreshing];
            UILabel *headerLab=[UILabel new];
            headerLab.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 38);
            headerLab.text=@"没有网络连接，请稍后重试";
            headerLab.backgroundColor=[UIColor colorWithRed:208/255.0f green:228/255.0f blue:240/255.0f alpha:1.0];
            headerLab.textColor=[UIColor colorWithRed:56/255.0f green:154/255.0f blue:216/255.0f alpha:1.0];
            headerLab.textAlignment=NSTextAlignmentCenter;
            weakSelf.myTableview.tableHeaderView=headerLab;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    weakSelf.myTableview.tableHeaderView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
                    weakSelf.myTableview.tableHeaderView=nil;
                } completion:^(BOOL finished) {
                    
                }];
                
            });
        }
        
        
        
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.myTableview.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.myTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if ([weakSelf checkeNetStatue]) {
            [weakSelf loadDataWithBool:NO];
        }else{
            [weakSelf.myTableview.mj_footer endRefreshing];
            UILabel *headerLab=[UILabel new];
            headerLab.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 38);
            headerLab.text=@"没有网络连接，请稍后重试";
            headerLab.backgroundColor=[UIColor colorWithRed:208/255.0f green:228/255.0f blue:240/255.0f alpha:1.0];
            headerLab.textColor=[UIColor colorWithRed:56/255.0f green:154/255.0f blue:216/255.0f alpha:1.0];
            headerLab.textAlignment=NSTextAlignmentCenter;
            weakSelf.myTableview.tableFooterView=headerLab;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    weakSelf.myTableview.tableFooterView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height+38, [UIScreen mainScreen].bounds.size.width, 0);
                    weakSelf.myTableview.tableFooterView=nil;
                } completion:^(BOOL finished) {
                    
                }];
                
            });
        }
        
        
        
    }];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.myTableview.mj_header beginRefreshing];
    
}
//MARK:-LOAD DATA
- (void)loadDataWithBool:(BOOL)type{
    if (!type) {
        self.num+=10;
    }
    NSString *urlstr = [NSString stringWithFormat:@"http://api.tianapi.com/%@/?key=52a9ca67f0f797110011bb98770a3163&num=%d",self.content,self.num];
    [httpTool ZBGetNetDataWith:urlstr withDic:nil andSuccess:^(NSDictionary* dictionary) {
        
        [self analysisDataWithDictionary:dictionary andType:type];
        [self.myTableview.mj_header endRefreshing];
        [self.myTableview.mj_footer endRefreshing];
        [self.myTableview reloadData];
        //将数据进行本地存储
        YYCache *cache=[YYCache cacheWithName:@"theNewsList"];
        [cache setObject:dictionary forKey:self.content];
    } andFailure:^{
        [self.myTableview.mj_header endRefreshing];
        [self.myTableview.mj_footer endRefreshing];
    }];
    
}
//MARK:ANALYSIS

- (void)analysisDataWithDictionary:(NSDictionary*)dictionary andType:(BOOL)type{
    NSMutableArray *tempArry=[NSMutableArray array];
    NSArray *dataArry=dictionary[@"newslist"];
    for (NSDictionary *dic in dataArry) {
        newsBox *box=[[newsBox alloc]initWithDic:dic];
        [tempArry addObject:box];
    }
    type?(_dataArry=[tempArry mutableCopy]):([_dataArry addObjectsFromArray:[tempArry copy]]);
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    newCell *cell=[newCell theShareCellWithTableView:tableView];
    [cell reloadDataWithBox:_dataArry[indexPath.row]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArry.count;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //  [self.navigationController pushViewController:[jiazhengmessageController new] animated:YES];
    
    
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //分割线补全
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

//MARK:-EMPTY TABLE DELEGATE
- (nullable UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    
    UIImage *image=[UIImage imageNamed:@"notask_icon"];
    return image;
    
}


//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
//    NSString *text = @"要闻为您服务";
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor], NSParagraphStyleAttributeName: paragraph};
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//
//}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

//MARK:-GETTER
- (UITableView *)myTableview
{
    if (!_myTableview) {
        _myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
        _myTableview.delegate = self;
        _myTableview.dataSource = self;
        [self.view addSubview:_myTableview];
        _myTableview.contentSize=CGSizeMake(0, [UIScreen mainScreen].bounds.size.height);
        _myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableview.emptyDataSetSource=self;
        _myTableview.emptyDataSetDelegate=self;
        _myTableview.scrollEnabled = YES;
        
    }
    return _myTableview;
    
}

//MARK: CHECK OUT NET STATUES
- (BOOL)checkeNetStatue{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (appDelegate.statue==NotReachable) {
        NSLog(@"请设置网络");
        return NO;
    }else{
        return YES;
    }
}
@end


