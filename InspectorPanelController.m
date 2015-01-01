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

#import "InspectorPanelController.h"
#import "SFBInspectorView.h"

@implementation InspectorPanelController

- (id) init
{
	return [super initWithWindowNibName:@"InspectorPanel"];
}

- (void) windowDidLoad
{
	[[self window] setMovableByWindowBackground:YES];

	[self.inspectorView addInspectorPane:self.trackView title:NSLocalizedString(@"Track Information", @"The name of the track inspector panel")];
	[self.inspectorView addInspectorPane:self.discView title:NSLocalizedString(@"Disc Information", @"The name of the disc inspector panel")];
	[self.inspectorView addInspectorPane:self.driveView title:NSLocalizedString(@"Drive Information", @"The name of the drive inspector panel")];
	
	[super windowDidLoad];
}

- (NSString *) windowFrameAutosaveName
{
	return @"Inspector Panel";
}

- (IBAction) toggleInspectorPanel:(id)sender
{
    NSWindow *window = self.window;
	
	if(window.isVisible)
		[window orderOut:sender];
	else
		[window orderFront:sender];
}

- (BOOL) validateMenuItem:(NSMenuItem *)menuItem
{
	if([menuItem action] == @selector(toggleInspectorPanel:)) {
		NSString *menuTitle = nil;		
		if(!self.isWindowLoaded || !self.window.isVisible)
			menuTitle = NSLocalizedString(@"Show Inspector", @"Menu Item");
		else
			menuTitle = NSLocalizedString(@"Hide Inspector", @"Menu Item");
		
		[menuItem setTitle:menuTitle];
		
		return YES;
	}
	else	
		return NO;
}

@end
