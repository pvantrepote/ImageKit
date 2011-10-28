//
//  PNGFile.h
//  Gfx
//
//  Created by Pascal Vantrepote on 10-09-15.
//  Copyright 2010 Tamajii Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

@interface PNGFile : NSObject {
	@private
	NSString* filepath;
	FILE* fp;
}

@property (nonatomic, readonly) NSString* filepath;

-(id) initWithFilepath:(NSString*) filepath;
-(void) dealloc;

@end

@interface PNGFile (Protected)

-(FILE*) open;

@end