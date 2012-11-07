

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface MainViewController : UIViewController<iCarouselDataSource, iCarouselDelegate,NSURLConnectionDelegate>
{
    NSMutableData *tempData;
}

@property (nonatomic, retain)  iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *items;
- (void)setUp;
@end
