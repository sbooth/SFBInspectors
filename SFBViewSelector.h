/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

#define VIEW_SELECTOR_BAR_HEIGHT 25

@class SFBViewSelectorBar;

@interface SFBViewSelector : NSView
{}

- (SFBViewSelectorBar *) selectorBar;

@end
