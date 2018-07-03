//
//  APIRequest.swift
//  Music-Driven-Workout-App
//
//  Created by Lucy Newman on 2/28/18.
//  Copyright © 2018 UChicago SoftCon. All rights reserved.
//

import UIKit

class APIRequest: NSObject {
    
    func comp(data: Data?, response: URLResponse?, error: Error?) -> Void {
        return
    }
    
    func parseJsonInitial(data: Data) -> String? {
        var res: Dictionary<String, String>
        do {
            res = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, String>
            let myDict = res
            if let result = myDict["Result"] {
                return result
                /*
                var reply: [Dictionary<String, Any>]
                
                if let resultData = result.data(using: String.Encoding.utf8) {
                    do {
                        reply = try JSONSerialization.jsonObject(with: resultData, options: []) as! [Dictionary<String, Any>]
                        let myReplyDict = reply
                        return myReplyDict
                    }
                } */
  
            }
            
        } catch let error{
            print(error)
        }
        return nil
    }
    
    func parseJsonDictList(data: Data) -> [[String:Any]]? {
        var res: [[String:Any]]
        do {
            res = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
            let myDict = res
            return myDict
            
        } catch let error {
            print(error)
        }
        return nil
        
    }
    
    func parseJsonRespone(data: Data) -> [Dictionary<String, Any>]? {
        if let result = parseJsonInitial(data: data) {
            var reply: [Dictionary<String, Any>]
            
            if let resultData = result.data(using: String.Encoding.utf8) {
                do {
                    reply = try JSONSerialization.jsonObject(with: resultData, options: []) as! [Dictionary<String, Any>]
                    let myReplyDict = reply
                    return myReplyDict
                } catch let error {
                    print(error)
                }
            }
        }
        return nil
    }
    
    func parseJsonResponeSinglet(data: Data) -> Dictionary<String, Any>? {
        if let result = parseJsonInitial(data: data) {
            var reply: Dictionary<String, Any>
            
            if let resultData = result.data(using: String.Encoding.utf8) {
                do {
                    reply = try JSONSerialization.jsonObject(with: resultData, options: []) as! Dictionary<String, Any>
                    let myReplyDict = reply
                    return myReplyDict
                } catch let error {
                    print(error)
                }
            }
        }
        return nil
    }

    
    func submitPostLocal(route: String, qstring: String, completion: @escaping (Data?, URLResponse?,Error?) -> Void) -> URLSessionDataTask {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "127.0.0.1"
        urlComponents.port = 5000
        urlComponents.path = route
        urlComponents.query = qstring
        guard let url = urlComponents.url else {
            fatalError("Could not create URL")
        }
        print("url ", url, "\n")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = qstring
        request.httpBody = postString.data(using: String.Encoding.utf8)
        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data", "\n")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) {(data, response, responseError) in
            if let data = data {
                completion(data, response, responseError)
            }
        }
        return task
    }

    func submitPostServer(route: String, qstring: String, completion: @escaping (Data?, URLResponse?,Error?) -> Void) -> URLSessionDataTask {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "138.197.49.155"
        urlComponents.port = 8000
        urlComponents.path = route
        urlComponents.query = qstring
        guard let url = urlComponents.url else {
            fatalError("Could not create URL")
        }
        print("url: ", url, "\n")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = qstring
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) {(data, response, responseError) in
            if let data = data {
                completion(data, response, responseError)
            }
        }
        return task
    }
    
}
