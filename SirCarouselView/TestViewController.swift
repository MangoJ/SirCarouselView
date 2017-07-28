//
//  TestViewController.swift
//  SirCarouselView
//
//  Created by Sirius on 2017/7/24.
//  Copyright © 2017年 com.Sirius.app. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var titleS : String? = ""{
        didSet{
            self.title = titleS
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
