//
//  DPViewController.m
//  mbrace
//
//  Created by Dmitry Povolotsky on 6/13/14.
//  Copyright (c) 2014 Dmitry Povolotsky. All rights reserved.
//

#import "DPViewController.h"
#import "DPModel.h"
#import "DPNote.h"
#import "DPNoteCell.h"

@interface DPViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSArray* notesArray;

@end

@implementation DPViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self switchToUpdatingState:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[DPModel sharedInstance] updateNotes];
        self.notesArray = [[DPModel sharedInstance] fetchNotes];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self switchToUpdatingState:NO];
        });
    });

}

- (void)switchToUpdatingState:(BOOL) updating{
    self.tableView.hidden = updating;
    self.activityIndicator.hidden = !updating;
    if (!updating) {
        [self.tableView reloadData];
    }
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.notesArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"NoteCell";

    DPNoteCell *cell = (DPNoteCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    DPNote* note = self.notesArray[indexPath.row];
    [cell fillFromNote:note];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DPNote* note = self.notesArray[indexPath.row];
    return [DPNoteCell preferredHeightForNote:note usingWidth:tableView.frame.size.width];
    
}


@end
