//
//  UIImage+ImageKit.h
//  ImageKit
//
//  Created by Pascal Vantrepote on 11-10-28.
//  Copyright (c) 2011 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageKit)

/**
 *	@brief	Save the image to a file
 *
 *	@param	filepath	Path of the destination file
 *
 *	@return	TRUE if succeeded otherwise  NO
 */
-(BOOL) writeToFile:(NSString*) filepath;

@end
