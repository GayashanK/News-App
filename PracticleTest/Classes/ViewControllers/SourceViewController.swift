//
//  SourceViewController.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/13/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import UIKit

class SourceViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isInternetAvailable() {
            if let url = URL(string: url) {
                let request = URLRequest(url: url as URL)
                webView.loadRequest(request)
            }
        } else {
            activityIndicator.stopAnimating()
            Utils.instance.showAlert(title: nil, message: ValidationHelper.instance.getErrorMessage(errorCode: respond.noInternet.rawValue), viewController: self, handler: nil)
        }
        
        
    }

}

extension SourceViewController: UIWebViewDelegate{

    func webViewDidStartLoad(_ webView: UIWebView){
        activityIndicator.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityIndicator.stopAnimating()
        Utils.instance.showAlert(title: nil, message: error as! String, viewController: self, handler: nil)
    }
}
