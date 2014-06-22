/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

@class SFBInspectorView;

@interface InspectorPanelController : NSWindowController
{}

@property (nonatomic, weak) IBOutlet SFBInspectorView * inspectorView;

@property (nonatomic, weak) IBOutlet NSView * trackView;
@property (nonatomic, weak) IBOutlet NSView * discView;
@property (nonatomic, weak) IBOutlet NSView * driveView;

// ========================================
// Action Methods
- (IBAction) toggleInspectorPanel:(id)sender;

@end
