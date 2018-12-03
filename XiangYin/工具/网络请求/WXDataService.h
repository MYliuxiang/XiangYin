//
//  WXDataService.m
//  MyWeibo
//
//  Created by zsm on 14-3-5.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"


/*! 使用枚举NS_ENUM:区别可判断编译器是否支持新式枚举,支持就使用新的,否则使用旧的 */
typedef NS_ENUM(NSUInteger, BANetworkStatus)
{
    /*! 未知网络 */
    BANetworkStatusUnknown           = 0,
    /*! 没有网络 */
    BANetworkStatusNotReachable,
    /*! 手机 3G/4G 网络 */
    BANetworkStatusReachableViaWWAN,
    /*! wifi 网络 */
    BANetworkStatusReachableViaWiFi
};


typedef void(^NetFinishBlock) (id result);
typedef void(^ErrorBlock) (NSError *error);
/*! 实时监测网络状态的 block */
typedef void(^BANetworkStatusBlock)(BANetworkStatus status);

typedef NS_ENUM(NSInteger, RequestType) {
    RequestPostType,
    RequestGetType
};
@interface WXDataService : NSObject

@property (nonatomic,assign)BOOL isHUD;

/**
*  请求通过回调
*
*  @param url          上传文件的 url 地址
*  @param paramsDict   参数字典
*  @param httpMethod   请求类型
*  @param finishBlock  成功
*  @param errorBlock   失败
*   
*/

+ (void)startNetWorkMonitoringWithBlock:(BANetworkStatusBlock)networkStatus;
+ (AFHTTPSessionManager *)requestAFWithURL:(NSString *)url
                                    params:(NSDictionary *)params
                                httpMethod:(NSString *)httpMethod
                                     isHUD:(BOOL)ishud
                               finishBlock:(NetFinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock;

+ (AFHTTPSessionManager *)postMP3:(NSString *)url
                           params:(NSDictionary *)params
                         fileData:(NSData *)fileData
                      finishBlock:(NetFinishBlock)finishBlock
                       errorBlock:(ErrorBlock)errorBlock;

+ (AFHTTPSessionManager *)postImage:(NSString *)url
                             params:(NSDictionary *)params
                           fileData:(NSData *)fileData
                        finishBlock:(NetFinishBlock)finishBlock
                         errorBlock:(ErrorBlock)errorBlock;

+ (AFHTTPSessionManager *)requestAFWithURL:(NSString *)url
                                   parames:(NSDictionary *)params
                                 imageArry:(NSArray  *)imageArry
                               finishBlock:(NetFinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock;


@end
