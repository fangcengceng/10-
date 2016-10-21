//
//  ViewController.swift
//  CarsListSwift
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
import YYModel

class ViewController: UITableViewController {

    var arrayList:[carstotal] = [carstotal]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

    
    }
    
    //加载cars_total.plist文件
    func loadData(){
        
        let path = Bundle.main.path(forResource: "cars_total.plist", ofType: nil)
        
        let array = NSArray(contentsOfFile: path!)
        print(array?.count)
        
//        let arr = NSArray.yy_modelArray(with: carstotal.self, json: array)
//        print(arr?.count)
        
        let tempArr = NSMutableArray()
        
        for dicarr in array! {
            let model = carstotal(dic: dicarr as! [String : Any])
            tempArr.add(model)
        }
      arrayList = tempArr as! [carstotal]
       print(arrayList.count)
        
        print("sss")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (arrayList.count)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return (arrayList[section].cars.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let detailArray:[carsDetail] = arrayList[indexPath.section].cars! as [carsDetail]
        
        
        cell.imageView?.image = UIImage(named:detailArray[indexPath.row].icon!)
        cell.textLabel?.text = detailArray[indexPath.row].name!
        return cell

    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return arrayList[section].title
    }
    
  
    

}

