#import "WPSearchControllerConfigurator.h"
#import "WordPress-Swift.h"

const CGFloat SearchBariPadWidth = 600.0;
const CGFloat SearchWrapperViewMinHeight = 44.0;
const NSTimeInterval SearchBarAnimationDuration = 0.2; // seconds

@interface WPSearchControllerConfigurator ()

@property (nonatomic, weak) WPSearchController *searchController;
@property (nonatomic, weak) UIView *searchWrapperView;
@property (nonatomic, weak) UISearchBar *searchBar;

@end

@implementation WPSearchControllerConfigurator

- (instancetype)initWithSearchController:(WPSearchController *)searchController
                   withSearchWrapperView:(UIView *)searchWrapperView
{
    self = [super init];
    if (self) {
        _searchController = searchController;
        _searchWrapperView = searchWrapperView;
        _searchBar = _searchController.searchBar;
    }
    
    return self;
}

- (void)configureSearchControllerAndWrapperView
{
    [self configureSearchController];
    [self configureSearchWrapper];
}

- (void)configureSearchController
{
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    [self configureSearchBar];
}

- (void)configureSearchBar
{
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.searchBar.accessibilityIdentifier = @"Search";
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    self.searchBar.tintColor = [WPStyleGuide grey]; // cursor color
    self.searchBar.translucent = NO;
    self.searchBar.barStyle = UIBarStyleBlack;
    self.searchBar.barTintColor = [WPStyleGuide wordPressBlue];
    self.searchBar.showsCancelButton = YES;
    
    // IMPORTANT: Without this the app crashes for iOS < 7.1.  Not needed for iOS >= 7.1.
    // This is not very well documented but basically UISearchBar didn't conform to protocol
    // UITextInputTraits until 7.1, which is the reason why this is crashing.
    //
    // A hackish alternative is available for earlier versions of iOS although I don't think this
    // is worth the effort as we'll be dropping support soon (plus hackish solutions are bad):
    // http://stackoverflow.com/questions/20065487/uitextinputtraits-is-not-working-in-ios7
    //
    // This means the return button will read "Search" for iOS < 7.1 instead of "Done".  No biggie.
    //
    if ([self.searchBar respondsToSelector:@selector(setReturnKeyType:)]) {
        self.searchBar.returnKeyType = UIReturnKeyDone;
    }
    
    [self.searchBar setImage:[UIImage imageNamed:@"icon-clear-searchfield"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [self.searchBar setImage:[UIImage imageNamed:@"icon-post-list-search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [self configureSearchBarForSearchView];
}

- (void)configureSearchBarForSearchView
{
    UISearchBar *searchBar = self.searchController.searchBar;
    [self.searchWrapperView addSubview:searchBar];
    
    if ([UIDevice isPad]) {
        [searchBar.centerXAnchor constraintEqualToAnchor:self.searchWrapperView.centerXAnchor].active = YES;
        NSLayoutConstraint *sizeConstraint = [searchBar.widthAnchor constraintEqualToConstant:SearchBariPadWidth];
        sizeConstraint.priority = UILayoutPriorityDefaultLow;
        sizeConstraint.active = YES;
        [searchBar.widthAnchor constraintLessThanOrEqualToAnchor:self.searchWrapperView.widthAnchor multiplier:1].active = YES;
    } else {
        [searchBar.widthAnchor constraintEqualToAnchor:self.searchWrapperView.widthAnchor multiplier:1].active = YES;
    }
    [searchBar.bottomAnchor constraintEqualToAnchor:self.searchWrapperView.bottomAnchor].active = YES;
}

- (void)configureSearchWrapper
{
    self.searchWrapperView.backgroundColor = [WPStyleGuide wordPressBlue];
}

@end
