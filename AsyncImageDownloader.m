//
//  AsyncImageDownloader.m
//
//  Created by Kyle Banks on 2012-11-29.
//

#import "AsyncImageDownloader.h"

@implementation AsyncImageDownloader

@synthesize mediaURL;

-(id)initWithMediaURL:(NSString *)theMediaURL successBlock:(void (^)(UIImage *image))success failBlock:(void(^)(NSError *error))fail;
{
    self = [super init];
    
    if(self)
    {
        [self setMediaURL:theMediaURL];
        successCallback = success;
        failCallback = fail;
    }
    
    return self;
}

//Perform the actual download
-(void)startDownload
{
    imageData = [[NSMutableData alloc] init];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:mediaURL]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if(!connection)
    {
        failCallback([NSError errorWithDomain:@"Failed to create connection" code:0 userInfo:nil]);
    }
}

#pragma mark NSURLConnection Delegate
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    failCallback(error);
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if([response respondsToSelector:@selector(statusCode)])
    {
        int statusCode = [((NSHTTPURLResponse *)response) statusCode];
        if (statusCode >= 400)
        {
            [connection cancel];
            failCallback([NSError errorWithDomain:@"Image download failed due to bad server response" code:0 userInfo:nil]);
        }
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [imageData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(imageData == nil)
    {
        failCallback([NSError errorWithDomain:@"No data received" code:0 userInfo:nil]);
    }
    else
    {
        UIImage *image = [UIImage imageWithData:imageData];
        successCallback(image);
    }    
}

@end