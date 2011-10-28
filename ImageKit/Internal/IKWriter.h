//
//  IKFileWriter.h
//  ImageKit
//
//  Created by Pascal Vantrepote on 11-10-28.
//  Copyright (c) 2011 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IKWriter <NSObject>

-(void) writeImage:(UIImage*) image;

@end
