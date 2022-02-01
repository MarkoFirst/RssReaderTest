//
//  WebViewVC.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Foundation
import UIKit
import TinyConstraints
import WebKit

class WebViewVC: ViewController {
    fileprivate var webView: WKWebView!
    fileprivate var url: URL!
    
    init(_ url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        view.addSubview(webView)
        
        webView.edgesToSuperview()
        
        webView.load(URLRequest(url: url))
    }
}
