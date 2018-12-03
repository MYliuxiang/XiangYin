//
//  WXDataService.m
//  MyWeibo
//
//  Created by zsm on 14-3-5.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "WXDataService.h"
#import "AFNetworkActivityIndicatorManager.h"

/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL NO
/**
 *  SSL 证书名称，仅支持cer格式。
 */
#define certificate @"1234"

#define kTimeOutInterval 30 // 请求超时的时间

@implementation WXDataService

//网络监听
+ (void)startNetWorkMonitoringWithBlock:(BANetworkStatusBlock)networkStatus{
    
    /*! 1.获得网络监控的管理者 */
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    /*! 当使用AF发送网络请求时,只要有网络操作,那么在状态栏(电池条)wifi符号旁边显示  菊花提示 */
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    /*! 2.设置网络状态改变后的处理 */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*! 当网络状态改变了, 就会调用这个block */
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                networkStatus ? networkStatus(BANetworkStatusUnknown) : nil;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                networkStatus ? networkStatus(BANetworkStatusNotReachable) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机自带网络");
                networkStatus ? networkStatus(BANetworkStatusReachableViaWWAN) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi 网络");
                networkStatus ? networkStatus(BANetworkStatusReachableViaWiFi) : nil;
                break;
        }
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];

    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

}

#pragma mark - 创建请求者
+(AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 超时时间
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    return manager;
}
//+ (AFHTTPSessionManager *)requestAFWithURL:(NSString *)url
//                                    params:(NSDictionary *)params
//                                httpMethod:(NSString *)httpMethod
//                                     isHUD:(BOOL)ishud
//                               finishBlock:(NetFinishBlock)finishBlock
//                                errorBlock:(ErrorBlock)errorBlock
//{
//    
//    if (ishud) {
//       
//        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//
//    }
//    
//    AFHTTPSessionManager *manager = [self manager];
//    
//    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"ostype"];
////    [manager.requestSerializer setValue:[YCKeyChainHelper getDeviceIdentifier] forHTTPHeaderField:@"devid"];
//
//
//    
//    // 加上这行代码，https ssl 验证。
//    if(openHttpsSSL)
//    {
//        [manager setSecurityPolicy:[self customSecurityPolicy]];
//    }
//
//    manager.requestSerializer.timeoutInterval = 10.f;
//    RequestType type;
//    if ([httpMethod isEqualToString:@"GET"])
//    {
//        type = RequestGetType;
//    
//    }else{
//        type = RequestPostType;
//    
//    }
//    
//    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:params];
//    BOOL isImage;
//    for (NSString *key in mdic) {
//        if ([key isEqualToString:@"anchor_background"]) {
//            [mdic removeObjectForKey:key];
//            isImage = YES;
//        }
//    }
//    
////    NSDictionary *dic = [HttpHelper httpParams:mdic];
////    if (isImage) {
////        [dic setValue:params[@"anchor_background"] forKey:@"anchor_background"];
////
////    }
//
//    
//    
//    switch (type) {
//            
//        case RequestGetType:
//        {
//            [manager GET:url parameters:mdic progress:^(NSProgress * _Nonnull downloadProgress) {
//                
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                
//                if (ishud) {
//                    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
//                    
//                }
//                
//                if (finishBlock != nil) {
//                   
//                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                   
//                    finishBlock([NSDictionary changeType:result]);
//                }
//                
//                
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                
//                if (ishud) {
//                    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
//                    
//                }
//                if (errorBlock != nil) {
//                    
//                    NSLog(@"Error: %@", [error localizedDescription]);
//                    
//                    errorBlock(error);
//                }
//                
//                
//            }];
//
//        }
//            break;
//        case RequestPostType:
//        {
//            
//            [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
//                
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                if(ishud){
//                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
//                }
//                if (finishBlock != nil) {
//                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                             finishBlock([NSDictionary changeType:result]);
//                }
//                
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                
//                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
//                if (errorBlock != nil) {
//                    
//                    errorBlock(error);
//                }
//            }];
//
//        }
//            break;
//        default:
//            break;
//    }
//
//    return manager;
//
//
//}


+ (AFHTTPSessionManager *)postMP3:(NSString *)url
                           params:(NSDictionary *)params
                         fileData:(NSData *)fileData
                      finishBlock:(NetFinishBlock)finishBlock
                       errorBlock:(ErrorBlock)errorBlock
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    AFHTTPSessionManager *manager = [self manager];
    // 加上这行代码，https ssl 验证。
    if(openHttpsSSL)
    {
        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:@"recoder" fileName:@"recoder.mp3" mimeType:@"mp3"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (finishBlock != nil) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            finishBlock(result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (errorBlock != nil) {
            errorBlock(error);
        }
    }];
    
    return manager;
    
}

+ (AFHTTPSessionManager *)postImage:(NSString *)url
                             params:(NSDictionary *)params
                           fileData:(NSData *)fileData
                        finishBlock:(NetFinishBlock)finishBlock
                         errorBlock:(ErrorBlock)errorBlock
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    AFHTTPSessionManager *manager = [self manager];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"ostype"];
//    [manager.requestSerializer setValue:[YCKeyChainHelper getDeviceIdentifier] forHTTPHeaderField:@"devid"];
    // 加上这行代码，https ssl 验证。
    if(openHttpsSSL)
    {
        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:@"filename" fileName:@"my.png" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (finishBlock != nil) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            finishBlock(result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (errorBlock != nil) {
            
            errorBlock(error);
        }
        
    }];
    
    return manager;
    
}



+ (AFHTTPSessionManager *)syncrequestAFWithURL:(NSString *)url
                                    params:(NSDictionary *)params
                                httpMethod:(NSString *)httpMethod
                               finishBlock:(NetFinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock
{
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
  
    AFHTTPSessionManager *manager = [self manager];
    
    // 加上这行代码，https ssl 验证。
    if(openHttpsSSL)
    {
        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }

    RequestType type;
    if ([httpMethod isEqualToString:@"GET"])
    {
        type = RequestGetType;
    }else{
        type = RequestPostType;
        
    }
    switch (type) {
        case RequestGetType:
        {
            
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (errorBlock != nil) {
                    
                    errorBlock(error);
                }
                
            }];
            
            
        }
            break;
        case RequestPostType:
        {
            
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (errorBlock != nil) {
                    
                    errorBlock(error);
                }
            }];
            
        }
            break;
        default:
            break;
    }
    

    return manager;
    
    
}


+ (AFHTTPSessionManager *)requestAFWithURL:(NSString *)url
                                   parames:(NSDictionary *)params
                                 imageArry:(NSArray  *)imageArry
                               finishBlock:(NetFinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock
{
    
    AFHTTPSessionManager *manager = [self manager];
    
    // 加上这行代码，https ssl 验证。
    if(openHttpsSSL)
    {
        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }
    
    [MBProgressHUD showMessag:@"正在上传,请稍后..." toView:[UIApplication sharedApplication].keyWindow];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for(int i=0;i<imageArry.count;i++){
            
            if ([imageArry[i] isKindOfClass:[UIImage class]]) {
                UIImage  * img=imageArry[i];
                
                NSData  * feedbackImg =UIImageJPEGRepresentation(img, 0.5);
//                NSData  * feedbackImg =UIImageJPEGRepresentation(img, 0.5);
                [formData appendPartWithFileData:feedbackImg name:@"photo" fileName:@"photo" mimeType:@"image/jpeg"];
                
            }else if([imageArry[i] isKindOfClass:[NSData class]]){
                NSData *videoData = [imageArry objectAtIndex:i];
                [formData appendPartWithFileData:videoData name:@"file" fileName:@"video1.mov" mimeType:@"video/quicktime"];
            }
        }
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        //        [pross removeFromSuperview];
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        finishBlock(dic1);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (errorBlock != nil) {
            
            errorBlock(error);
        }
        
        
    }];

    return manager;
    
}

+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}

@end
