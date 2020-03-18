//
//  APIManager.swift
//  PayDay Bank
//
//  Created by admin on 18.03.2020.
//  Copyright © 2020 Tecman. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    static let shared = APIManager()
    
    static let baseUrl = "http://localhost:3000"
    
    private func nilHandler(data:Any?) {
        return
    }
    
    public func authorize(login: String, password: String, handler:@escaping (Any?)->()) {
        let json: [String:Any] = [
            "email": login,
            "password": password
        ]
        getRequest(methodUrl: "authenticate", httpMethod: "POST", jsonBody: json, handler: handler)
    }
    
    public func getAccounts(handler:@escaping (Any?)->()) {
        getRequest(methodUrl: "accounts", httpMethod: "GET", jsonBody: nil, handler: handler)
    }
    
    public func getTransaction(handler:@escaping (Any?)->()) {
        getRequest(methodUrl: "transactions", httpMethod: "GET", jsonBody: nil, handler: handler)
    }

        
    private func getRequest(methodUrl: String, httpMethod: String = "GET", jsonBody: [String:Any]? = nil, handler:@escaping (Any?)->()) {
        let url = URL(string: "\(APIManager.baseUrl)/\(methodUrl)")
        var request = URLRequest(url: url!)
        request.timeoutInterval = 10
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if (jsonBody != nil) {
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody!)
            request.httpBody = jsonData
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                
//                DispatchQueue.main.sync {
//                    var topController = UIApplication.shared.keyWindow?.rootViewController
//                    while let presentedViewController = topController!.presentedViewController {
//                        topController = presentedViewController
//                    }
//                    var title = ""
//                    switch error?.localizedDescription {
//                    case "The Internet connection appears to be offline.":
//                        title = "Отсутсвует интернет соединение"
//                    case "Could not connect to the server.":
//                        title = "Сервер не доступен"
//                    default:
//                        title = "Неизвестная ошибка"
//                    }
//                    let storyboard = UIStoryboard.init(name: "Reusable", bundle: nil)
//                    let controller = storyboard.instantiateViewController(withIdentifier: "connectionProblemsView") as! ConnectionProblemsController
//                    controller.problemDescriptionText = title
//                    topController!.present(controller, animated: true)
//                }
                return handler(nil)
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let resp = responseJSON as? [String: Any?] {
//                if let name = resp["name"] as? String {
//                    if name == "Unauthorized" {
//                        DispatchQueue.main.sync {
//                            var topController = UIApplication.shared.keyWindow?.rootViewController
//                            while let presentedViewController = topController!.presentedViewController {
//                                topController = presentedViewController
//                            }
//                            let alert = UIAlertController(title: "Похоже что логин и/или пароль изменились", message: "Необходимо заново авторизоваться используя новые логин и пароль", preferredStyle: .alert)
//                            alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { action in
//                                Utilities.shared.resetApp(caller: topController!)
//                             }))
//                            topController!.present(alert, animated: true)
//                        }
//                    }
//                }
            }
            
            return handler(responseJSON)
        }
        task.resume()
    }
}
