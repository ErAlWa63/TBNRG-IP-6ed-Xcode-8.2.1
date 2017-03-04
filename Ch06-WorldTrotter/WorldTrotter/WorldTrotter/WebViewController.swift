//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Erik Waterham on 2/28/17.
//  Copyright © 2017 Erik Waterham. All rights reserved.
//

//import Foundation
import UIKit
import WebKit
class WebViewController: UIViewController {
    var webView: WKWebView!
    
    override func loadView()
    {
        super.loadView()
        
        webView = WKWebView ()
        view = webView
        let url = NSURL (string: "https://www.bignerdranch.com")
        let request = NSURLRequest (url: url! as URL)
        webView.load (request as URLRequest)
        print ("Loaded request")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("WebViewController loaded its view")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
