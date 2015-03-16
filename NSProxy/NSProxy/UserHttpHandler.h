//
//  UserHttpHandler.h
//  NSProxy
//
//  Created by Robert on 15/3/16.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserHttpHandler <NSObject>

//用户相关接口
- (void)getUserWithID:(NSNumber *)userID;

@end

@interface UserHttpHandler : NSObject

@end
