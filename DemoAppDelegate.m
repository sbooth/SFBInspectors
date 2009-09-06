/*
 *  Copyright (C) 2009 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import "DemoAppDelegate.h"
#import "InspectorPanelController.h"
#import "MetadataEditorPanelController.h"

@implementation DemoAppDelegate

- (id) init
{
	if(!(self = [super init]))
		return nil;

	return self;
}

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[_inspectorPanel showWindow:self];
	[_metadataPanel showWindow:self];
}

@end
