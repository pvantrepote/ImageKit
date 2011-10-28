//
//  PNGFileWriter.m
//  ImageKit
//
//  Created by Pascal Vantrepote on 11-10-28.
//  Copyright (c) 2011 Tamajii Inc. All rights reserved.
//

#import "PNGFileWriter.h"

#import "PNGPtr.h"
#import "PNGInfo.h"

@implementation PNGFileWriter

#pragma mark - Properties

@synthesize ptr;

-(png_structp) png_ptr {
	return ptr.png_ptr;
}

#pragma mark - Init/Dealloc

-(void) dealloc {
	[ptr release];
	
	[super dealloc];
}

#pragma mark - Public methods

-(void) writeImage:(UIImage*) image {
	/// Write it
	[self.ptr writeImage:image];
}

-(FILE*) open {
	FILE* file = fopen([self.filepath UTF8String], "wb");
	if (!file) return nil;
	
	ptr = [[PNGWritePtr alloc] init];
	
	return file;
}

@end
