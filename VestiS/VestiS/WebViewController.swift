//
//  WebViewController.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 3/31/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    var urlString: String?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isConnected() {
            return
        }

        guard isConnected() else {
            return
        }

        // 1. version - Optional Binding.
        if let string = urlString {
            if let url = URL(string: string) {
                let request = URLRequest(url: url)
                webView.loadRequest(request)
            }
        }

        // 2. version - guard.
        guard let string = urlString else {
            return
        }

        guard let url = URL(string: string) else {
            return
        }

        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }

}

extension WebViewController: UIWebViewDelegate {

    // MARK: - UIWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}
