//
//  HMOriginalView.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
import SDWebImage

class HMOriginalView: UIView {

    //给原创微博里面的子控件绑定数据
    var statusViewModel:HMStatsViewModel?{
        didSet{
            screeLabel.text = statusViewModel?.status?.user?.screen_name
            if let profileImgUrl = statusViewModel?.status?.user?.profile_image_url{
                profileView.sd_setImage(with: URL(string:profileImgUrl), placeholderImage: UIImage(named:"avatar_default_big"))
            }
            timeLabel.text = statusViewModel?.status?.created_at
            contentLabel.text = statusViewModel?.status?.text
            sourcelabel.text = statusViewModel?.status?.source
            mbrankView.image = statusViewModel?.mbrankImage
        }
    }
    
    //用户昵称
    private lazy var screeLabel: UILabel = {
        let namelable = UILabel(fontsize: 14, textclor: UIColor.orange)
        namelable.text = "无限挑战"
        namelable.numberOfLines = 0
        return namelable
        
    }()
    
    //  时间
    private lazy var timeLabel: UILabel = {
      let lable = UILabel(fontsize: 11, textclor: UIColor.lightGray)
        lable.text = "刚刚"
        return lable
    }()
    //微博来源标签
    private lazy var sourcelabel: UILabel = {
        let label = UILabel(fontsize: 11, textclor:UIColor.lightGray)
        label.text = "来自网页"
        return label
    }()
    
    //微博内容
    private lazy var contentLabel: UILabel = {
        let label = UILabel(fontsize: 17, textclor: UIColor.darkGray)
        label.numberOfLines = 0
        label.text = "ksdjfkalsdjfkasjdfo;laskjdfl;askdjf"
        return label
    }()
    
    
    //用户头像
    private lazy var profileView: UIImageView = {
        let imagv = UIImageView(image: UIImage(named: "avatar_default_big"))
        return imagv
        
    }()
    //认证等级图片
    private lazy var verifiedView: UIImageView = {
        let view =  UIImageView(image: UIImage(named: "avatar_vip"))
        return view
        
    }()
    //会员等级图片
    private lazy var mbrankView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "common_icon_membership"))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func  setupUI() -> () {
        //添加控件
        addSubview(screeLabel)
        addSubview(timeLabel)
        addSubview(sourcelabel)
        addSubview(contentLabel)
        addSubview(profileView)
        addSubview(verifiedView)
        addSubview(mbrankView)
        
        //头像约束
        profileView.snp_makeConstraints { (make) in
         make.top.equalTo(self.snp_top).offset(childViewMargin)
            make.left.equalTo(self).offset(childViewMargin)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        //认证等级约束
        verifiedView.snp_makeConstraints { (make) in
            make.centerX.equalTo(profileView.snp_trailing)
            make.centerY.equalTo(profileView.snp_bottom)
  
        }
        //昵称约束
        screeLabel.snp_makeConstraints { (make) in
            make.top.equalTo(profileView)
            make.leading.equalTo(profileView.snp_trailing).offset(childViewMargin)
        }
        
        //会员等级认证
        mbrankView.snp_makeConstraints { (make) in
            make.top.equalTo(screeLabel)
      make.leading.equalTo(screeLabel.snp_trailing).offset(2*childViewMargin)
            
        }
        //时间约束
        timeLabel.snp_makeConstraints { (make) in
            make.leading.equalTo(screeLabel)
            make.top.equalTo(screeLabel.snp_bottom).offset(childViewMargin)
            
        }
        //来源约束
        sourcelabel.snp_makeConstraints { (make) in
            make.top.equalTo(timeLabel)
        make.leading.equalTo(timeLabel.snp_trailing).offset(childViewMargin)
        }
        //内容约束
        contentLabel.snp_makeConstraints { (make) in
            make.top.equalTo(profileView.snp_bottom).offset(childViewMargin)
            make.leading.equalTo(profileView)
          make.width.equalTo(screenWidth - 2 * childViewMargin)
        }

        //关键约束
        self.snp_makeConstraints { (make) in
            make.bottom.equalTo(contentLabel.snp_bottom).offset(childViewMargin)
        }
        
    }
}
