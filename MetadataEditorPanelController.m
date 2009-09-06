/*
 *  Copyright (C) 2009 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import "MetadataEditorPanelController.h"
#import "SFBViewSelector.h"
#import "SFBViewSelectorBar.h"
#import "SFBViewSelectorBarItem.h"

@interface MetadataEditorPanelController (Private)
- (void) applicationWillTerminate:(NSNotification *)notification;
@end

@implementation MetadataEditorPanelController

- (id) init
{
	return [super initWithWindowNibName:@"MetadataEditorPanel"];
}

- (void) awakeFromNib
{
	if(!_albumMetadata)
		return;

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:NSApplicationWillTerminateNotification object:nil];
	
	SFBViewSelectorBarItem *item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.AlbumMetadata" 
																  label:NSLocalizedString(@"Album Metadata", @"")
																tooltip:NSLocalizedString(@"Album Metadata", @"")
																  image:[NSImage imageNamed:@"AlbumMetadataEditorPaneIcon"]
																   view:_albumMetadata];
	
	[[_viewSelector selectorBar] addItem:item];

	item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.TrackMetadata" 
											 label:NSLocalizedString(@"Track Metadata", @"")
										   tooltip:NSLocalizedString(@"Track Metadata", @"")
											 image:[NSImage imageNamed:@"TrackMetadataEditorPaneIcon"]
											  view:_trackMetadata];
	
	[[_viewSelector selectorBar] addItem:item];
	
	item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.AlbumArt" 
											 label:NSLocalizedString(@"Album Art", @"")
										   tooltip:NSLocalizedString(@"Album Art", @"")
											 image:[NSImage imageNamed:@"AlbumArtEditorPaneIcon"]
											  view:_albumArt];
	
	[[_viewSelector selectorBar] addItem:item];

	item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.Lyrics" 
											 label:NSLocalizedString(@"Lyrics", @"")
										   tooltip:NSLocalizedString(@"Lyrics", @"")
											 image:[NSImage imageNamed:@"LyricsMetadataEditorPaneIcon"]
											  view:_lyrics];
	
	[[_viewSelector selectorBar] addItem:item];

	item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.AdditionalAlbumMetadata" 
											 label:NSLocalizedString(@"Additional Album Metadata", @"")
										   tooltip:NSLocalizedString(@"Additional Album Metadata", @"")
											 image:[NSImage imageNamed:@"AdditionalAlbumMetadataEditorPaneIcon"]
											  view:_additionalAlbumMetadata];
	
	[[_viewSelector selectorBar] addItem:item];

	item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.AdditionalTrackMetadata" 
											 label:NSLocalizedString(@"Additional Track Metadata", @"")
										   tooltip:NSLocalizedString(@"Additional Track Metadata", @"")
											 image:[NSImage imageNamed:@"AdditionalTrackMetadataEditorPaneIcon"]
											  view:_additionalTrackMetadata];
	
	[[_viewSelector selectorBar] addItem:item];

	// Restore the selected pane
	NSString *autosaveName = [[self window] frameAutosaveName];
	if(autosaveName) {
		NSString *selectedPaneDefaultsName = [autosaveName stringByAppendingFormat:@" Selected Pane"];		
		NSString *selectedIdentifier = [[NSUserDefaults standardUserDefaults] stringForKey:selectedPaneDefaultsName];
		
		if(selectedIdentifier)
			[[_viewSelector selectorBar] selectItemWithIdentifer:selectedIdentifier];
	}	
}

- (void) windowDidLoad
{
	[[self window] setMovableByWindowBackground:YES];

	[super windowDidLoad];
}

- (NSString *) windowFrameAutosaveName
{
	return @"Metadata Editor Panel";
}

- (IBAction) toggleMetadataEditorPanel:(id)sender
{
    NSWindow *window = self.window;
	
	if(window.isVisible && window.isKeyWindow)
		[window orderOut:sender];
	else
		[window makeKeyAndOrderFront:sender];
}

- (BOOL) validateMenuItem:(NSMenuItem *)menuItem
{
	if([menuItem action] == @selector(toggleMetadataEditorPanel:)) {
		NSString *menuTitle = nil;
		
		if(!self.isWindowLoaded || !self.window.isVisible/* || !self. window.isKeyWindow*/)
			menuTitle = NSLocalizedString(@"Show Metadata Editor", @"Menu Item");
		else
			menuTitle = NSLocalizedString(@"Hide Metadata Editor", @"Menu Item");
		
		[menuItem setTitle:menuTitle];
	}
	
	return YES;
}

@end

@implementation MetadataEditorPanelController (Private)

- (void) applicationWillTerminate:(NSNotification *)notification
{
	
#pragma unused(notification)
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	// Save the selected pane
	NSString *autosaveName = [[self window] frameAutosaveName];
	if(autosaveName) {
		NSString *selectedIdentifier = [[[_viewSelector selectorBar] selectedItem] identifier];
		NSString *selectedPaneDefaultsName = [autosaveName stringByAppendingFormat:@" Selected Pane"];
		
		[[NSUserDefaults standardUserDefaults] setValue:selectedIdentifier forKey:selectedPaneDefaultsName];
		
		[[NSUserDefaults standardUserDefaults] synchronize];
	}	
}

@end
