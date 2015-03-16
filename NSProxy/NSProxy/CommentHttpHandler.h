//
//  CommentHttpHandler.h
//  NSProxy
//
//  Created by Robert on 15/3/16.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommentHttpHandler <NSObject>

//评论相关接口
- (void)getCommentsWithDate:(NSDate *)date;

@end
