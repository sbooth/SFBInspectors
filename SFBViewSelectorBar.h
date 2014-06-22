/*
 *  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved
 */

#import <Cocoa/Cocoa.h>

@class SFBViewSelectorBarItem;

@interface SFBViewSelectorBar : NSView
{}

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, weak, readonly) SFBViewSelectorBarItem * selectedItem;

- (void) addItem:(SFBViewSelectorBarItem *)item;

- (BOOL) selectItem:(SFBViewSelectorBarItem *)item;
- (BOOL) selectItemWithIdentifer:(NSString *)itemIdentifier;

- (SFBViewSelectorBarItem *) itemAtIndex:(NSInteger)itemIndex;
- (SFBViewSelectorBarItem *) itemWithIdentifier:(NSString *)itemIdentifier;

@end
