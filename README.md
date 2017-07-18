# sdWebImageUseDemo
# 基于以下这种需求，而封装的一种imageView：
    1、wife环境下：              加载高清原图图片
    2、手机自带网络（3G/4G)环境下：加载缩略图
    3、加载一次之后需要缓存图片到本地，下次加载优先读取缓存，如果缓存不存在，再去加载
# 使用案例：
    @property (nonatomic,weak) IBOutlet SSJWebImageView *showImageView;
    - (void)viewDidLoad {
        [super viewDidLoad];
        self.showImageView.placeholderImageName = @"缺省图片名字（如不填写，会使用默认图片）";
        [self.showImageView showImageWithShowType:DeviceNetWorkShowWithThumbnail originalHttp:httpOriginal thumbnailHttp:httpThumbnail];
        }
    
