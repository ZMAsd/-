//
//  HomeViewModel.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    @objc var successBlock: ((_ isHeader: Bool, _ noMoreData: Bool) -> ())?
    var currentPage: Int = 1 {
        didSet {
            if currentPage < 1 {
                currentPage = 1
            }
        }
    }
    var matchType: Int = 1
    convenience init(matchType: Int, success: @escaping ((_ isHeader: Bool, _ noMoreData: Bool) -> ())) {
        self.init()
        self.matchType = matchType
        self.successBlock = success
    }
    
    func numberOfSection() -> Int {
        return dataArray?.count ?? 0
    }
    
    var dataArray: [ZMSportData]?
    
    // 获取数据
    func fetchData() {
        currentPage = 1
        ZMAPI.HomeAPI.fetchHomeInfo(matchType: matchType, page: currentPage, success: {[unowned self] (response: ZMHomeSportData) in
            print("\(response)")
            self.dataArray = response.homeData
            
            if self.successBlock != nil {
                self.successBlock!(true, false)
            }
        }) { (error: APIError) in
            print("\(error)")
            if self.successBlock != nil {
                self.successBlock!(true, false)
            }
        }
    }
    
    func fetchMoreData() {
        currentPage += 1;
        ZMAPI.HomeAPI.fetchHomeInfo(matchType: matchType, page: currentPage, success: {[unowned self] (response: ZMHomeSportData) in
            print("\(response)")
            if (response.homeData?.count == 0) {
                if self.successBlock != nil {
                    self.successBlock!(false, true)
                }
            } else {
                self.dataArray?.append(contentsOf: response.homeData!)
                if self.successBlock != nil {
                    self.successBlock!(false, false)
                }
            }
        }) { (error: APIError) in
            print("\(error)")
            if self.successBlock != nil {
                self.successBlock!(false, false)
            }
        }
    }
}

extension HomeViewModel {
    
    
    
}

