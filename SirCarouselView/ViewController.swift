//
//  ViewController.swift
//  SirCarouselView
//
//  Created by Sirius on 2017/7/21.
//  Copyright © 2017年 com.Sirius.app. All rights reserved.
//

import UIKit

class ViewController: UIViewController,SirSlideshowViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
//        let bannerView = SirSlideshowView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200), images: nil, pagePosition: .right)
        let bannerView = SirSlideshowView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        bannerView.isShowImageTitle = true
        bannerView.pagePosition = .right
        bannerView.delegate = self
        bannerView.images = ["test1","test2","http://img.ph.126.net/ocT0cPlMSiTs2BgbZ8bHFw==/631348372762626203.jpg"]
        bannerView.imageTitles = ["起舞飞扬","圣诞快乐","Love"]
        bannerView.imageTitleColor = .red
        bannerView.pageIndicatorColor = UIColor.red
        bannerView.scrollInterval = 10.0
        self.view.addSubview(bannerView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func ClickBanner(index:Int) {
        let test = TestViewController()
        test.title = "Banner\(index)详情"
        self.navigationController?.pushViewController(test, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

