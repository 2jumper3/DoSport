//
//  WKWebViewController.swift
//  DoSport
//
//  Created by Sergey on 12.03.2021.
//

import UIKit
import WebKit
import Alamofire

//MARK: - WebView для авторизации пользователя

class WKWebViewController: UIViewController, WKNavigationDelegate {

    weak var webView: WKWebView?
    weak var coordinator: MainCoordinator?

    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()

        let webView = WKWebView()
        self.view.addSubview(webView)
        
        self.webView = webView
        webView.navigationDelegate = self
        makeLoginRequest()
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
                URLQueryItem(name: "client_id", value: Session.shared.client_id),
                URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "scope", value: "8195"),
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
                                    Session.shared.tokenID = item.value
                                }
                                print("TOKEN IS \(Session.shared.tokenID!)")

                            }
                            if item.name == "user_id" {
                                if item.value != nil {
                                    Session.shared.userName = item.value
                                    print("user_id is \( String(describing: Session.shared.userName!))")
                                }
                            }
                        }
                    }
                    self.navigationController?.popViewController(animated: true)

                    self.webView?.removeFromSuperview()
                    
                    getInfo()
                }
                decisionHandler(.allow)
            }
    
    //MARK: - запрос на имя, фамилию и id пользователя
        func getInfo() {
            let urlString = "https://api.vk.com/method/users.get?user_id=\(String(Session.shared.userName!))&v=5.52&access_token=\(String(describing: Session.shared.tokenID!))"
            Alamofire.request(urlString, method: .get).validate().responseJSON { (response) in
                print("response is \(response)")
                switch response.result {
                case .success (let value):
                    let json = JSON(value)
                    let first_name = json["response"][0]["first_name"].stringValue
                    let last_name = json["response"][0]["last_name"].stringValue
                    let id = json["response"][0]["id"].intValue
                    let test = RealmDataModel()
                    test.first_name = first_name
                    test.last_name = last_name
                    test.id = id
                    test.email = ""
                    
                    try! self.realm.write {
                        self.realm.add(test)
                    }
    //                print("realmmm !!!!! \(self.realm.configuration.fileURL)")
                case .failure (let error):
                    print(error)
                }
            }
        }

    }

