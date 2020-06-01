//
//  ZMAPI.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import RxCocoa
import RxSwift

enum APIError: Error {
    // 请求锁雾服务器返回
    case error(wrong: String)
    
    case dataJson(wrong: String)
    
    case dataEmpty(wrong: String)
    
    case dataMatch(wrong: String)
    
    case network(wrong: String)
    
    static func networkWrong(error: NSError) -> APIError {
        print("Networking_API_error:\n\(error)\n")
        if let errorMsg = error.userInfo["NSLocalizedDescription"] as? String {
            return APIError.network(wrong: errorMsg)
        }
        
        if error.domain == "Alamofire.AFError" {
            if error.code == 4 {
                return APIError.dataEmpty(wrong: "Server return data is nil or zero lenght.")
            }
        }
        return APIError.network(wrong: "Unknown Netwworking Wrong.")
    }
}

extension APIError {
    var errorMsg: String {
        get {
            switch self {
            case .error(let wrong):
                return wrong
            case .dataJson(let wrong):
                return wrong
            case .dataEmpty(let wrong):
                return wrong
            case .dataMatch(let wrong):
                return wrong
            case .network(let wrong):
                return wrong
            }
        }
    }
}

typealias APIFailedBlock = (APIError) -> ()


class ZMAPI {
    
    // 请求缓存策略
    static func initial() {
        Alamofire.Session.default.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    }
    
    fileprivate class func request<T: HandyJSON>(_ url: RequestRouter, method: HTTPMethod = .post, parameters: Parameters?, returnType: T.Type) -> Observable<T> {
        
        return Observable.create { (observer) -> Disposable in
            requestData(observer: observer, url: url, method: method, parameters: parameters, returnType: returnType)
            return Disposables.create {}
        }
    }
 
    // AnyObserver RXSwift
    fileprivate class func requestData<T: HandyJSON>(observer: AnyObserver<T>, url: RequestRouter, method: HTTPMethod = .post, parameters: Parameters?, returnType: T.Type) {
        
        // 清空缓存
        URLCache.shared.removeAllCachedResponses()
        
        // 设置请求序列化 
        var encoding: ParameterEncoder = JSONParameterEncoder.default
        if method == .get {
            encoding = URLEncodedFormParameterEncoder.default
        }
        
        var dic = [String : String]()
        if let parameters = parameters {
            for (key, value) in parameters {
                if let reBaseValue = value as? String {
                    dic[key] = reBaseValue
                }
            }
        }
        
        Alamofire.AF.request(url, method: method, parameters: dic, encoder: encoding, headers: headers, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                successHandel(observer: observer, response: response, returnType: returnType)
                break
            case .failure(let error):
                observer.onError(APIError.networkWrong(error: error as NSError))
                observer.onCompleted()
                break
            }
        }
    }
    
    static var headers: HTTPHeaders {
        get {
            let contentType = "application/json"
            let result: [String : String] = ["Content-Type" : contentType]
            let headers = HTTPHeaders.init(result)
            return headers
        }
    }
}


extension ZMAPI {
    fileprivate class func successHandel<T: HandyJSON>(observer: AnyObserver<T>, response: AFDataResponse<Any>, returnType: T.Type) {
        
        guard let json = response.value, let jsonDic = json as? Dictionary<String, AnyObject> else {
            observer.onError(APIError.dataJson(wrong: "Server Data is not JSON!"))
            observer.onCompleted()
            return
        }
        
        guard let responseModel = returnType.deserialize(from: NSDictionary(dictionary: jsonDic)) else {
            observer.onError(APIError.dataMatch(wrong: "Data match wrong!"))
            observer.onCompleted()
            return
        }
        
        observer.onNext(responseModel)
        observer.onCompleted()
    }
}

extension ZMAPI {
    class func getData<T: ZMBaseData>(from url: RequestRouter, method: HTTPMethod = .post, parameters: Parameters?, returnType: T.Type) -> Observable<T> {
        return Observable<T>.create { (observer: AnyObserver<T>) -> Disposable in
            
            let disposable = self.request(url, method: method, parameters: parameters, returnType: returnType).subscribe(onNext: { (data: T) in
                
                // 处理类似登录操作的统一接口 缓存数据等
                if data.code == .success {
                    observer.onNext(data)
                } else {
                    if data.code == .needToLogin {
                        // 重新登录
                    }
                    let apiError = APIError.error(wrong: data.message)
                    observer.onError(apiError)
                }
            }, onError: { (error: Error) in
                
                if let apiError = error as? APIError {
                    observer.onError(apiError)
                    observer.onCompleted()
                }
            })
            
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}
