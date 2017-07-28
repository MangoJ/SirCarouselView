//
//  SirSlideshowView.swift
//  SirCarouselView
//
//  Created by Sirius on 2017/7/21.
//  Copyright © 2017年 com.Sirius.app. All rights reserved.
//

import UIKit
import Kingfisher

/// 分页标签的位置
///
/// - center: 中间
/// - left: 左侧
/// - right: 右侧
enum PagePosition {
    case center
    case left
    case right
}

protocol SirSlideshowViewDelegate {
    func ClickBanner(index:Int)
}

class SirSlideshowView: UIView {
    
    var delegate : SirSlideshowViewDelegate?
    
    fileprivate var scrollView : UIScrollView?
    
    fileprivate var pageControl : UIPageControl?
    //Banner的title
    fileprivate var imagetitleLabel : UILabel?
    
    fileprivate var imageTitleView : UIView?
    
    fileprivate var isShow : Bool? = false
    
    fileprivate var timer : Timer?
    
    fileprivate var imageViews = [UIImageView]()
    
    fileprivate var positionPage : PagePosition
    
    /// 是否添加Banner图片标题:默认为false,不添加
    var isShowImageTitle : Bool? = false {
        didSet{
            isShow = isShowImageTitle
            setUIForImageTitle()
        }
    }
    
    /// Banner图片数组
    var images : [Any] = []{
        didSet{
            pageControl?.numberOfPages = images.count
            reloadImage()
        }
    }
    
    /// Banner标题数组
    var imageTitles : [String] = []{
        didSet{
            reloadImage()
        }
    }
    
    /// Banner标题颜色
    var imageTitleColor : UIColor = UIColor.black{
        didSet{
            imagetitleLabel?.tintColor = imageTitleColor
        }
    }
    
    /// 分页指示器非当前页小点颜色
    var  pageIndicatorColor : UIColor = UIColor.white{
        didSet{
            pageControl?.pageIndicatorTintColor = pageIndicatorColor
        }
    }
    
    /// 分页指示器当前页小点颜色
    var currentPageIndicatorColor : UIColor = UIColor.black{
        didSet{
            pageControl?.currentPageIndicatorTintColor = currentPageIndicatorColor
        }
    }
    
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - frame: Frame
    ///   - images: Banner图片数组
    ///   - imageTitles: Banner标题数组
    ///   - pagePosition: 分页指示器的位置
    init(frame: CGRect,images:[Any]? = [],imageTitles:[String]? = [],pagePosition:PagePosition? = .center) {
        if images == nil {
            self.images = [""]
        }else{
            self.images = images ?? []
        }
        self.imageTitles = imageTitles ?? []
        self.positionPage = pagePosition!
        super.init(frame: frame)
        setUpUI()
        addTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpUI() {
        //创建scrollview
        scrollView = UIScrollView(frame: self.bounds)
        scrollView?.delegate = self
        scrollView?.isPagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.showsVerticalScrollIndicator = false
        self.addSubview(scrollView!)
        //创建3个imageView 用于显示轮播图片,图片依次设置好最后一个，第一个，第二个图片
        for a in 0 ..< 3 {
            let imageView = UIImageView()
            if images.count > 0 {
                 self.imageString(imageView:imageView, imageS: "\(images[(a + images.count-1)%images.count])")
            }
            imageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(actionClick))
            imageView.addGestureRecognizer(tap)
            scrollView?.addSubview(imageView)
            imageViews.append(imageView)
        }
        //创建分页控制标签
        pageControl = UIPageControl()
        self.addSubview(pageControl!)
        pageControl?.currentPage = 0
        pageControl?.pageIndicatorTintColor = pageIndicatorColor
        pageControl?.currentPageIndicatorTintColor = currentPageIndicatorColor
    }
    
    
    /// 添加timer
    fileprivate func addTimer() {
        timer = Timer(timeInterval: 2, repeats: true, block: { [weak self] _ in
            self?.nextImage()
        })
        guard let timer = timer else {
            return
        }
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    ///停止timer，将timer设置为nil才会销毁
    fileprivate func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    /// 下一个图片
    fileprivate func nextImage() {
        if pageControl?.currentPage == images.count - 1 {
            pageControl?.currentPage = 0
        } else {
            pageControl?.currentPage += 1
        }
        let contentOffset = CGPoint(x: self.frame.width*2 , y: 0)
        scrollView?.setContentOffset(contentOffset, animated: true)
    }
    
    /// 上一个图片
    fileprivate func preImage() {
        if pageControl?.currentPage == 0 {
            pageControl?.currentPage = images.count - 1
        } else {
            pageControl?.currentPage -= 1
        }
        let contentOffset = CGPoint(x: 0, y: 0)
        scrollView?.setContentOffset(contentOffset, animated: true)
    }
    
    /// 重新加载图片，设置3个imageView的图片
    fileprivate func reloadImage() {
        //通过pageControl当前选中的位置,获取当前轮播到哪一张图片
        let currentIndex = pageControl?.currentPage
        let nextIndex = (currentIndex! + 1) % images.count
        let preIndex = (currentIndex! + images.count-1) % images.count
        
        self.imageString(imageView: (scrollView?.subviews[0] as! UIImageView), imageS: "\(images[preIndex])")
        self.imageString(imageView:(scrollView?.subviews[1] as! UIImageView), imageS: "\(images[currentIndex!])")
        self.imageString(imageView: (scrollView?.subviews[2] as! UIImageView), imageS: "\(images[nextIndex])")
        
        if self.isShow! {
            if currentIndex! > imageTitles.count - 1 {
                imagetitleLabel?.text = ""
            }else{
                imagetitleLabel?.text = imageTitles[currentIndex!]
            }
        }
    }
    
    /// 代理方法
    @objc fileprivate func actionClick() {
        
        self.delegate?.ClickBanner(index: (pageControl?.currentPage)!)
        
    }
    
    
    /// 设置图片
    ///
    /// - Parameters:
    ///   - imageView: 要添加图片的ImageView
    ///   - imageS: image(本地图片或者url)
    fileprivate func imageString(imageView:UIImageView, imageS:String){
        
        var header : String?
        
        if  imageS.characters.count >= 4 {
            header = (imageS as NSString).substring(to: 4)
        }
        
        if header == "http" {

            imageView.kf.setImage(with: URL(string: "\(imageS)"), placeholder: UIImage(named: "placeholder")!, options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            
            imageView.image = UIImage(named: "\(imageS )") ?? UIImage(named: "placeholder")!
            
        }
    }
    
    
    fileprivate func setUIForImageTitle(){
        
        if self.isShow! {
            imageTitleView = UIView()
            imageTitleView?.frame = CGRect(x: 0, y: self.frame.height - 30, width: self.frame.width, height: 30)
            imageTitleView?.backgroundColor = .gray
            imageTitleView?.alpha = 0.6
            self.addSubview(imageTitleView!)
            imagetitleLabel = UILabel()
            imagetitleLabel?.tintColor = imageTitleColor
            self.addSubview(imagetitleLabel!)
        }
        
    }
   
    
    override func layoutSubviews() {
        scrollView?.contentSize = CGSize(width: CGFloat(Int(self.frame.width) * images.count), height: self.frame.height)
        scrollView?.contentOffset = CGPoint(x: self.frame.width, y: 0)
        var i = 0
        for imageView in imageViews {
            imageView.frame = CGRect(x: CGFloat(i*Int(self.frame.width)), y: 0, width: self.frame.width, height: self.frame.height)
            i = i+1
        }
        switch self.positionPage {
        case .center:
            pageControl?.frame = CGRect(x: 0, y: self.frame.height - 30, width: self.frame.width/3, height: 30)
            pageControl?.center.x = self.center.x
        case .left:
            pageControl?.frame = CGRect(x: 0, y: self.frame.height - 30, width: self.frame.width/3, height: 30)
             imagetitleLabel?.frame = CGRect(x: self.frame.width/3, y: self.frame.height - 30, width: self.frame.width*2/3, height: 30)
        case .right:
            pageControl?.frame = CGRect(x: self.frame.width/3*2, y: self.frame.height - 30, width: self.frame.width/3, height: 30)
            imagetitleLabel?.frame = CGRect(x: 0, y: self.frame.height - 30, width: self.frame.width*2/3, height: 30)
            
        }
       
    }

    
    
}

extension SirSlideshowView :UIScrollViewDelegate{
    
    /// 开始滑动的时候，停止timer，将timer设置为nil才会销毁
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    /// 当停止滚动的时候重新设置三个ImageView的内容，然后显示中间那个imageView
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        reloadImage()
        scrollView.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: false)
    }
    /// 停止拖拽，开始timer, 并且判断是显示上一个图片还是下一个图片
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
        if scrollView.contentOffset.x < self.frame.width {
            preImage()
        } else {
            nextImage()
        }
    }
}
