//
//  PNGPtr.m
//  Gfx
//
//  Created by Pascal Vantrepote on 10-09-15.
//  Copyright 2010 Tamajii Inc.. All rights reserved.
//

#import "PNGPtr.h"

#import <cocoalumberjack/DDLog.h>

#import "Types.h"
#import "PNGFile.h"
#import "PNGInfo.h"

extern int ddLogLevel;

static void png_error_func(png_structp png_ptr, png_const_charp message) {
	
	DDLogCError(@"%s", message);
	
	/*
	 changed 20040224
	 From the libpng docs:
	 "Errors handled through png_error() are fatal, meaning that png_error()
	 should never return to its caller. Currently, this is handled via
	 setjmp() and longjmp()"
	 */
	//return;
	longjmp(png_jmpbuf(png_ptr), 1);
}

static void png_warn_func(png_structp png_ptr, png_const_charp message) {
	DDLogCWarn(@"%s", message);
}


@implementation PNGPtr

#pragma mark -
#pragma mark Properties

@synthesize png_ptr, end_info, info_ptr, type;

#pragma mark -
#pragma mark Init/Dealloc

-(id) initWithType:(PNGPtrType) type_  {
	if ((self = [super init]) != nil) {
		png_ptr = NULL;
		info_ptr = NULL;
		end_info = NULL;
		
		type = type_;
		switch (type) {
			case PNGPtrTypeRead: {
				png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, png_error_func, png_warn_func);
				if (png_ptr) {
					info_ptr = png_create_info_struct(png_ptr);
					if (info_ptr) end_info = png_create_info_struct(png_ptr);
				} 
			}
				break;
			case PNGPtrTypeWrite: {
				png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, png_error_func, png_warn_func);
				if (png_ptr) {
					info_ptr = png_create_info_struct(png_ptr);
				} 				
			}
				break;
		}
		
		if (!png_ptr) {
			[self release];
			return nil;
		}
	}
	
	return self;
}

-(void) dealloc {
	if (png_ptr) {
		switch (type) {
			case PNGPtrTypeRead:
				png_destroy_read_struct(&png_ptr, (info_ptr) ? &info_ptr : NULL, 
												  (end_info) ? &end_info : NULL);
				break;
			case PNGPtrTypeWrite:
				png_destroy_write_struct(&png_ptr, (info_ptr) ? &info_ptr : NULL);			
				break;
		}
	}
	
	[super dealloc];
}

@end

@implementation PNGWritePtr

-(id) init {
	if ((self = [super initWithType:PNGPtrTypeWrite]) != nil) {
	}
	
	return self;
}

#pragma mark - Public methods

-(void) writeImage:(UIImage*) image {
	PNGInfo* info = [[PNGInfo alloc] initWithUIImage:image];
	[info writeToPtr:self];
	
	CFDataRef datas = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
	UInt8* pixels = (UInt8*)CFDataGetBytePtr(datas);
	
	UInt32 height = (UInt32) info.height;
	UInt32 bytesPerRow = CGImageGetBytesPerRow(image.CGImage);
	
	png_bytep row_pointers[height];
	for (UInt32 k = 0; k < height; k++)
		row_pointers[k] = pixels + (k * bytesPerRow);
	
	if (info.interlaced) {
		UInt32 number_passes = png_set_interlace_handling(self.png_ptr);
		
		/* The number of passes is either
		 * 1 for non-interlaced images,
		 * or 7 for interlaced images.
		 */
		for (UInt32 pass = 0; pass < number_passes; pass++) {
			/* Write one row at a time. */
			for (UInt32 y = 0; y < height; y++) {
				png_write_rows(self.png_ptr, &row_pointers[y], 1);
			}
		}
	}
	else  png_write_image(self.png_ptr, row_pointers);
	
	png_write_end(self.png_ptr, self.info_ptr);	
	
	CFRelease(datas);

	[info release];
}

@end