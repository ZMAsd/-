//
//  ZMHomeSportData.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import HandyJSON

class ZMHomeSportData: ZMBaseData {
    
    required init() {
        
    }

    var homeData: [ZMSportData]?
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<<
            [
                self.homeData <-- "result",
            ]
    }
}

class ZMSportData: HandyJSON {
    required init() {
        
    }
    
    var gameId: Int = 0
    var tournamentId: Int = 0
    var status: Int = 0
    var id: Int = 0
    var enableParlay: Int = 0
    var gameName: String?
    var matchName: String?
    var matchShortName: String?
    var startTime: String?
    var endTime: String?
    var round: String?
    var tournamentName: String?
    var tournamentShortName: String?
    var team: [ZMSportTeam]?
    var isMaxThanCurrent: Bool = false
    var stateText: String = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            [
                self.gameId <-- "game_id",
                self.tournamentId <-- "tournament_id",
                self.status <-- "status",
                self.id <-- "id",
                self.enableParlay <-- "enable_parlay",
                self.gameName <-- "game_name",
                self.matchName <-- "match_name",
                self.matchShortName <-- "match_short_name",
                self.startTime <-- "start_time",
                self.endTime <-- "end_time",
                self.round <-- "round",
                self.tournamentName <-- "tournament_name",
                self.tournamentShortName <-- "tournament_short_name",
                self.team <-- "team"
            ]
    }
    
    
}

class ZMSportTeam: HandyJSON {
    required init() {
        
    }
    
    var teamId: Int = 0
    var teamLogo: String? = nil
    var teamName: String?
    var teamShortName: String?
    var pos: Int = 0
    var id: Int = 0
    var matchId: Int = 0
    var score: ZMTeamScore?
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            [
                self.teamId <-- "team_id",
                self.teamLogo <-- "team_logo",
                self.teamName <-- "team_name",
                self.teamShortName <-- "team_short_name",
                self.pos <-- "pos",
                self.id <-- "id",
                self.matchId <-- "match_id",
                self.score <-- "score"
            ]
    }
    
}

class ZMTeamScore: HandyJSON {
    required init() {
        
    }
    
    var r1: Int = 0
    var r2: Int = 0
    var r3: Int = 0
    var r4: Int = 0
    var r5: Int = 0
    var r6: Int = 0
    var r7: Int = 0
    var total: Int = 0
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            [
                self.r1 <-- "r1",
                self.r2 <-- "r2",
                self.r3 <-- "r3",
                self.r4 <-- "r4",
                self.r5 <-- "r5",
                self.r6 <-- "r6",
                self.r7 <-- "r7",
                self.total <-- "total"
            ]
    }
}
