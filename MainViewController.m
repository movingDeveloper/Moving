

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"
#define NUMBER_OF_ITEMS 15
#define ITEM_SPACING 90.0f


@implementation MainViewController

@synthesize items;
@synthesize imageView;
@synthesize carousel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"   %s",__FUNCTION__);
    
    [super viewDidLoad];
    
    UIImageView *imageView1  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    imageView1.image = [UIImage imageNamed:@"background_home"];
    
    [self.view addSubview:imageView1];
    [imageView1 release];
    
    [self.view addSubview:self.imageView];
    
    carousel = [[iCarousel alloc]init];
    carousel.frame = CGRectMake(0, 0, 320, 460);
    [self.view addSubview:carousel];
    carousel.delegate =self;
    carousel.dataSource = self;

    carousel.type = iCarouselTypeWheel;
    
    NSString *httpURl = @"http://zixun.www.net.cn/api/hichinaapp.php?module=ad&ver=1.0&client=ios&timestamp=20121106102334&appid=IOS259";
    
    NSString *string = [httpURl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL*url=[NSURL URLWithString:string];
    
    NSString *str= [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];

    NSJSONSerialization
    NSArray *ary = [str componentsSeparatedByString:@"\\"];
    NSMutableString *str1 = [[NSMutableString alloc]init];
    for (NSString *s in ary) {
        [str1 appendFormat:s];
    }
    NSLog(@"%@",str1);
//    NSData *data = [array dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSLog(@"+++++++++++++++%@",data);
//    
//    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"--------%d",[json count]);
    
//    
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0f];
//    
//    [NSURLConnection connectionWithRequest:request delegate:self];
    
}


#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return NUMBER_OF_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{ 
    NSLog(@"____%s",__FUNCTION__);
	UIButton *button = (UIButton *)view;
    
    NSArray *ary = [[NSArray alloc]initWithObjects:@"check_home",@"con_home",@"exam_home",@"infor_home",@"monitor_home", nil];
    
	if (button == nil)
	{
		//no button available to recycle, so create new one
		UIImage *image = [UIImage imageNamed:[ary objectAtIndex:index%5]];
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, image.size.width/2.5, image.size.height/2.5);
		[button setBackgroundImage:image forState:UIControlStateNormal];
		[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return button;
}

- (void)carousel:(iCarousel *)_carousel didSelectItemAtIndex:(NSInteger)index
{
    // NSLog(@"index = %d",index);
    switch (index)
    {
        case 0:
            
            break;
            
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
    
    
    
    [[[[UIAlertView alloc] initWithTitle:@"Button Tapped"
                                 message:[NSString stringWithFormat:@"You tapped button number %i", index]
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil] autorelease] show];
    
    
}
- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

#pragma mark -
#pragma mark Button tap event

- (void)buttonTapped:(UIButton *)sender
{
	NSInteger index = [carousel indexOfItemView:sender];
	
    [[[[UIAlertView alloc] initWithTitle:@"Button Tapped"
                                 message:[NSString stringWithFormat:@"You tapped button number %i", index]
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil] autorelease] show];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    tempData = [[NSMutableData alloc]init]; 
    
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [tempData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *str = [[NSString alloc]initWithData:tempData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);


   // NSArray *ary = [[NSArray alloc]ini];
//    
    NSArray *ary = [str componentsSeparatedByString:@"\\"];
    NSMutableString *str1 = [[NSMutableString alloc]init];
    for (NSString *s in ary) {
    [str1 appendFormat:s];
}

NSLog(@"%@",str1);
    
    
    [tempData release];
   // [str release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [imageView release];
    [super dealloc];
}
@end
