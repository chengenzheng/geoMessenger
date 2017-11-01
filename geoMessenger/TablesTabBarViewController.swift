//
//  TablesTabBarViewController.swift
//  geoMessenger
//
//  Created by chengen Zheng on 2017/10/29.
//  Copyright © 2017年 chengen Zheng. All rights reserved.
//

import UIKit

class TablesTabBarViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.barTintColor = UIColor(red:0.70, green:0.97, blue:0.91, alpha:1.0)
    }

}
