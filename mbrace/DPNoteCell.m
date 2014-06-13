//
//  DPNoteCell.m
//  mbrace
//
//  Created by Dmitry Povolotsky on 6/13/14.
//  Copyright (c) 2014 Dmitry Povolotsky. All rights reserved.
//

#import "DPNoteCell.h"
#import "DPNote.h"

@interface DPNoteCell ()
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteTextLabel;

@end

@implementation DPNoteCell

- (void) fillFromNote:(DPNote*) note{
    self.idLabel.text = [NSString stringWithFormat:@"%d", note.noteId.intValue];
    self.noteTextLabel.text = note.text;
}

+ (CGFloat) preferredHeightForNote:(DPNote*) note usingWidth:(CGFloat) width{
    return [note.text sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(width - 12*2 -22, NSIntegerMax)].height + 8*2;
    
}

@end
