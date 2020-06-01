//
//  RequestRouter.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import Foundation
import Alamofire

enum RequestRouter: String, URLConvertible {
    
    case homeUrl = "match"
    case gameListUrl = "game"
    
    // 基础连接地址
    static var baseURL: String {
        get {
            return "https://incpgameinfo.esportsworldlink.com/v2/"
        }
    }
    
    // 拼接URL
    var appendURL: String {
        get {
            return rawValue
        }
    }
    
    // 请求方法
    static let httpMethod: HTTPMethod = .post
    
    // 请求地址
    private func urlString() -> String {
        return RequestRouter.baseURL.appending(appendURL)
    }
    
    // 请求连接
    func asURL() throws -> URL {
        let url = URL(string: urlString())!
        return url
    }
}
