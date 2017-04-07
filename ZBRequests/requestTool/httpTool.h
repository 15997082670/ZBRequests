//
//  httpTool.h
//  DaGuanJia
//
//  Created by 张斌 on 16/11/30.
//  Copyright © 2016年 ck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface httpTool : NSObject
+ (void)ZBGetNetDataWith:(NSString*)str withDic:(NSDictionary*)dic andSuccess:(void(^)(NSDictionary* dictionary))successBlock  andFailure:(void(^)())failueBlock;

+ (void)ZBPostNetDataWith:(NSString*)str withDic:(NSDictionary*)dic andSuccess:(void(^)(NSDictionary* dictionary))successBlock  andFailure:(void(^)())failueBlock;

+ (void)postUploadWithUrl:(NSString *)urlStr parameters:(id)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName fileType:(NSString *)fileType success:(void (^)(id responseObject))success fail:(void (^)())fail;

+ (void)postUploadWithUrl:(NSString *)urlStr  uploadImages:(NSArray *)images completion:(void(^)(NSString *url,NSError *error))uploadBlock andPramaDic:(NSDictionary *)paramaDic;

+ (NSString*)nowTime:(NSString*)dateType;
@end
