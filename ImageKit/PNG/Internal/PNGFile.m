//
//  PNGFile.m
//  Gfx
//
//  Created by Pascal Vantrepote on 10-09-15.
//  Copyright 2010 Tamajii Inc.. All rights reserved.
//

#import "PNGFile.h"

#import <libpng/png.h>
#import "Types.h"
#import "PNGPtr.h"
#import "PNGPtr.h"
#import "PNGFile.h"
#import "PNGInfo.h"

@interface PNGFile ()
@property (nonatomic, readonly) png_structp png_ptr;
@end

@implementation PNGFile

#pragma mark -
#pragma mark Properties

@synthesize filepath;

-(png_structp) png_ptr {
	return nil;
}

#pragma mark -
#pragma mark Init/Dealloc

-(id) initWithFilepath:(NSString *)filepath_ {
	if ((self = [super init]) != nil) {
		filepath = [filepath_ retain];
		
		fp = [self open];
		if (!fp) {
			[self release];
			return nil;			
		}
		
		png_init_io(self.png_ptr, fp);
	}
	
	return self;
}

-(void) dealloc {
	[filepath release];
	if (fp) {
		fflush(fp);
		fclose(fp);
		fp = nil;
	}
	
	[super dealloc];
}

@end

@implementation PNGFile (Protected)

-(FILE*) open {
	return nil;
}

@end