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

#import "SFBInspectorView.h"
#import "SFBInspectorPane.h"
#import "SFBInspectorPaneBody.h"

@interface SFBInspectorView ()
{
@private
	NSSize _initialWindowSize;
	NSMutableArray *_paneControllers;
}
@end

@interface SFBInspectorView (Private)
- (void) inspectorPaneFrameDidChange:(NSNotification *)notification;
- (void) applicationWillTerminate:(NSNotification *)notification;
- (void) layoutSubviews;
@end

@implementation SFBInspectorView

- (void) awakeFromNib
{
	_initialWindowSize = [[self window] frame].size;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:NSApplicationWillTerminateNotification object:nil];

	// Iterate through each pane and restore its state
	NSString *autosaveName = [[self window] frameAutosaveName];
	if(autosaveName) {
		for(NSView *inspectorPane in [self subviews]) {
			if(![inspectorPane isKindOfClass:[SFBInspectorPane class]])
				continue;
			
			SFBInspectorPane *pane = (SFBInspectorPane *)inspectorPane;
			NSString *paneAutosaveName = [autosaveName stringByAppendingFormat:@" %@ Pane", [pane title]];
			
			[[NSUserDefaults standardUserDefaults] setBool:pane.isCollapsed forKey:paneAutosaveName];
		}
	}
}

- (void) didAddSubview:(NSView *)subview
{
	NSParameterAssert(nil != subview);
	
	if([subview isKindOfClass:[SFBInspectorPane class]]) {
		// Restore the pane's size
		NSString *autosaveName = [[self window] frameAutosaveName];
		if(autosaveName) {
			SFBInspectorPane *pane = (SFBInspectorPane *)subview;
			NSString *paneAutosaveName = [autosaveName stringByAppendingFormat:@" %@ Pane", [pane title]];
			[pane setCollapsed:[[NSUserDefaults standardUserDefaults] boolForKey:paneAutosaveName] animate:NO];
		}

		[subview setPostsFrameChangedNotifications:YES];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inspectorPaneFrameDidChange:) name:NSViewFrameDidChangeNotification object:subview];
	}
}

- (void) willRemoveSubview:(NSView *)subview
{
	NSParameterAssert(nil != subview);

	if([subview isKindOfClass:[SFBInspectorPane class]]) {
		[subview setPostsFrameChangedNotifications:NO];
		[[NSNotificationCenter defaultCenter] removeObserver:self name:NSViewFrameDidChangeNotification object:subview];

		// Remove the view's controller from our list of view controllers
		// It would be too convenient if NSView had a - (NSViewController *) viewController method!
		NSViewController *paneController = nil;
		for(NSViewController *viewController in _paneControllers) {
			if([[viewController view] isDescendantOf:subview]) {
				paneController = viewController;
				break;
			}
		}

		if(paneController)
			[_paneControllers removeObject:paneController];
	}
}

#pragma mark Pane management

- (void) addInspectorPaneController:(NSViewController *)paneController
{
	NSParameterAssert(nil != paneController);
	
	if(nil == _paneControllers)
		_paneControllers = [[NSMutableArray alloc] init];

	[_paneControllers addObject:paneController];

	NSRect paneFrame;

	NSView *paneBody = [paneController view];
	NSString *title = [paneController title];

	// Constrain the pane to our width and add extra height for the header
	paneFrame.size.width = [self frame].size.width;
	paneFrame.size.height = [paneBody frame].size.height + INSPECTOR_PANE_HEADER_HEIGHT;

	// This origin is never used; layoutSubviews will calculate the correct origin
	paneFrame.origin = NSZeroPoint;

	SFBInspectorPane *pane = [[SFBInspectorPane alloc] initWithFrame:paneFrame];

	[pane setTitle:title];
	[[pane bodyView] addSubview:paneBody];

	[self addSubview:pane];	

	// Lay out the panes correctly
	[self layoutSubviews];
	
}

- (void) addInspectorPane:(NSView *)paneBody title:(NSString *)title
{
	NSParameterAssert(nil != paneBody);
	NSParameterAssert(nil != title);

	NSViewController *vc = [[NSViewController alloc] init];
	[vc setView:paneBody];
	[vc setTitle:title];
	
	[self addInspectorPaneController:vc];
}

@end

@implementation SFBInspectorView (Private)

- (void) inspectorPaneFrameDidChange:(NSNotification *)notification
{
	NSParameterAssert(nil != notification);
	NSParameterAssert(nil != [notification object]);
	NSParameterAssert([[notification object] isKindOfClass:[SFBInspectorPane class]]);
	
	SFBInspectorPane *pane = [notification object];
	
	[pane setPostsFrameChangedNotifications:NO];
	
	[self layoutSubviews];

	[pane setPostsFrameChangedNotifications:YES];
}

- (void) applicationWillTerminate:(NSNotification *)notification
{
	
#pragma unused(notification)
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	// Iterate through each pane and save its state
	NSString *autosaveName = [[self window] frameAutosaveName];
	if(autosaveName) {
		for(NSView *inspectorPane in [self subviews]) {
			if(![inspectorPane isKindOfClass:[SFBInspectorPane class]])
				continue;
			
			SFBInspectorPane *pane = (SFBInspectorPane *)inspectorPane;
			NSString *paneAutosaveName = [autosaveName stringByAppendingFormat:@" %@ Pane", [pane title]];
			
			[[NSUserDefaults standardUserDefaults] setBool:pane.isCollapsed forKey:paneAutosaveName];
		}
		
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	// Reset the window's frame to its initial size
	NSRect currentWindowFrame = [[self window] frame];
	NSRect newWindowFrame = currentWindowFrame;

	CGFloat deltaY = _initialWindowSize.height - currentWindowFrame.size.height;
	
	newWindowFrame.origin.y -= deltaY;
	newWindowFrame.size.height += deltaY;

	[[self window] setFrame:newWindowFrame display:NO animate:NO];
}

- (void) layoutSubviews
{
	// Adjust the y origins of all the panes
	CGFloat paneHeight = 0.f;
	NSArray *reversedSubviews = [[[self subviews] reverseObjectEnumerator] allObjects];
	for(NSView *inspectorPane in reversedSubviews) {
		NSRect inspectorPaneFrame = [inspectorPane frame];
		NSPoint newPaneOrigin;
		
		newPaneOrigin.x = inspectorPaneFrame.origin.x;
		newPaneOrigin.y = paneHeight;
		
		[inspectorPane setFrameOrigin:newPaneOrigin];
		
		paneHeight += inspectorPaneFrame.size.height;
	}

	// Calculate the new window size
	NSRect currentViewFrame = [self frame]; 

	CGFloat deltaY = paneHeight - currentViewFrame.size.height;
	
	NSRect currentWindowFrame = [[self window] frame];
	NSRect newWindowFrame = currentWindowFrame;

	newWindowFrame.origin.y -= deltaY;
	newWindowFrame.size.height += deltaY;

	[[self window] setFrame:newWindowFrame display:YES animate:NO];
}

@end
