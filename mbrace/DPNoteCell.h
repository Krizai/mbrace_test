//
//  DPNoteCell.h
//  mbrace
//
//  Created by Dmitry Povolotsky on 6/13/14.
//  Copyright (c) 2014 Dmitry Povolotsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPNote;
@interface DPNoteCell : UITableViewCell

- (void) fillFromNote:(DPNote*) note;
+ (CGFloat) preferredHeightForNote:(DPNote*) note usingWidth:(CGFloat) width;

@end
