//
//  TimeTableListViewController.m
//  TimeTable
//
//  Created by Kim Minsu on 2013/04/29.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "TimeTableListViewController.h"
#import "ListViewModel.h"
#import "TimeTableSubjectListViewController.h"

@interface TimeTableListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ListViewModel *viewModel;
@end

@implementation TimeTableListViewController

- (ListViewModel *)viewModel{
    if(!_viewModel) {
        _viewModel = [[ListViewModel alloc] initWithMode:[Course class] selectedCourseId:0];
    }
    return _viewModel;
}

#pragma mark - TableView Delegate Methods
- (NSUInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.sectionCount;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.viewModel sectionIndexTitles];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.viewModel titleForHeaderInSection:section];
}

- (NSUInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:self.viewModel.cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:self.viewModel.cellIdentifier];
    }
    
    id contents = [self.viewModel cellContentsForRowAtIndexPath:indexPath];
    if([contents isKindOfClass:[Course class]]) {
        Course *course = (Course *)contents;
        cell.textLabel.text = course.name;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"ShowSubjectList"]) {
        TimeTableSubjectListViewController *subjectListViewController = [segue destinationViewController];
    
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        id contents = [self.viewModel cellContentsForRowAtIndexPath:myIndexPath];
        if([contents isKindOfClass:[Course class]]) {
            Course *course = (Course *)contents;
            subjectListViewController.selectedCourseId = course.courseId;
        }
        [self.tableView deselectRowAtIndexPath:myIndexPath animated:NO];
    }
}


@end
