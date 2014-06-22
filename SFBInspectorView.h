/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

@interface SFBInspectorView : NSView
{}

- (void) addInspectorPaneController:(NSViewController *)paneController;
- (void) addInspectorPane:(NSView *)paneBody title:(NSString *)title;

@end
