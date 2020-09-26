//
//  DetailViewController.swift
//  NewsReader
//
//  Created by 高田将弘 on 2020/09/20.
//  Copyright © 2020 高田将弘. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController : UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var link:String!
    
    override func viewDidLoad(){ // webビューに対象のWebサイトを表示する
        super.viewDidLoad()
        
        if let url = URL(string: self.link){
            let request = URLRequest(url: url) // requestインスタンスを作成
            self.webView.load(request) // requestに格納されたurlを表示する
        }
    }
}
