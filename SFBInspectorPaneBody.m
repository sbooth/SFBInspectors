/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import "SFBInspectorPaneBody.h"

@interface SFBInspectorPaneBody ()
@property (nonatomic, assign) CGFloat normalHeight;
@end

@implementation SFBInspectorPaneBody

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
