//
//  HMHomeTableViewController.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/19.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
import YYModel
//重用标记
private let hmometableviewcell = "hmometableviewcell"

class HMHomeTableViewController: HMVistorTableViewController {

    //使用ViewModel对象
   fileprivate let statusListViewModel: HMStatusListVIewModel = HMStatusListVIewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置导航栏按钮
        if !isloging {
            visitorView?.updateVisitorInfo(text: nil, imgeName: nil)
        }else{
            loadData()
            setuptableViewUI()
        }
    }
    //搭建界面
    func setuptableViewUI() -> () {
        
        //注册
        tableView.register(HMHomeTableViewCell.self, forCellReuseIdentifier: hmometableviewcell)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        
    }
    //加载数据
    func loadData() {
        statusListViewModel.loadData { (issuccess) in
            if issuccess{
                self.tableView.reloadData()
            }

        }
        
    }
    
  //END
}




extension HMHomeTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusListViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: hmometableviewcell, for: indexPath) as! HMHomeTableViewCell
        let viewModel: HMStatsViewModel = statusListViewModel.statusList[indexPath.row]
        cell.statusViewModel = viewModel
        
        return cell
    }
    
    
}
