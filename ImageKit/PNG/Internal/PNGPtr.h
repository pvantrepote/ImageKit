//
//  PNGPtr.h
//  Gfx
//
//  Created by Pascal Vantrepote on 10-09-15.
//  Copyright 2010 Tamajii Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <libpng/png.h>

typedef enum {
	PNGPtrTypeRead,
	PNGPtrTypeWrite,
} PNGPtrType;

@class PNGInfo;

@interface PNGPtr : NSObject {
	@private
	png_structp png_ptr;
	png_infop info_ptr;
	png_infop end_info;
	PNGPtrType type;
	
}

@property (nonatomic, readonly) png_structp png_ptr;
@property (nonatomic, readonly) png_infop info_ptr;
@property (nonatomic, readonly) png_infop end_info;
@property (nonatomic, readonly) PNGPtrType type;

-(id) initWithType:(PNGPtrType) type_;
-(void) dealloc;

@end

@interface PNGWritePtr : PNGPtr 

-(void) writeImage:(UIImage*) image;

@end