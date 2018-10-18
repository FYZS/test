//
//  NSObject+imageSize.m
//  gitStar
//
//  Created by 凡义 on 2018/10/15.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import "NSObject+imageSize.h"

@implementation NSObject (imageSize)

- (CGSize)getImageSizeWithURL:(id)imageURL {
    NSURL *URL = nil;
    
    //第一步排查异常参数
    if([imageURL isKindOfClass:[NSURL class]]) {
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]) {
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil) {
        return CGSizeZero;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    NSString *pathExtension = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtension isEqualToString:@"png"]) {
        size = [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtension isEqualToString:@"gif"]) {
        size = [self getGIFImageSizeWithRequest:request];
    }
    else {
        size = [self getJPGImageSizeWithRequest:request];
    }
    
    if(CGSizeEqualToSize(CGSizeZero, size)) {
        // 如果获取文件头信息失败,发送异步请求请求原图
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}

- (CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest *)request {
    //通过设置Range可以指定每次从下载数据包的大小和位置, 16-23指从第16字节到第23字节的数据
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8) {
      //前4个字节为width, 后4个字节为height
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(0, 1)];
        [data getBytes:&h2 range:NSMakeRange(1, 1)];
        [data getBytes:&h3 range:NSMakeRange(2, 1)];
        [data getBytes:&h4 range:NSMakeRange(3, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

- (CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest *)request {
    //通过设置Range可以指定每次从下载数据包的大小和位置, 16-23指从第16字节到第23字节的数据
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4) {
        //前2个字节为width, 后2个字节为height
        int w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        int w = (w2 << 8) + w1;
        int h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0, 1)];
        [data getBytes:&h2 range:NSMakeRange(1, 1)];
        int h = (h2 << 8) + h1;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

- (CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest *)request {
    //通过设置Range可以指定每次从下载数据包的大小和位置, 16-23指从第16字节到第23字节的数据
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}
@end
