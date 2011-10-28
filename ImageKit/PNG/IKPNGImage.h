//
//  IKPNGImage.h
//  ImageKit
//
//  Created by Pascal Vantrepote on 11-10-28.
//  Copyright (c) 2011 Tamajii Inc. All rights reserved.
//

#import <ImageKit/IKImage.h>

@interface IKPNGImage : IKImage {
	@private
	BOOL interlaced;
}

@property (nonatomic, assign) BOOL interlaced;

@end
