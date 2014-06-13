//
//  Note.m
//  mbrace
//
//  Created by Dmitry Povolotsky on 6/13/14.
//  Copyright (c) 2014 Dmitry Povolotsky. All rights reserved.
//

#import "DPNote.h"
#import "NSDictionary+ClassGetter.h"


@implementation DPNote

@dynamic noteId;
@dynamic text;

+ (instancetype) noteFromDictionary:(NSDictionary*) dictionary
                          inContext:(NSManagedObjectContext*) context{
    
    DPNote *resultNote = [NSEntityDescription insertNewObjectForEntityForName:@"DPNote"
                                                       inManagedObjectContext:context];
    NSNumber* idValue = [dictionary valueForKey:@"id" withClass:[NSNumber class]];
    if(!idValue) return nil;
    resultNote.noteId = idValue;
    
    NSString* text = [dictionary valueForKey:@"text" withClass:[NSString class]];
    resultNote.text = text;
    return resultNote;
}

- (void) updateFromDictionary:(NSDictionary*) dictionary{
    NSString* text = [dictionary valueForKey:@"text" withClass:[NSString class]];
    self.text = text;
    
}


@end
