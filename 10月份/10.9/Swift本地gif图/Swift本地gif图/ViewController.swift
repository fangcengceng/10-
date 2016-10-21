//
//  ViewController.swift
//  Swift本地gif图
//
//  Created by codygao on 16/10/9.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //记录plist加载出来的数组
    var arrayList: [FCCpicture] = [FCCpicture]()
    var indexPath: Int = 0
    
    //下一张button
    private lazy var nextButton: UIButton = {
         let button = UIButton()

        button.setTitle("下一张", for: .normal)
        
        button.frame = CGRect(x: 0, y: 20, width: 100, height: 40)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(nextButttonAction(btn:)), for: .touchUpInside)
      return button
    
    }()
    //上一张button
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.setTitle("上一张", for: .normal)
        button.setTitleColor(.black, for: .normal)

        button.frame = CGRect(x: 250, y: 20, width: 100, height: 40)
        button.addTarget(self, action: #selector(previousButttonAction(btn:)), for: .touchUpInside)
        return button
        
    }()
    //索引标签
    private lazy var indexLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 150, y: 20, width: 100, height: 40))
        label.text = "1 / 10"
        label.textColor = .black
        return label
    }()
    
    //描述标签
    private lazy var descLabel: UILabel = {
       let label = UILabel(frame: CGRect(x: 20, y: 450, width: 300, height: 100))
        label.textColor = .black
        label.text = "sedfjdjf;sd"
        return label
    }()

    //gif动画视图
    private lazy var gifView: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 110, width: 300, height: 300)
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //添加子控件
       view.addSubview(previousButton)
        view.addSubview(indexLabel)
        view.addSubview(nextButton)
        view.addSubview(descLabel)
        view.addSubview(gifView)
        
        
        //加载数据
        indexPath = 0

        loadData()
        setupUI()
    
        
    }
//填充子控件
    func setupUI()  {
        loadImage(count: Int(arrayList[indexPath].count), prename: arrayList[indexPath].icon!)
        
        
        descLabel.text = arrayList[indexPath].desc
        
        indexLabel.text = (indexPath).description + "/" + arrayList.count.description
    }
    
    func loadData() {
        //获取plist路径方法一
        let path = Bundle.main.path(forResource: "images.plist", ofType: nil)
        
        let patharray = NSArray(contentsOfFile: path!)
        print(patharray?.count)
        
//        //加载plist路径方法二
//        let url = Bundle.main.url(forResource: "images.plist", withExtension: nil)
//        let urlPath = NSArray(contentsOf: url!)
        
        //字典转模型
        
        var tempArray = [FCCpicture]()
        for dic in patharray as! [[String:Any]] {
            let model = FCCpicture(dic: dic)
            tempArray.append(model)
        }
        
        arrayList = tempArray

        
    }
    
    //加载本地图片
    func loadImage(count: Int,prename: String) {
        
        var tempArr = [UIImage]()
        for i in 0..<count - 1 {
           
            
            //加载图片路径
            let str = prename + String(format: "%03zd", i)
            
            
            let path = Bundle.main.path(forResource: str, ofType: "png")
            
            
            //滚局图片路径生成加载图片
            let image = UIImage(contentsOfFile: path!)
            
            
            tempArr.append(image!)
            let timer = CGFloat(count) * 0.1
            gifView.image = UIImage.animatedImage(with: tempArr, duration: TimeInterval(timer))
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    func nextButttonAction(btn: UIButton)  {
        btn.isEnabled = (indexPath != arrayList.count - 1)
         setupUI()
        indexPath += 1
        
        
    }

    func previousButttonAction(btn: UIButton)  {
          indexPath -= 1
        btn.isEnabled = indexPath != 0
        setupUI()
      

    }
    
    
    
    
    
}

