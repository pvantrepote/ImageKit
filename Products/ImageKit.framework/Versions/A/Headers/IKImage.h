//
//  IKImage.h
//  ImageKit
//
//  Created by Pascal Vantrepote on 11-10-28.
//  Copyright (c) 2011 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKImage : UIImage {
@private
	NSMutableDictionary* texts;
	float dpi;
}

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* author;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, assign) float dpi;

+(id) imageWithUIImage:(UIImage*) image; 
+(id) imageWithContentsOfFile:(NSString *)path; 
+(id) imageWithResource:(NSString *) rcsName;

-(id) initWithUIImage:(UIImage*) image;

-(NSString*) textForKey:(NSString*) key;
-(void) setText:(NSString*) text forKey:(NSString*) key;

@end
