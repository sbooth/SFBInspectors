/*
 *  Copyright (C) 2009 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

@class InspectorPanelController, MetadataEditorPanelController;

@interface DemoAppDelegate : NSObject
{
	IBOutlet InspectorPanelController *_inspectorPanel;
	IBOutlet MetadataEditorPanelController *_metadataPanel;
}

@end
