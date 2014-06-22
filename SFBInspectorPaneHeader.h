/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

@class SFBInspectorPane;

@interface SFBInspectorPaneHeader : NSView
{}

- (NSString *) title;
- (void) setTitle:(NSString *)title;

- (NSButton *) disclosureButton;
- (NSTextField *) titleTextField;

@end
