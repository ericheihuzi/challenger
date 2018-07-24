//
//  Copyright © 2017 Apple. All rights reserved.
//

#import <XCTest/XCTestDefines.h>

typedef NS_ENUM(NSInteger, XCTAttachmentLifetime) {
    
    /*
     * Attachment will be kept regardless of the outcome of the test.
     */
    XCTAttachmentLifetimeKeepAlways = 0,
    
    /*
     * Attachment will only be kept when the test fails, and deleted otherwise.
     */
    XCTAttachmentLifetimeDeleteOnSuccess = 1
};
