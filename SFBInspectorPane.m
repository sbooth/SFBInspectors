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

#import "SFBInspectorPane.h"
#import "SFBInspectorPaneHeader.h"
#import "SFBInspectorPaneBody.h"
#import "SFBInspectorView.h"

#import <QuartzCore/QuartzCore.h>

#define ANIMATION_DURATION 0.15
#define SLOW_ANIMATION_DURATION (8 * ANIMATION_DURATION)

@interface SFBInspectorPane ()
{
@private
	SFBInspectorPaneHeader *_headerView;
	SFBInspectorPaneBody *_bodyView;
}
@property (nonatomic, assign, getter=isCollapsed) BOOL collapsed;
@end

@interface SFBInspectorPane (Private)
- (void) createHeaderAndBody;
@end

@implementation SFBInspectorPane

- (id) initWithFrame:(NSRect)frame
{
	if((self = [super initWithFrame:frame]))
		[self createHeaderAndBody];
	return self;
}

- (void) awakeFromNib
{
	[self createHeaderAndBody];
}

- (NSString *) title
{
	return [_headerView title];
}

- (void) setTitle:(NSString *)title
{
	[_headerView setTitle:title];
}

- (IBAction) toggleCollapsed:(id)sender
{

#pragma unused(sender)

	[self setCollapsed:!self.isCollapsed animate:YES];
}

- (void) setCollapsed:(BOOL)collapsed animate:(BOOL)animate
{
	if(self.isCollapsed == collapsed)
		return;
	
	self.collapsed = collapsed;
	[[_headerView disclosureButton] setState:(self.isCollapsed ? NSOffState : NSOnState)];
	
	CGFloat headerHeight = [[self headerView] frame].size.height;
	
	NSRect currentFrame = [self frame];
	NSRect newFrame = currentFrame;
	
	newFrame.size.height = headerHeight + (self.isCollapsed ? -1 : [self bodyView].normalHeight);
	newFrame.origin.y += currentFrame.size.height - newFrame.size.height;
	
	if(animate) {
		BOOL shiftPressed = (NSShiftKeyMask & [[[NSApplication sharedApplication] currentEvent] modifierFlags]) != 0;
		
		// Modify the default animation for frame changes
		CABasicAnimation *frameSizeAnimation = [[self animator] animationForKey:@"frameSize"];
		
		// Don't modify the returned animation (in case it is shared)
		if(frameSizeAnimation) {
			frameSizeAnimation = [frameSizeAnimation copy];
			
			frameSizeAnimation.duration = shiftPressed ? SLOW_ANIMATION_DURATION : ANIMATION_DURATION;
			frameSizeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
			
			[[self animator] setAnimations:[NSDictionary dictionaryWithObject:frameSizeAnimation forKey:@"frameSize"]];
		}
		
		[[self animator] setFrame:newFrame];
	}
	else
		[self setFrame:newFrame];
}

- (SFBInspectorPaneHeader *) headerView
{
	return _headerView;
}

- (SFBInspectorPaneBody *) bodyView
{
	return _bodyView;
}

@end

@implementation SFBInspectorPane (Private)

- (void) createHeaderAndBody
{
	// Divide our bounds into the header and body areas
	NSRect headerFrame, bodyFrame;	
	NSDivideRect([self bounds], &headerFrame, &bodyFrame, INSPECTOR_PANE_HEADER_HEIGHT, NSMaxYEdge);
	
	_headerView = [[SFBInspectorPaneHeader alloc] initWithFrame:headerFrame];
	
	[_headerView setAutoresizingMask:(NSViewWidthSizable | NSViewMinYMargin)];
	[[_headerView disclosureButton] setState:NSOnState];

	_bodyView = [[SFBInspectorPaneBody alloc] initWithFrame:bodyFrame];

	[_bodyView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
		
	[self addSubview:_headerView];
	[self addSubview:_bodyView];

	[self setAutoresizesSubviews:YES];
}

@end
