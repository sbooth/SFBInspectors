/*
 *  Copyright (C) 2009 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

@class SFBInspectorView;

@interface InspectorPanelController : NSWindowController
{
	IBOutlet SFBInspectorView * _inspectorView;
	IBOutlet NSView *_trackView;
	IBOutlet NSView *_discView;
	IBOutlet NSView *_driveView;
}

// ========================================
// Action Methods
- (IBAction) toggleInspectorPanel:(id)sender;

@end
