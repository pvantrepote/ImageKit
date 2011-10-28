//
//  PNGIHDR.h
//  ImageKit
//
//  Created by Pascal Vantrepote on 11-10-27.
//  Copyright (c) 2011 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PNGPtr;
@class PNGWritePtr;

@interface PNGInfo : NSObject {
	@private
	BOOL swapAlpha;
	NSDictionary* texts;
}

@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) int bit_depth;
@property (nonatomic, assign) int color_type;
@property (nonatomic, assign) BOOL interlaced;
@property (nonatomic, assign) float dpi;
@property (nonatomic, retain) NSDictionary* texts;

-(id) init;
-(id) initWithPth:(PNGPtr*) pth;
-(id) initWithCGImage:(CGImageRef) image;
-(id) initWithUIImage:(UIImage*) image;

-(BOOL) readFromPtr:(PNGPtr*) ptr;
-(BOOL) writeToPtr:(PNGWritePtr*) ptr;

@end
