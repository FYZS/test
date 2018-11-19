//
//  ViewController.m
//  gitStar
//
//  Created by 凡义 on 2018/4/23.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import "Person.h"
#import "ViewController+runtime.h"
#import "ViewController+lifeCircle.h"
#import "ViewController+tableView.h"
#import "ViewController+GCD.h"
#import "ViewController+Operation.h"

@interface ViewController ()

@property (nonatomic, copy) NSMutableArray *testArr;

@end

@implementation ViewController

@synthesize testTitle = _testTitle;

- (instancetype)init {
    self = [super init];
    if(self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    
    NSLog(@"lifecircle %s", __FUNCTION__);

    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    NSLog(@"lifecircle %s", __FUNCTION__);

    return self;
}

//视图已经加载成功
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.array = [NSMutableArray array];
    [self.array addObject:@"1"];
    //    NSLog(@"%@", self.array);
    
    //    NSArray *array = @[@[@"a", @"b"], @[@"c", @"d"]];
    //    NSArray *copyArray = [array copy];
    //    NSMutableArray *mCopyArray = [array mutableCopy];
    
    //    NSLog(@"%@", self.array);
//    self.testArr = self.array;
    NSLog(@"lifecircle %s", __FUNCTION__);
    
    //    [self.view.layer addSublayer:self.backgroundLayer];
    //    [self viewAndLayer];
    
//    __weak NSString *weakNumber = [[NSString alloc] initWithFormat:@"weak"];
//    NSString *strongNumber = [[NSString alloc] initWithFormat:@"strong"];
//
//    NSLog(@"weak :%p, strong :%p", weakNumber, strongNumber);
    
//    if([weakNumber isKindOfClass:NSClassFromString(@"NSString")]) {
//
//    }
    
    //tableView
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(80);
        make.left.right.bottom.offset(0);
    }];
    
    self.maxNum = 100;
    self.numsArray = [NSMutableArray arrayWithCapacity:100];
    //尽量在每一次reload之前就把cell的数据计算出来, 优化列表流畅度
    [self refreshTableView];
    
    //    self.tableView setRefreshControl:(UIRefreshControl * _Nullable)
    
    //    Person *person = [Person perponWithType:PersonType_Woman];
    //    NSLog(@"%@", [person class]);
    
    //    [self asyncInSerialQueue];
    
    [self testAutoDictionary];
    
    [self doWithOperation];
    
//    [self testSwizzleinng];
}

#pragma mark - 数据持久化存储
- (void)dataSave {
    //NSUserDefaults一般同于偏好设置的存储, 不建议用来密码等关键信息的保存, 因为NSUserDefaults最终还是以plist文件的形式保存的, 安全性很低
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"key" forKey:@"key"];
    [userDefault synchronize];
    
    
    //新建plist文件, 然后需要的时候, 读取这个文件把数据存储进去,比如存储每个下载文件的文件信息
    
    //Keychain, 比如用来存储uuid, 好处是app删除之后, 存储在Keychain中的数据不会清除, 下次app再安装也可以再次使用
    
    //NSKeyedArchiver归档与解档
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:@"xxobject"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager changeCurrentDirectoryPath:@"更新目录到当前要归档的路径"];
    [NSKeyedArchiver archiveRootObject:@"object" toFile:@"fileName"];
    [NSKeyedUnarchiver unarchiveObjectWithFile:@"文件路径"];
    
    //沙盒写入. 比如下载的视频文件
    
    //数据库, 比如FMDB, 上报数据就使用了FMDB
}

#pragma mark - 文件存储
// !!!: 使用前请仔细阅读 iOS 文件存储文档 https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW28
- (void)fileSave {
    
//    Library/Application Support/, 默认备份, 可以设置不备份
    NSString *filePath1 = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES).firstObject;
    
    //Library/Caches/, 下载的文件不能保存在此目录,比如视频,内存不足时可能会被系统清理
    NSString *filePath2 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    //Documents/ ,  默认备份, 可以设置不备份
    NSString *filePath3 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSLog(@"%@, %@, %@", filePath1, filePath2, filePath3);
}

#pragma mark - view&layer
- (void)viewAndLayer {
    //uiview 继承自UIResponder, 所以是可以相应事件的:如touchBegin,touchMoved,touchEnd,touchCancel
    UIView *view = [UIView new];
    
    //layer 继承自NSObject,
    CALayer *layer = [CALayer layer];
    
    [view.layer addSublayer:layer];
    
    CALayer *shadeLayer = [CALayer new];
    UIImage *image = [UIImage imageNamed:@"image"];
    shadeLayer.position = CGPointMake(30, 30);
    shadeLayer.bounds = CGRectMake(0, 0, 50, 50);
    shadeLayer.backgroundColor = [UIColor whiteColor].CGColor;
    shadeLayer.shadowColor = [UIColor greenColor].CGColor;
    shadeLayer.contents = (id)image.CGImage;
    shadeLayer.shadowOffset = CGSizeMake(20, 20); //设置阴影的偏移量,pi
    shadeLayer.shadowRadius = 20.0;  //设置阴影的半径
    shadeLayer.shadowOpacity = 1.; //设置阴影的不透明度
//    shadeLayer.masksToBounds = YES;//设置之后阴影就看不到了
    [self.backgroundLayer addSublayer:shadeLayer];
    
    CAShapeLayer *circleLayer = [CAShapeLayer new];
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = [UIColor greenColor].CGColor;
    circleLayer.opacity = 1;
    circleLayer.lineWidth = 10;
    circleLayer.lineCap = kCALineCapRound;//两端封口处是圆形的
    
    CGFloat startA = - M_PI_2  + M_PI * 2 * 0;  //设置进度条起点位置
    CGFloat endA = - M_PI_2  + M_PI * 2 * (0 + 0.8);

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 200) radius:50 startAngle:startA endAngle:endA clockwise:YES];
    circleLayer.path = path.CGPath;
    [self.backgroundLayer addSublayer:circleLayer];
    
    //生成渐变色
    CALayer *gradientLayer = [CALayer layer];

    CAGradientLayer *colorLayer = [CAGradientLayer new];
    colorLayer.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor greenColor].CGColor];
//    colorLayer.frame = CGRectMake(90, 140, 120, 120);
    colorLayer.bounds = CGRectMake(0, 0, 120, 120);
    colorLayer.position = CGPointMake(150, 200);
    colorLayer.locations = @[@0.3, @0.9, @1];
    [gradientLayer addSublayer:colorLayer];

    [gradientLayer setMask:circleLayer];
    [self.backgroundLayer addSublayer:gradientLayer];
}

- (void)setTestTitle:(NSString *)testTitle {
    _testTitle = testTitle;
}

- (NSString *)testTitle {
    return _testTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - lazy load
- (CALayer *)backgroundLayer {
    if(!_backgroundLayer) {
        _backgroundLayer = [CALayer new];
        _backgroundLayer.backgroundColor = [UIColor redColor].CGColor;
        _backgroundLayer.bounds = CGRectMake(0, 0, 300, 400);//设置bound确定尺寸
        _backgroundLayer.position = CGPointMake(210, 300);//设置基于superlayer的坐标, 确定位置
        _backgroundLayer.cornerRadius = 10;
        _backgroundLayer.borderColor = [UIColor blueColor].CGColor;
        _backgroundLayer.borderWidth = 3.f;
    }
    return _backgroundLayer;
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 30;
    }
    return _tableView;
}

@end
