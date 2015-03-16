//
//  HttpProxy.m
//  NSProxy
//
//  Created by Robert on 15/3/16.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import "HttpProxy.h"
#import <objc/runtime.h>

@interface HttpProxy ()

//保存映射关系的字典。
@property(strong, nonatomic) NSMutableDictionary *selToHandlerMap;

@end

@implementation HttpProxy

static HttpProxy *proxy = nil;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
#warning NSProxy 不能init
        proxy = [HttpProxy alloc];
        proxy.selToHandlerMap = [NSMutableDictionary new];
    });
    return proxy;
}

- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler {
    
    unsigned int numberOfMethods = 0;
    
    //Get all methods in protocol
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(
                                                                                 httpProtocol, YES, YES, &numberOfMethods);
    //Register protocol methods
    for (unsigned int i = 0; i < numberOfMethods; i++) {
        struct objc_method_description method = methods[i];
        [_selToHandlerMap setValue:handler forKey:NSStringFromSelector(method.name)];
    }
}

//获取Method signature
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    
    //获取method的字符串表示
    NSString *methodsName = NSStringFromSelector(sel);
    
    //查找对应实现类对象
    id handler = [_selToHandlerMap valueForKey:methodsName];
    
    //再次检查handler是否可以相应此消息
    if (handler != nil && [handler respondsToSelector:sel]) {
        return [handler methodSignatureForSelector:sel];
    } else {
        return [super methodSignatureForSelector:sel];
    }
}

//转发方法消息
- (void)forwardInvocation:(NSInvocation *)invocation {
    
    NSString *methodsName = NSStringFromSelector(invocation.selector);
    
    id handler = [_selToHandlerMap valueForKey:methodsName];
    
    if (handler != nil && [handler respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:handler];
    } else {
        [super forwardInvocation:invocation];
    }
}
@end
