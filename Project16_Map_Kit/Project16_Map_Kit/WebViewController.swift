//
//  WebViewController.swift
//  Project16_Map_Kit
//
//  Created by Ильдар Нигметзянов on 09.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var web: WKWebView!
    
    override func loadView() {
        web = WKWebView()
        self.view = web
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://yandex.ru/")!
        let request = URLRequest(url:url)
        web.load(request)
    }
}
