//
//  newsBox.m
//  ZBRequest-master
//
//  Created by 张斌斌 on 17/3/22.
//  Copyright © 2017年 张斌. All rights reserved.
//

#import "newsBox.h"

@implementation newsBox
- (id)initWithDic:(NSDictionary *)info
{
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:info];
    }
    
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    return;
}

@end
