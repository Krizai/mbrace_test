//
//  DPLinkDetectionLabel.m
//  mbrace
//
//  Created by Dmitry Povolotsky on 6/13/14.
//  Copyright (c) 2014 Dmitry Povolotsky. All rights reserved.
//

#import "DPLinkDetectionLabel.h"

@interface DPLinkDetectionLabel ()

@property ( nonatomic, retain) NSURL* url;
@end

@implementation DPLinkDetectionLabel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tapGesture];
}
- (void) setText:(NSString *)text{
    text = text? text :@"";
    NSMutableAttributedString* coloredString = [[NSMutableAttributedString alloc] initWithString:text];
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink
                                                               error:&error];
    
    [detector enumerateMatchesInString:text
                               options:kNilOptions
                                 range:NSMakeRange(0, [text length])
                            usingBlock:
     ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
         [coloredString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:result.range];
         self.url = result.URL;
     }];
    self.attributedText = coloredString;
}

-(void) handleTap:(UIGestureRecognizer *) sender {
    if (self.url){
        [[UIApplication sharedApplication] openURL:self.url];
    }
}


@end
