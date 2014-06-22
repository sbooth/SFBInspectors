/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import "DemoAppDelegate.h"
#import "InspectorPanelController.h"
#import "MetadataEditorPanelController.h"

@implementation DemoAppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification
{
#pragma unused(aNotification)
	[self.inspectorPanel showWindow:self];
	[self.metadataPanel showWindow:self];
}

@end
