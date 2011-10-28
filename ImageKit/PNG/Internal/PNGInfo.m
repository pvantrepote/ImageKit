//
//  PNGInfo.m
//  ImageKit
//
//  Created by Pascal Vantrepote on 11-10-27.
//  Copyright (c) 2011 Tamajii Inc. All rights reserved.
//

#import "PNGInfo.h"

#import <libpng/png.h>
#import "PNGPtr.h"
#import "IKImage+Internal.h"
#import "IKPNGImage.h"

@implementation PNGInfo

#pragma mark - Properties

@synthesize width, height, bit_depth, color_type, interlaced, dpi, texts;

#pragma mark - Init/Dealloc

-(id) init {
	if ((self = [super init]) != nil) {
		
	}
	
	return self;
}

-(id) initWithPth:(PNGPtr*) ptr {
	if ((self = [super init]) != nil) {
		if (![self readFromPtr:ptr]) {
			[self release];
			return nil;
		}
	}
	
	return self;
}

-(id) initWithUIImage:(UIImage*) image {
	if ((self = [self initWithCGImage:image.CGImage]) != nil) {
		if ([image isKindOfClass:[IKImage class]]) {
			IKImage* ikImage = (IKImage*) image;
			
			self.texts = ikImage.texts;
			self.dpi = ikImage.dpi;
		}
		
		if ([image isKindOfClass:[IKPNGImage class]]) {
			self.interlaced = ((IKPNGImage*)image).interlaced;		
		}
	}
	
	return self;
}

-(id) initWithCGImage:(CGImageRef) image {
	if ((self = [super init]) != nil) {
		self.height = CGImageGetHeight(image);
		self.width = CGImageGetWidth(image);
		
		size_t bitBerComponent = CGImageGetBitsPerComponent(image);
		size_t bitPerPixel = CGImageGetBitsPerPixel(image);
		int numberOfComponent = (int)bitPerPixel / bitBerComponent;
		
		self.bit_depth = bitBerComponent;
		switch (numberOfComponent) {
			case 1:
				self.color_type = PNG_COLOR_TYPE_GRAY;
				break;
			case 2:
				self.color_type = PNG_COLOR_TYPE_GRAY_ALPHA;
				break;
			case 3:
				self.color_type = PNG_COLOR_TYPE_RGB;
				break;
			case 4:
				self.color_type = PNG_COLOR_TYPE_RGB_ALPHA;
				break;
		}
		
		CGImageAlphaInfo aInfo = CGImageGetAlphaInfo(image);
		swapAlpha = ((aInfo == kCGImageAlphaFirst) || (aInfo == kCGImageAlphaPremultipliedFirst));
		
		self.interlaced = NO;		
	}
	
	return self;
}

#pragma mark - Public methods

-(BOOL) readFromPtr:(PNGPtr*) ptr {
	if (ptr.type != PNGPtrTypeRead) return NO;
	
	png_uint_32 w, h;
	int bDepth, cType, iMethod, cMethod, fMethod;
	
	png_uint_32 result = png_get_IHDR(ptr.png_ptr, ptr.info_ptr, &w, &h, &bDepth, &cType, &iMethod, &cMethod, &fMethod);
	if (!result) return NO;
	
	self.width = w;
	self.height = h;
	self.bit_depth = bDepth;
	self.color_type = cType;
	self.interlaced = (iMethod == PNG_INTERLACE_ADAM7);
	
	png_uint_32 ppm_x, ppm_y;
	int unit;
	png_get_pHYs(ptr.png_ptr, ptr.info_ptr, &ppm_x, &ppm_y, &unit);
	if (unit == PNG_RESOLUTION_METER) {
		self.dpi = (ppm_x * 254.0) / 10000.0;
	}
	
	return YES;
}

-(BOOL) writeToPtr:(PNGWritePtr*) ptr {	
		
	/// Infos
	png_set_IHDR(ptr.png_ptr, ptr.info_ptr, 
				 (png_uint_32)self.width, (png_uint_32)self.height, 
				 self.bit_depth, self.color_type, 
				 (self.interlaced) ? PNG_INTERLACE_ADAM7 : PNG_INTERLACE_NONE, 
				 PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);
	
	/// DPI
	if (self.dpi) {
		/* one metre = 100 centimetre (cm), and 2.54 cm = 1 inch */
		/* 1 metre is about 40 inches (well, 100/2.54 or 39.37) */
		/* so the number of dots per metre is about 40 times */
		/* larger than the number of dots per inch */
		/* thus DPM = DPI * 100 / 2.54 = DPI * 10000 / 254 */ 
		int ppm_x, ppm_y; /* pixels per metre */
		ppm_x = (int)ceilf((self.dpi * 10000.0) / 254.0); /* round to nearest */
		ppm_y = ppm_x;
		png_set_pHYs(ptr.png_ptr, ptr.info_ptr, ppm_x, ppm_y, PNG_RESOLUTION_METER);
	}
	
	/// Swap alpha if AGRAY or ARGB
	if (swapAlpha) {
		png_set_swap_alpha(ptr.png_ptr);
	}
	
	/// Save texts
	if (texts) {
		png_textp pngText = (png_textp) malloc([texts count] * sizeof(png_text));
		
		NSInteger count = 0;
		for (NSString* key in [texts allKeys]) {
			NSString* text = [texts objectForKey:key];
			
			pngText[count].key = (png_charp)[key UTF8String];
			pngText[count].text = (png_charp)[text UTF8String];
			pngText[count].text_length = [text length];
			pngText[count].compression =PNG_TEXT_COMPRESSION_NONE;
			pngText[count].itxt_length = 0;
			pngText[count].lang = NULL;
			pngText[count].lang_key = NULL;
			
			count++;
		}
		
		png_set_text(ptr.png_ptr, ptr.info_ptr, pngText, [texts count]);
		free(pngText);		
	}
	
	png_write_info(ptr.png_ptr, ptr.info_ptr);
	
	return YES;
}

@end
