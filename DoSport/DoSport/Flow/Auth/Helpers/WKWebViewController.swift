//
//  WKWebViewController.swift
//  DoSport
//
//  Created by Sergey on 12.03.2021.
//

import UIKit
import WebKit

final class WKWebViewController: UIViewController, WKNavigationDelegate {

    weak var webView: WKWebView?
    private let completion: () -> Void
//    let coordinator = AuthCoordinator(navController: navigationController)
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()

        let webView = WKWebView()
        self.view.addSubview(webView)
        
        self.webView = webView
        webView.navigationDelegate = self
        makeLoginRequest()
    }
        
    init(completion: @escaping() -> Void)  {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.webView?.frame = self.view.bounds
    }
    //MARK: - запрос на авторизацию

        func makeLoginRequest () {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "oauth.vk.com"
            urlComponents.path = "/authorize"
            urlComponents.queryItems = [
                URLQueryItem(name: "client_id", value: VKSession.shared.client_id),
                URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "scope", value: "8195,4194304"),
                URLQueryItem(name: "response_type", value: "token"),
                URLQueryItem(name: "v", value: "5.103"),
                URLQueryItem(name: "state", value: "test"),
                URLQueryItem(name: "revoke", value: "1")
            ]
            
            if let url = urlComponents.url {
                let request = URLRequest(url: url)
                self.webView?.load(request)
            }
        }
            func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
                
                if let url = navigationResponse.response.url, url.path == "/blank.html" {
                    
                    let urlString = url.absoluteString.replacingOccurrences(of: "https://oauth.vk.com/blank.html#", with: "https://oauth.vk.com/blank.html?")
                    
                    let urlComponents: URLComponents? = URLComponents(string: urlString)
                    if let items = urlComponents?.queryItems {
                        for item: URLQueryItem in items {
                            if item.name == "access_token" {
                                if item.value != nil {
                                    VKSession.shared.tokenID = item.value
                                }
                                print("TOKEN IS \(VKSession.shared.tokenID!)")

                            }
                            if item.name == "user_id" {
                                if item.value != nil {
                                    VKSession.shared.userName = item.value
                                    print("user_id is \( String(describing: VKSession.shared.userName!))")
                                }
                            }
                            if item.name == "email" {
                                if item.value != nil {
                                    VKSession.shared.email = item.value
                                    print("email is \( String(describing: VKSession.shared.email!))")
                                }
                            }
                        }
                    }
                    completion()
                }
                decisionHandler(.allow)
            }
    
    //MARK: - запрос на имя, фамилию и id пользователя
        func getInfo() {
            
        }
}
