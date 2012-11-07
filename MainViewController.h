

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface MainViewController : UIViewController<iCarouselDataSource, iCarouselDelegate,NSURLConnectionDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    NSMutableData *tempData;
    NSMutableData *tempData2;
    
    NSURLConnection *conn1;
    NSURLConnection *conn2;
    
    NSURL *image1_url;
    NSURL *image2_url;
}

@property (nonatomic, retain)  iCarousel *carousel;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) UIScrollView *scrollView;
- (void)setUp;
@end
