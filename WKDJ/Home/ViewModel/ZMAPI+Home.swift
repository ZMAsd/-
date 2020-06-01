//
//  ZMAPI+Home.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import Foundation

extension ZMAPI {
    
    class HomeAPI {
        
        
        static func fetchHomeInfo(matchType: Int = 2, page: Int = 1, success: ((ZMHomeSportData) -> ())? = nil, failed: APIFailedBlock? = nil) {
            
            let parameter: [String : Any] = [
                "match_type" : String(matchType),
                "page" : String(page)
            ]
            
            _ = ZMAPI.getData(from: .homeUrl, method: .get, parameters: parameter, returnType: ZMHomeSportData.self).subscribe(onNext: { (response) in
                
                if let success = success {
                    let dateFormater = DateFormatter()
                    dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    // 当前时间
                    let currentTime = Date.init().timeIntervalSince1970
                    for homeData in response.homeData! {
                        let dateTime = dateFormater.date(from: homeData.startTime!)
                        let startTime = dateTime?.timeIntervalSince1970
                        if Int(currentTime) > Int(startTime!) {
                            homeData.isMaxThanCurrent = false
                        } else {
                            homeData.isMaxThanCurrent = true
                        }
                    }
                    success(response)
                }
            }, onError: { (error: Error) in
                if let failed = failed {
                    if let error = error as? APIError {
                        failed(error)
                    }
                }
            })
        }
    }
    
    class GameListAPI {
        static func fetchGameList(success: (([ZMGameDetailInfo]?) -> ())? = nil, failed: APIFailedBlock? = nil) {
            _ = ZMAPI.getData(from: .gameListUrl, method: .get, parameters: nil, returnType: ZMGameListInfo.self).subscribe(onNext: { (response: ZMGameListInfo) in
                if let success = success {
                    success(response.gameList)
                }
            }, onError: { (error: Error) in
                if let failed = failed {
                    if let error = error as? APIError {
                        failed(error)
                    }
                }
            })
        }
    }
}
