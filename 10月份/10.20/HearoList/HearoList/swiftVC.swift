//
//  swiftVC.swift
//  HearoList
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
var arrylist:[String: Any]?


class swiftVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

      
        
    }

    func loaddata() {
        let vc = ViewController()
        arraylist? = vc.loadData
        
    }

   
}
