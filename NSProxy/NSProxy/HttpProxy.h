//
//  HttpProxy.h
//  NSProxy
//
//  Created by Robert on 15/3/16.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserHttpHandler.h"
#import "CommentHttpHandler.h"

@interface HttpProxy : NSProxy <UserHttpHandler, CommentHttpHandler>

//获取单例
+ (instancetype)sharedInstance;

//注册具体实现类
- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler;

@end
