//
//  PNGFileWriter.h
//  ImageKit
//
//  Created by Pascal Vantrepote on 11-10-28.
//  Copyright (c) 2011 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PNGFile.h"
#import "IKWriter.h"

@class PNGWritePtr;

@interface PNGFileWriter : PNGFile<IKWriter> {
@private
    PNGWritePtr* ptr;
}

@property (nonatomic, readonly) PNGWritePtr* ptr;

-(void) writeImage:(UIImage*) image;

@end