# sdWebImageUseDemo
## 使用案例：
    @property (nonatomic,weak) IBOutlet SSJWebImageView *showImageView;
    - (void)viewDidLoad {
        [super viewDidLoad];
        self.showImageView.placeholderImageName = @"缺省图片名字（如不填写，会使用默认图片）";
        [self.showImageView showImageWithShowType:DeviceNetWorkShowWithThumbnail originalHttp:httpOriginal thumbnailHttp:httpThumbnail];
    }
