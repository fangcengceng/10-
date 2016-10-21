//
//  SwiftController.swift
//  咻一咻
//
//  Created by codygao on 16/10/8.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit


class SwiftController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func touches(){
        
       let redView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        redView.backgroundColor = .blue
        view.addSubview(redView)
        
        UIView.animate(withDuration: 3) { 
            redView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
        }
        
    }
    


}
