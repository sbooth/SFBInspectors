/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

@class InspectorPanelController, MetadataEditorPanelController;

@interface DemoAppDelegate : NSObject
{}

@property (nonatomic, weak) IBOutlet InspectorPanelController * inspectorPanel;
@property (nonatomic, weak) IBOutlet MetadataEditorPanelController * metadataPanel;

@end
