//
//  ZWSRequest.m
//  233wangxiaoHD
//
//  Created by 周文松 on 13-11-29.
//  Copyright (c) 2013年 长沙 二三三网络科技有限公司. All rights reserved.
//


#import "ZWSRequest.h"

static NSString * const FORM_FLE_INPUT = @"file";
@implementation ZWSRequest


- (void)dealloc
{
    
}
#pragma mark - post请求
+ (NSURLConnection *)POST:(NSString *)URLString parameter:(id)parameter hasAsync:(BOOL)hasAsync success:(void (^)(NSString *responseString))success failure:(void (^)(NSString *msg, NSString *state))failure;
{
    NSMutableURLRequest *request= [self requestWithMethod:@"POST" parameter:parameter  URLString:URLString];
    if (hasAsync) {
        return [[self new] dataWithRequest:request completionHandler:^(NSError *error, NSString *responseString)
                {
                    
                    if (error) {
                        if (failure)
                        {
                            
                            failure([NSString stringWithFormat:@"%@ \n",[error localizedDescription]], kNetworkAnomaly);
                        }
                    } else {
                        if (success)
                        {
                            success(responseString);
                        }
                    }
                    
                }];

    }
    else
    {
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *responseString = [[NSString alloc]
                             initWithBytes:[data bytes]
                             length:[data length]
                             encoding:NSUTF8StringEncoding];

        if (error) {
            if (failure)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                failure([NSString stringWithFormat:@"%@",[error localizedDescription]], kNetworkAnomaly);
                });
            }
        } else {
            if (success)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                success(responseString);
                });
            }
        }
        
        return nil;
        
    }
    return nil;
    
}

+ (NSMutableURLRequest *)requestWithMethod:(NSString *)method parameter:(id)parameter URLString:(NSString *)URLString;
{
    
    NSURL *url = [NSURL URLWithString:[URLString URLEncodedString]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url       cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    
    //计算POST提交数据的长度
    NSMutableString *myRequestString = [NSMutableString string];
    
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:(parameter?parameter:@{}) options:NSJSONWritingPrettyPrinted error:&error];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    [request setHTTPBody:postData];
    [request setHTTPMethod:method];
    
    
    

    
    return request;
}

/*
+ (NSMutableURLRequest *)requestWithMethod:(NSString *)method URLString:(NSString *)URLString;
{
    
    
    NSURL *url = [NSURL URLWithString:[URLString URLEncodedString]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:method];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:0 forHTTPHeaderField:@"Content-Length"];
    
    
    return request;
}
*/

/*
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge

{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        //if ([trustedHosts containsObject:challenge.protectionSpace.host])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}
*/

- (NSURLConnection *)dataWithRequest:(NSURLRequest *)request completionHandler:(void (^)( NSError * error, NSString *responseString))completionHandler;
{
    
    _CompletionHandler = completionHandler;
    _receivedData = [[NSMutableData alloc] init];
    //    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request     delegate:self];
    if (connection == nil) {
        // 创建失败
        return nil;
    }
    
    return connection;
}

// 收到回应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"receive the response");
    // 注意这里将NSURLResponse对象转换成NSHTTPURLResponse对象才能去
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    if ([response respondsToSelector:@selector(allHeaderFields)])
    {
        NSDictionary *dictionary = [httpResponse allHeaderFields];
                NSLog(@"allHeaderFields: %@",dictionary);
    }
    [_receivedData setLength:0];
}

// 接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receivedData appendData:data];
    
}

// 数据接收完毕
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *results = [[NSString alloc]
                         initWithBytes:[_receivedData bytes]
                         length:[_receivedData length]
                         encoding:NSUTF8StringEncoding];
    
    _CompletionHandler(nil, results);    
}

// 返回错误
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed: %@", error);
    
    _CompletionHandler(error, nil);
}




#pragma mark - 图片上传
+ (void)postRequestWithURL: (NSString *)url  postParems: (NSMutableDictionary *)postParems images:(NSArray *)images picFileName: (NSString *)picFileName success:(void(^)(id datas))success failure:(void (^)(NSString *msg ))failure;  // IN
{
    
    NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //得到图片的data
    NSData* data;
    
    
    
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [postParems allKeys];
    
    //    //遍历keys
    for(int i=0;i<[keys count];i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[postParems objectForKey:key]];
    }
    
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    
    //        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    for (UIImage *image in images)
    {
        if(image){
            NSMutableString *imgbody = [[NSMutableString alloc] init];
            
            ////添加分界线，换行
            [imgbody appendFormat:@"%@\r\n",MPboundary];
            
            //声明pic字段，文件名为boris.png
            [imgbody appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",FORM_FLE_INPUT,picFileName];
            //声明上传文件的格式
            [imgbody appendFormat:@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n"];
            
            [myRequestData appendData:[imgbody dataUsingEncoding:NSUTF8StringEncoding]];
            //将image的data加入
            //判断图片是不是png格式的文件
            //            if (UIImagePNGRepresentation(image)) {
            //                //返回为png图像。
            //                data = UIImagePNGRepresentation(image);
            //            }else {
            //                //返回为JPEG图像。
            //                data = UIImageJPEGRepresentation(image, 0.1);
            //            }
            
            data = UIImageJPEGRepresentation([self imageWithImage:image scaledToSize:CGSizeMake( 300, 300)],0.1);
            [myRequestData appendData:[ @"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
    }
    
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data;boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
         if (!error && responseCode >= 200 && responseCode < 300)
         {
             NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             NSLog(@"%@",dict);
             NSString *result = dict[@"resultCode"];
             NSString *msg = dict[@"msg"];
             
             if ([result isEqualToString:@"000000"] )
             {
                 success(dict);
             }
             else
             {
                 failure(msg);
             }
         }
         else
         {
             failure([error localizedDescription]);
         }
         
     }];
    
    
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}



@end
