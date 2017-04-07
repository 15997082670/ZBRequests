//
//  newsBox.h
//  ZBRequest-master
//
//  Created by 张斌斌 on 17/3/22.
//  Copyright © 2017年 张斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newsBox : NSObject
/*
 ctime : 2017-03-21 17:42;
	title : 百度：举报！一帮黑客正在偷我们无人汽车的机密;
	description : 腾讯科技;
	url : http://tech.qq.com/a/20170321/034682.htm;
	picUrl : http://inews.gtimg.com/newsapp_ls/0/1292591199_300240/0
 */
@property(copy,nonatomic)NSString*ctime;
@property(copy,nonatomic)NSString*title;
@property(copy,nonatomic)NSString*url;
@property(copy,nonatomic)NSString*picUrl;
- (id)initWithDic:(NSDictionary *)info;
@end
