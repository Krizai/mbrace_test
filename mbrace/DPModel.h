//
//  DPModel.h
//  mbrace
//
//  Created by Dmitry Povolotsky on 6/13/14.
//  Copyright (c) 2014 Dmitry Povolotsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPModel : NSObject
+ (DPModel*) sharedInstance;

- (NSArray*) fetchNotes;
- (void) updateNotes;


@end
