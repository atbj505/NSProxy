//
//  main.m
//  NSProxy
//
//  Created by Robert on 15/3/16.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserHttpHandlerImp.h"
#import "CommentHttpHandlerImp.h"
#import "HttpProxy.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //初始化，注册Protocol对应的实现类对象
        [[HttpProxy sharedInstance] registerHttpProtocol:@protocol(UserHttpHandler) handler:[UserHttpHandlerImp new]];
        [[HttpProxy sharedInstance] registerHttpProtocol:@protocol(CommentHttpHandler) handler:[CommentHttpHandlerImp new]];
        
        //调用
        [[HttpProxy sharedInstance] getUserWithID:@100];
        [[HttpProxy sharedInstance] getCommentsWithDate:[NSDate new]];
    }
    return 0;
}
