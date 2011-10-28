//
//  ViewController.m
//  PNGSample
//
//  Created by Pascal Vantrepote on 11-10-27.
//  Copyright (c) 2011 Tamajii Inc. All rights reserved.
//

#import "ViewController.h"

#import <ImageKit/PNG/IKPngImage.h>
#import <ImageKit/UIImage+ImageKit.h>
#import <ImageKit/UIImage+ImageKit.m>
#import <cocoalumberjack/DDLog.h>

int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
	
	IKPNGImage* img = (IKPNGImage*)[IKImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"280px-PNG_transparency_demonstration_1" ofType:@"png"]];
	
	NSString* path = @"/Users/pvantrepote/Downloads/sample.png";
	
	img.title = @"My book";
	img.author = @"Pascal Vantrepote";
	img.dpi = 300;
	img.interlaced = NO;
		
	[img writeToFile:path];
	
	
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

@end
