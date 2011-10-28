//
//  UIImage+ImageKit.m
//  ImageKit
//
//  Created by Pascal Vantrepote on 11-10-28.
//  Copyright (c) 2011 Tamajii Inc. All rights reserved.
//

#import "UIImage+ImageKit.h"

#import <cocoalumberjack/DDLog.h>

#import "IKWriter.h"
#import "PNGFileWriter.h"

extern int ddLogLevel;

@implementation UIImage (ImageKit)

-(BOOL) writeToFile:(NSString*) filepath {
	
	id<IKWriter> writer;
	
	/// 
	NSString* extenstion = [filepath pathExtension];
	if ([extenstion caseInsensitiveCompare:@"PNG"] == NSOrderedSame) {
		writer = [[PNGFileWriter alloc] initWithFilepath:filepath];
	}
	
	if (!writer) {
		DDLogError(@"File type '%@' not supported.", extenstion);
		return NO;
	}
	
	[writer writeImage:self];
	[writer release];
	
	return YES;
}
@end
