// ACETelPrompt.h


#import <Foundation/Foundation.h>

@interface ACETelPrompt : NSObject

typedef void (^ACETelCallBlock)(NSTimeInterval duration);
typedef void (^ACETelCancelBlock)(void);

+ (BOOL)callPhoneNumber:(NSString *)phoneNumber
                   call:(ACETelCallBlock)callBlock
                 cancel:(ACETelCancelBlock)cancelBlock;

@end
