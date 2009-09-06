/*
 *  Copyright (C) 2009 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

@class SFBViewSelector;

@interface MetadataEditorPanelController : NSWindowController
{
	IBOutlet SFBViewSelector * _viewSelector;
	IBOutlet NSView * _albumMetadata;
	IBOutlet NSView * _trackMetadata;
	IBOutlet NSView * _albumArt;
	IBOutlet NSView * _lyrics;
	IBOutlet NSView * _additionalAlbumMetadata;
	IBOutlet NSView * _additionalTrackMetadata;
}

// ========================================
// Action Methods
- (IBAction) toggleMetadataEditorPanel:(id)sender;

@end
