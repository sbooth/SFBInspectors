/*
 *  Copyright (C) 2009 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

@interface SFBViewSelectorBarItem : NSObject
{}

@property (copy) NSString * identifier;
@property (copy) NSString * label;
@property (copy) NSString * tooltip;
@property (copy) NSImage * image;
@property (strong) NSView * view;

+ (id) itemWithIdentifier:(NSString *)identifier label:(NSString *)label tooltip:(NSString *)tooltip image:(NSImage *)image view:(NSView *)view;

- (id) initWithIdentifier:(NSString *)identifier label:(NSString *)label tooltip:(NSString *)tooltip image:(NSImage *)image view:(NSView *)view;

@end
