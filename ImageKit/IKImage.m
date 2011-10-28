//
//  IKImage.m
//  ImageKit
//
//  Created by Pascal Vantrepote on 11-10-28.
//  Copyright (c) 2011 Tamajii Inc. All rights reserved.
//

#import "IKImage.h"

#import "IKImage+Internal.h"
#import "IKPNGImage.h"

@implementation IKImage

#pragma mark - Properties

@synthesize dpi, texts;

-(void)setTitle:(NSString *)title {
	[self setText:title forKey:@"Title"];
}

-(NSString*) title {
	return [self textForKey:@"Title"];
}

-(void) setDescription:(NSString *)description {
	[self setText:description forKey:@"Description"];
}

-(NSString*) description {
	return [self textForKey:@"Description"];
}

-(void) setAuthor:(NSString *)author {
	[self setText:author forKey:@"Author"];
}

-(NSString*) author {
	return [self textForKey:@"Author"];
}

#pragma mark - Init/Dealloc

-(void) dealloc {
	[texts release];
	
	[super dealloc];
}

#pragma mark - Public methods

-(NSString*) textForKey:(NSString*) key {
	if (!texts) {
		return nil;
	}
	
	return [texts objectForKey:key];
}

-(void) setText:(NSString*) text forKey:(NSString*) key {
	if (!texts) {
		texts = [[NSMutableDictionary alloc] init];
	}
	
	[texts setValue:text forKey:key];
}

#pragma mark - Overrides

+(IKImage*) imageWithContentsOfFile:(NSString *)path {
	if (![[NSFileManager defaultManager] fileExistsAtPath:path]) return nil;

	NSString* extenstion = [path pathExtension];
	if ([extenstion caseInsensitiveCompare:@"PNG"] == NSOrderedSame) {
		return [[[IKPNGImage alloc] initWithContentsOfFile:path] autorelease];
	}
	
	return [[[IKImage alloc] initWithContentsOfFile:path] autorelease];
}

+(IKImage*) imageFromResource:(NSString *) rcsName {
	NSString* path = [[NSBundle mainBundle] pathForResource:rcsName ofType:nil];
	return [self imageWithContentsOfFile:path];
}

@end
