/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

@class SFBViewSelector;

@interface MetadataEditorPanelController : NSWindowController
{}

@property (nonatomic, weak) IBOutlet SFBViewSelector * viewSelector;

@property (nonatomic, weak) IBOutlet NSView * albumMetadata;
@property (nonatomic, weak) IBOutlet NSView * trackMetadata;
@property (nonatomic, weak) IBOutlet NSView * albumArt;
@property (nonatomic, weak) IBOutlet NSView * lyrics;
@property (nonatomic, weak) IBOutlet NSView * additionalAlbumMetadata;
@property (nonatomic, weak) IBOutlet NSView * additionalTrackMetadata;

// ========================================
// Action Methods
- (IBAction) toggleMetadataEditorPanel:(id)sender;

@end
