//
//  ZMGameListInfo.swift
//  WKDJ
//
//  Created by admin on 2020/5/31.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import HandyJSON

class ZMGameListInfo: ZMBaseData {
    
    var gameList: [ZMGameDetailInfo]?
    
    required init() {
        
    }
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<<
            [
                self.gameList <-- "result"
            ]
    }
    
}


class ZMGameDetailInfo: HandyJSON {
    var id: Int = 0
    var name: String?
    var shortName: String?
    var logo: String?
    var url: String?
    var early: String?
    var live: String?
    var today: String?
    var outright: String?
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            [
                self.id <-- "id",
                self.name <-- "name",
                self.shortName <-- "short_name",
                self.logo <-- "logo",
                self.url <-- "url",
                self.early <-- "early",
                self.live <-- "live",
                self.today <-- "today",
                self.outright <-- "outright"
            ]
    }
}
