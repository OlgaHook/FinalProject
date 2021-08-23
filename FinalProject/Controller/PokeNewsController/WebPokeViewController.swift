//
//  WebPokeViewController.swift
//  FinalProject
//
//  Created by olga.krjuckova on 22/08/2021.
//

import UIKit
import WebKit

class WebPokeViewController: UIViewController,WKNavigationDelegate{

    
    var urlPokeString = String()
    
    @IBOutlet weak var webPokeView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Poke Web"
        
        guard let url = URL(string: urlPokeString) else {
            return
        }
        webPokeView.load(URLRequest(url: url))
    }
    //extrafunc to check
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Navigation starts")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print ("Navigation Stops")
    }
    

}
