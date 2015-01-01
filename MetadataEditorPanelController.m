/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014, 2015 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */

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

- (void) windowDidLoad
{
	[[self window] setMovableByWindowBackground:YES];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:NSApplicationWillTerminateNotification object:nil];
	
	SFBViewSelectorBarItem *item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.AlbumMetadata" 
																		label:NSLocalizedString(@"Album Metadata", @"")
																	  tooltip:NSLocalizedString(@"Album Metadata", @"")
																		image:[NSImage imageNamed:@"AlbumMetadataEditorPaneIcon"]
																		 view:_albumMetadata];
	
	[[self.viewSelector selectorBar] addItem:item];
	
	item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.TrackMetadata" 
												label:NSLocalizedString(@"Track Metadata", @"")
											  tooltip:NSLocalizedString(@"Track Metadata", @"")
												image:[NSImage imageNamed:@"TrackMetadataEditorPaneIcon"]
												 view:_trackMetadata];
	
	[[self.viewSelector selectorBar] addItem:item];
	
	item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.AlbumArt" 
												label:NSLocalizedString(@"Album Art", @"")
											  tooltip:NSLocalizedString(@"Album Art", @"")
												image:[NSImage imageNamed:@"AlbumArtEditorPaneIcon"]
												 view:_albumArt];
	
	[[self.viewSelector selectorBar] addItem:item];
	
	item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.Lyrics" 
												label:NSLocalizedString(@"Lyrics", @"")
											  tooltip:NSLocalizedString(@"Lyrics", @"")
												image:[NSImage imageNamed:@"LyricsMetadataEditorPaneIcon"]
												 view:_lyrics];
	
	[[self.viewSelector selectorBar] addItem:item];
	
	item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.AdditionalAlbumMetadata" 
												label:NSLocalizedString(@"Additional Album Metadata", @"")
											  tooltip:NSLocalizedString(@"Additional Album Metadata", @"")
												image:[NSImage imageNamed:@"AdditionalAlbumMetadataEditorPaneIcon"]
												 view:_additionalAlbumMetadata];
	
	[[self.viewSelector selectorBar] addItem:item];
	
	item = [SFBViewSelectorBarItem itemWithIdentifier:@"org.sbooth.Inspectors.MetadataEditor.AdditionalTrackMetadata" 
												label:NSLocalizedString(@"Additional Track Metadata", @"")
											  tooltip:NSLocalizedString(@"Additional Track Metadata", @"")
												image:[NSImage imageNamed:@"AdditionalTrackMetadataEditorPaneIcon"]
												 view:_additionalTrackMetadata];
	
	[[self.viewSelector selectorBar] addItem:item];
	
	// Restore the selected pane
	NSString *autosaveName = [[self window] frameAutosaveName];
	if(autosaveName) {
		NSString *selectedPaneDefaultsName = [autosaveName stringByAppendingFormat:@" Selected Pane"];		
		NSString *selectedIdentifier = [[NSUserDefaults standardUserDefaults] stringForKey:selectedPaneDefaultsName];
		
		if(selectedIdentifier)
			[[self.viewSelector selectorBar] selectItemWithIdentifer:selectedIdentifier];
	}
	
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
		NSString *selectedIdentifier = [[[self.viewSelector selectorBar] selectedItem] identifier];
		NSString *selectedPaneDefaultsName = [autosaveName stringByAppendingFormat:@" Selected Pane"];
		
		[[NSUserDefaults standardUserDefaults] setValue:selectedIdentifier forKey:selectedPaneDefaultsName];
		
		[[NSUserDefaults standardUserDefaults] synchronize];
	}	
}

@end
