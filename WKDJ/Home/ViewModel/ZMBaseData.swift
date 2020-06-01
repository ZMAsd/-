//
//  ZMBaseData.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import HandyJSON

enum ResponseCode: Int, HandyJSONEnum {
    case success = 200
    case fail = -1
    case requestRedirector = 301
    case requestError = 400
    case needToLogin = 401
    case notFound = 405
    case serverError = 500
}

class ZMBaseData: HandyJSON {
    
    var code: ResponseCode = .fail
    var message: String = "Request something error"
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            [
                self.code  <-- "code"
            ]
    }
}
