/*
 *  Copyright (C) 2009 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

#define INSPECTOR_PANE_HEADER_HEIGHT 17

@class SFBInspectorPaneHeader, SFBInspectorPaneBody;

@interface SFBInspectorPane : NSView
{}

@property (readonly, assign, getter=isCollapsed) BOOL collapsed;

- (NSString *) title;
- (void) setTitle:(NSString *)title;

- (IBAction) toggleCollapsed:(id)sender;
- (void) setCollapsed:(BOOL)collapsed animate:(BOOL)animate;

- (SFBInspectorPaneHeader *) headerView;
- (SFBInspectorPaneBody *) bodyView;

@end
