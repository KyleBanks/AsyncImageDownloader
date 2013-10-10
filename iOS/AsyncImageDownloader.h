//
//  AsyncImageDownloader.h
//
//  Created by Kyle Banks on 2012-11-29.
//  Modified by Nicolas Schteinschraber 2013-05-30
//

#import <Foundation/Foundation.h>

@interface AsyncImageDownloader : NSObject <NSURLConnectionDelegate>
{
    NSMutableData *fileData;
    
    //Callback blocks
    void (^successCallbackFile)(NSData *data);
    void (^successCallback)(UIImage *image);
    void (^failCallback)(NSError *error);
}

@property NSString *mediaURL;
@property NSString *fileURL;

-(id)initWithMediaURL:(NSString *)theMediaURL successBlock:(void (^)(UIImage *image))success failBlock:(void(^)(NSError *error))fail;

-(id)initWithFileURL:(NSString *)theFileURL successBlock:(void (^)(NSData *data))success failBlock:(void(^)(NSError *error))fail;

-(void)startDownload;

@end