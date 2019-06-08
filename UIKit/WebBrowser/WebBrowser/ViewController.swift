//
//  ViewController.swift
//  WebBrowser
//
//  Created by Vlad Tagunkov on 08/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextField.delegate = self
        webView.navigationDelegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        let homePage = "https://apple.com"
        let url = URL(string: "https://apple.com")
        let request = URLRequest(url: url!)
        urlTextField.text = homePage
        
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
    }

    @IBAction func backButtonAction(_ sender: Any) {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonAction(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
}
extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        webView.load(request)
        textField.resignFirstResponder()
        return true
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    
}
