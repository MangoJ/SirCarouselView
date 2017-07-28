# SirCarouselView

* 简单易用的轮播控件, 基于UIScollview实现.
  -

1.实现了无限轮播效果(显示的图片可以为本地图片或URL)<br> 
2.自定义PageControl属性<br>
3.设置图片简介(自定义文字颜色)

* 简单使用
  -

### 初始化SirSlideshowView并设置代理
  
```
    let bannerView = SirSlideshowView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
    //设置代理
    bannerView.delegate = self
    self.view.addSubview(bannerView)
```
### 实现代理方法
```
   //返回所点击Banner图片的下标
   func ClickBanner(index:Int) {
        let test = TestViewController()
        test.title = "Banner\(index)详情"
        self.navigationController?.pushViewController(test, animated: true)
    } 
```
### 属性介绍
 
###### Property
```
    /// 是否添加Banner图片标题:默认为false,不添加
    var isShowImageTitle : Bool?
    /// Banner图片数组
    var images : [Any]
    /// Banner标题数组
    var imageTitles : [String]
    /// Banner标题颜色:默认为黑色
    var imageTitleColor : UIColor
    /// 分页指示器非当前页小点颜色:默认为白色
    var  pageIndicatorColor : UIColor
    /// 分页指示器当前页小点颜色:默认为黑色
    var currentPageIndicatorColor : UIColor
    ///自动滑动间隔时间(s), 默认为 3.0
    var scrollInterval : TimeInterval
```
###### Method
```
开始/停止用于自动滚动的定时器. 比如可以在viewWillAppear:和viewWillDisappear:中分别调用这两个方法, 使得Banner没有显示的时候定时器不会一直占用资源
    ///添加定时器
    func addTimer()
    //移除定时器
    removeTimer()
```

### Installation
* 手动添加
    将SirCarouselView文件拖拽到项目中
    

