//
//  WebViewConroller.swift
//  WorldTrotter
//
//  Created by Yingqi Liu on 2/8/17.
//  Copyright © 2017 Tom Liu's Mac. All rights reserved.
//

import UIKit
import WebKit
class webViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.bignerdranch.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
