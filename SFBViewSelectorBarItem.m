/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import "SFBViewSelectorBarItem.h"

@implementation SFBViewSelectorBarItem

+ (id) itemWithIdentifier:(NSString *)identifier label:(NSString *)label tooltip:(NSString *)tooltip image:(NSImage *)image view:(NSView *)view
{
	return [[SFBViewSelectorBarItem alloc] initWithIdentifier:identifier label:label tooltip:tooltip image:image view:view];
}

- (id) initWithIdentifier:(NSString *)identifier label:(NSString *)label tooltip:(NSString *)tooltip image:(NSImage *)image view:(NSView *)view
{
	// The identifier and view are the only two required parameters
	NSParameterAssert(nil != identifier);
	NSParameterAssert(nil != view);
	
	if((self = [super init])) {
		self.identifier = identifier;
		self.label = label;
		self.tooltip = tooltip;
		self.image = image;
		self.view = view;
	}
	
	return self;
}

@end
