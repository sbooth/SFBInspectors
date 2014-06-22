/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

@interface SFBViewSelectorBarItem : NSObject
{}

@property (nonatomic, copy) NSString * identifier;
@property (nonatomic, copy) NSString * label;
@property (nonatomic, copy) NSString * tooltip;
@property (nonatomic, copy) NSImage * image;
@property (nonatomic, strong) NSView * view;

+ (id) itemWithIdentifier:(NSString *)identifier label:(NSString *)label tooltip:(NSString *)tooltip image:(NSImage *)image view:(NSView *)view;

- (id) initWithIdentifier:(NSString *)identifier label:(NSString *)label tooltip:(NSString *)tooltip image:(NSImage *)image view:(NSView *)view;

@end
