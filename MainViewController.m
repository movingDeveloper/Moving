
#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"
#define NUMBER_OF_ITEMS 15
#define ITEM_SPACING 90.0f

@implementation MainViewController

@synthesize scrollView = _scrollView;
@synthesize items ;
@synthesize carousel ;

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView1  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    imageView1.image = [UIImage imageNamed:@"background_home"];
    [self.view addSubview:imageView1];
    [imageView1 release];
    
    carousel = [[iCarousel alloc]init];
    carousel.frame = CGRectMake(0, 0, 320, 400);
    [self.view addSubview:carousel];
    carousel.delegate =self;
    carousel.dataSource = self;
    
    carousel.type = iCarouselTypeWheel;
    
    NSString *httpURl = @"http://zixun.www.net.cn/api/hichinaapp.php?module=ad&ver=1.0&client=ios&timestamp=20121106102334&appid=IOS259";
    
    NSString *string = [httpURl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL*url=[NSURL URLWithString:string];
    
    NSString *s = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSString *s1 = [s substringFromIndex:2];
    
    NSArray *a = [s1 JSONValue];
    
    NSURL *image1_url1 = [NSURL URLWithString:[[a objectAtIndex:0]objectForKey:@"pic"]];
    NSURL *image2_url2 = [NSURL URLWithString:[[a objectAtIndex:1]objectForKey:@"pic"]];
    
    image1_url = [[NSURL URLWithString:[[a objectAtIndex:0]objectForKey:@"link"]]retain];
    image2_url = [[NSURL URLWithString:[[a objectAtIndex:1]objectForKey:@"link"]]retain];
    
    NSLog(@"%@",image1_url);
    NSLog(@"%@",[[a objectAtIndex:0]objectForKey:@"pic"]);
    NSLog(@"%@",[[a objectAtIndex:1]objectForKey:@"pic"]);
    
    //第一张图片的请求与连接
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:image1_url1];
    NSURLConnection *conn1_temp = [NSURLConnection connectionWithRequest:request1 delegate:self];
    conn1 = conn1_temp ;
    [conn1 start];
    //第2张图片的请求与连接
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:image2_url2];
    NSURLConnection *conn2_temp = [NSURLConnection connectionWithRequest:request2 delegate:self];
    conn2 = conn2_temp;
    [conn2 start];
    
    //下面的scroolView
    UIScrollView *scrollViewT = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 350, 320, 80)];
    scrollViewT.backgroundColor = [UIColor clearColor];
    scrollViewT.contentSize =CGSizeMake(320*2, 80);
    scrollViewT.delegate =self;
    scrollViewT.tag = 1000;
    scrollViewT.userInteractionEnabled = YES;
    self.scrollView = scrollViewT;
    [self.view addSubview:scrollViewT];
    [scrollViewT release];
    
    //下面的pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 430, 320, 30)];
    pageControl.tag = 10001;
    pageControl.backgroundColor = [UIColor grayColor];
    pageControl.numberOfPages = 2;
    [pageControl addTarget:self action:@selector(pageEventMathod:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    [pageControl release];
    
}

#pragma mark scrollViewDelegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    UIPageControl *page =(UIPageControl *) [self.view viewWithTag:10001];
    if (scrollView1.contentOffset.x == 0.0) 
    {
        page.currentPage = 0;
    }
    else
    {
        page.currentPage = 1;
    }
}

#pragma mark pageEventMathod methods

-(void)pageEventMathod:(UIPageControl *)sender
{
    int page = sender.currentPage;
    
    UIScrollView *view =(UIScrollView *) [self.view viewWithTag:1000];
    
    if (page > 0) 
    {
        [view setContentOffset:CGPointMake(320, 0)];
    }
    else
    {
        [view setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return NUMBER_OF_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{ 
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
    [super viewDidUnload];
    self.carousel = nil;
    self.items = nil;
    self.scrollView = nil;
    tempData = nil;
    tempData2 = nil;
    conn1 = nil;
    conn2 = nil;
    image1_url = nil;
    image2_url = nil;
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    tempData = [[NSMutableData alloc]init]; 
    tempData2 = [[NSMutableData alloc]init]; 
    
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == conn1)
    {
        [tempData appendData:data];
        
    }
    else
    {
        [tempData2 appendData:data];
    }
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"%s",__FUNCTION__);
    if (connection == conn1) 
    {
        NSLog(@"conn1");
        NSLog(@"%@",tempData);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.delegate = self;
        UIImage *image = [UIImage imageWithData:tempData];
        UIImageView *view = [[UIImageView alloc]initWithImage:image];
        view.backgroundColor = [UIColor greenColor];
        view.frame = CGRectMake(0, 0, 320, 80);
        [view addGestureRecognizer:tap];
        view.userInteractionEnabled = YES;
        [self.scrollView addSubview:view];
        [view release];
        [tap release];
        
        NSString *filename = [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/tmp",@"/image12.png"];
        NSLog(@"filename ===%@",filename);
        [tempData writeToFile:filename atomically:YES];
        NSLog(@"接收完毕");
        
    }
    else
    {
        NSLog(@"conn2");
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2Click:)];
        
        tap2.delegate = self;
        UIImage *image = [UIImage imageWithData:tempData2];
        UIImageView *view = [[UIImageView alloc]initWithImage:image];
        view.frame = CGRectMake(320, 0, 320, 80);
        [view addGestureRecognizer:tap2];
        view.userInteractionEnabled = YES;
        view.backgroundColor = [UIColor blackColor];
        [self.scrollView addSubview:view];
        [view release];  
        [tap2 release];
        
        NSString *filename = [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/tmp",@"/image13.png"];
        NSLog(@"filename ===%@",filename);
        [tempData2 writeToFile:filename atomically:YES];
        NSLog(@"接收完毕");
    }
    
}
-(void)tapClick:(id)sender
{ 
    [[UIApplication sharedApplication]openURL:image1_url];
    
}
-(void)tap2Click:(id)sender
{
    [[UIApplication sharedApplication]openURL:image2_url];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [super dealloc];
    [_scrollView release];
    
    [carousel release];
    [items release];
    
}
@end
