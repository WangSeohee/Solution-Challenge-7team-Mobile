//
//  RestAPI.swift
//  ppigcycle
//
//  Created by Jinhee on 2023/03/26.
//

import Foundation
import Combine

struct SignUp: Hashable, Codable {
    let id: String
    let password: String
    let checkePassword: String
    let nickname: String
    let date: String
}

struct Login: Hashable, Codable {
    // 로그인 성공 시 반환되는 값
}

struct Barcode: Hashable, Codable {
    let goods_name: String
    let how: String
    let method: String
}

class RestAPI: ObservableObject {
    static let shared = RestAPI()
    @Published var signup: [SignUp] = []
    @Published var login: [Login] = []
    @Published var loginsuccess: Bool = false
    @Published var date: String = "" //날짜
    @Published var posts: [Barcode] = []
    @Published var materialResponse: String = ""
    @Published var userid: Any = ""
    
    //MARK: 회원가입
    func Signup(parameters: [String: Any]) {
        guard let url = URL(string:
                                "http://ppigcycle.duckdns.org/users/new-user") else {
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let posts = try JSONDecoder().decode(String.self, from: data)
                DispatchQueue.main.async {
                    print(posts)
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    //MARK: 로그인
    func LoginSuccess(parameters: [String: Any],completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string:
                "http://ppigcycle.duckdns.org/login") else {
            return
        }
        
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        userid = parameters["id"]!
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
                
            }
            
            do {
                let posts = try JSONDecoder().decode(Login.self, from: data)
                DispatchQueue.main.async {
                    completion(true)
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    //MARK: 바코드 번호로 조회
    func fetch(parameters: [String : Any]) {
        let barcodeNumber = parameters["barcodeNumber"]!
        
        guard let url = URL(string:
                                "http://ppigcycle.duckdns.org/barcode/\(barcodeNumber)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let posts = try JSONDecoder().decode(Barcode.self, from: data)
                DispatchQueue.main.async { [self] in
                    self?.posts = [posts]
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    //MARK: 분리수거 날짜 조회
    func fetchDate(parameters: [String: Any]) {
        
        if let url = URL(string: "http://ppigcycle.duckdns.org/user/\(userid)/day") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error:", error)
                } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.date = responseString
                    }
                }
            }
            task.resume()
        }
    }
    
    //MARK: 분리수거 과정 조회
    func fetchMaterial(material: String) {
        if let url = URL(string: "http://ppigcycle.duckdns.org/recycle/\(material)") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error:", error)
                } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.materialResponse = responseString
                    }
                }
            }
            task.resume()
        }
    }
}
