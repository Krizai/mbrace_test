//
//  DPModel.m
//  mbrace
//
//  Created by Dmitry Povolotsky on 6/13/14.
//  Copyright (c) 2014 Dmitry Povolotsky. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DPModel.h"
#import "DPNote.h"



@interface DPModel ()
@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation DPModel


+ (DPModel*) sharedInstance{
    static DPModel *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [DPModel new];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        //create oblject model
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"notes" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        //store
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"notes.sqlite"];
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
        
        //object context
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:_persistentStoreCoordinator];
        
        
    }
    return self;
}
- (NSArray*) fetchNotes{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"DPNote"];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"noteId" ascending:YES]]];
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return fetchedObjects;

}
- (void) updateNotes{
    [NSThread sleepForTimeInterval:3]; //Just to make the process of updating visible;
    [self updateDatabaseWithArray:[self dataForUpdate]];
}


- (void) updateDatabaseWithArray:(NSArray*) array
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"DPNote"];
    for(NSDictionary* noteDictionary in array){
        NSNumber* noteId = noteDictionary[@"id"];
        if(!noteId || ![noteId isKindOfClass:[NSNumber class]]) continue;
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"noteId = %d" argumentArray:@[noteId]];
        fetchRequest.predicate = predicate;

        NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        if (fetchedObjects.count == 1) {
            DPNote* note = fetchedObjects[0];
            [note updateFromDictionary:noteDictionary];
        }else if (fetchedObjects.count == 0){
            [DPNote noteFromDictionary:noteDictionary inContext:self.managedObjectContext];
        }
    }
    [self.managedObjectContext save:nil];
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSArray*) dataForUpdate{
    return  @[@{@"id":@1, @"text": @"First note"},
              @{@"id":@2, @"text": @"Secon note with a link to http://www.google.de"},
              @{@"id":@3, @"text": @"Third note"},
              @{@"id":@4, @"text": @"Fourth note"},
              @{@"id":@5, @"text": @"Fifth note with an email adress to jakob@mbraceapp.com"},
              @{@"id":@6, @"text": @"6th note"},
              @{@"id":@6, @"text": @"6th note updated"},
              @{@"id":@7, @"text": @"7th note"},
              @{@"id":@8, @"text": @"8th note"},
              @{@"id":@9, @"text": @"9th note"},
              @{@"id":@10, @"text": @"10th note"},
              @{@"id":@11, @"text": @"11th note"},
              @{@"id":@12, @"text": @"12th note"},
              @{@"id":@13, @"text": @"13th note"},
              @{@"id":@14, @"text": @"14th note"},
              @{@"id":@15, @"text": @"get mbrace at http://www.getmbrace.com"},
              @{@"id":@16, @"text": @"16th note"},
              @{@"id":@17, @"text": @"17th note"},
              @{@"id":@18, @"text": @"18th note"},
              @{@"id":@19, @"text": @"19th note"},
              @{@"id":@20, @"text": @"20th note"},
              @{@"id":@21, @"text": [NSNull null]},
              @{@"id":@22, @"text": @"22th note"},
              @{@"id":@23, @"text": @"23th note"},
              @{@"id":@24, @"text": @"Visit www.mbraceapp.com"},
              @{@"id":@25, @"text": @"25th note"},
              @{@"id":@26, @"text": @"Note that is a little bit longer than all the other notes because of consiting of some strings that are useless and take a lot of space"},
              @{@"id":@27, @"text": @"27th note"},
              @{@"id":@28, @"text": @"28th note"},
              @{@"id":@29, @"text": @"29th note"},
              @{@"id":@30, @"text": @"another email to lukas@mbraceapp.com"},
              @{@"id":@31, @"text": @"31th note"},
              @{@"id":@32, @"text": @"32th note"},
              @{@"id":@33, @"text": @"33th note"},
              @{@"id":@34, @"text": @"almost at the end note"},
              @{@"id":@35, @"text": @"Last note note"},
              @{@"id":@12, @"text": @"Updated 12th note"}];

}



@end
