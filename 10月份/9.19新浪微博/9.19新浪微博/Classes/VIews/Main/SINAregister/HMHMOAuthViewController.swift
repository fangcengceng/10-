//
//  HMHMOAuthViewController.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/21.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
import SVProgressHUD

let WeiboAppkey = "2549835660"
let WeiboAppSecret = "073e01ac02e4f7e3115e1a5dbc330e08"
let WeiboRedirect_uri = "http://www.itcast.cn"

class HMHMOAuthViewController: UIViewController {
    lazy var webView: UIWebView = UIWebView()
    
    override func loadView() {
        view = webView
        webView.isOpaque = false
        webView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupRegister()
    }
    
    //设置导航栏
    func setupNav() -> () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动注册", target: self, action: #selector(fillAutoAction))
    
    }
    
    //取消
   @objc private func cancelAction() {
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
        
    }
    //自动填充
   @objc private func fillAutoAction(){

        webView.stringByEvaluatingJavaScript(from: "document.getElementById('userId').value = '13140103066';document.getElementById('passwd').value = 'fcc19870916'")
        
    }
    
  
    //注册
    func setupRegister()  {
        
        let url = "https://api.weibo.com/oauth2/authorize?client_id=\(WeiboAppkey)&redirect_uri=\(WeiboRedirect_uri)"
        let urlrequest = URLRequest(url: URL(string: url)!)
        webView.loadRequest(urlrequest)
    }
}

//以扩展方式获取授权
extension HMHMOAuthViewController:UIWebViewDelegate{
    //开始加载
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
        
    }
    
    //加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    //加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
        
    }
    //将要加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //获取url
        guard let url = request.url else{
            
            return false
        }
        
        if !url.absoluteString.hasPrefix(WeiboRedirect_uri) {
            print(url)
            return true
        }
        //代码执行到此 是我们想要的url
        if let query = url.query, query.hasPrefix("code="){
            // 截取code
            let code = query.substring(from :"code=".endIndex)
            print(code)
            
            //通过code获取accessTocken
            HMHMUseraccountViewModel.shareduserAccountViewModel.requeseAccessToken(code: code, callback: { (issucesse) in
                if issucesse {
                    print("登陆成功")
                    //进入欢迎界面,要等到dissmiss完成以后再发送跟控制更改的通知
                    self.dismiss(animated: false, completion: { 
                         NotificationCenter.default.post(name: NSNotification.Name(switchRootVCNotification), object: self)
                    })
                    
                   
                }
            })
        }else{
            //取消授权
            self.dismiss(animated: true, completion: nil)
        }
       
        
        
        //拿到code 之后，我们不需要关心返回页，所以不用return true
        return false
        
    }
    
}

