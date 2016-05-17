#import "WPPostContentViewProvider.h"

@class AbstractPost;

@protocol PostCardTableViewCellDelegate <NSObject>
@optional
- (void)cell:(nonnull UITableViewCell *)cell handleEditPost:(nonnull AbstractPost *)post;
- (void)cell:(nonnull UITableViewCell *)cell handleViewPost:(nonnull AbstractPost *)post;
- (void)cell:(nonnull UITableViewCell *)cell handleStatsForPost:(nonnull AbstractPost *)post;
- (void)cell:(nonnull UITableViewCell *)cell handleTrashPost:(nonnull AbstractPost *)post;
- (void)cell:(nonnull UITableViewCell *)cell handlePublishPost:(nonnull AbstractPost *)post;
- (void)cell:(nonnull UITableViewCell *)cell handleRestorePost:(nonnull AbstractPost *)post;
@end