/*
 *  Copyright (C) 2009 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import "SFBInspectorPaneBody.h"

@interface SFBInspectorPaneBody ()
@property (assign) CGFloat normalHeight;
@end

@implementation SFBInspectorPaneBody

@synthesize normalHeight = _normalHeight;

- (id) initWithFrame:(NSRect)frameRect
{
	if((self = [super initWithFrame:frameRect]))
		self.normalHeight = frameRect.size.height;
	return self;
}

- (BOOL) acceptsFirstMouse:(NSEvent *)theEvent
{

#pragma unused(theEvent)	

	return YES;
}

@end
