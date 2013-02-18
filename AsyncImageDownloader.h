//
//  AsyncImageDownloader.h
//
//  Created by Kyle Banks on 2012-11-29.
//

#import <Foundation/Foundation.h>

@interface AsyncImageDownloader : NSObject <NSURLConnectionDelegate>
{
    NSMutableData *imageData;
    
    //Callback blocks
    void (^successCallback)(UIImage *image);
    void (^failCallback)(NSError *error);
}

@property NSString *mediaURL;

-(id)initWithMediaURL:(NSString *)theMediaURL successBlock:(void (^)(UIImage *image))success failBlock:(void(^)(NSError *error))fail;

-(void)startDownload;

@end