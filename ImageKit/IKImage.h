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

-(NSString*) textForKey:(NSString*) key;
-(void) setText:(NSString*) text forKey:(NSString*) key;

+(IKImage*) imageWithContentsOfFile:(NSString *)path; 
+(IKImage*) imageFromResource:(NSString *) rcsName;

@end
