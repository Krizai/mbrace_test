//
//  Note.h
//  mbrace
//
//  Created by Dmitry Povolotsky on 6/13/14.
//  Copyright (c) 2014 Dmitry Povolotsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DPNote : NSManagedObject

@property (nonatomic, retain) NSNumber * noteId;
@property (nonatomic, retain) NSString * text;


+ (instancetype) noteFromDictionary:(NSDictionary*) dictionary
                          inContext:(NSManagedObjectContext*) context;
- (void) updateFromDictionary:(NSDictionary*) dictionary;


@end
