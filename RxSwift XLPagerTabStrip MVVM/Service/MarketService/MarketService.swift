//
//  MarketService.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

class MarketService: MarketServiceType {
    func getAllMarkets() -> Observable<[Market]> {
        return Observable.just([
            Market(name: "Market 1"),
            Market(name: "Market 2"),
            Market(name: "Market 3"),
            Market(name: "Market 4"),
            Market(name: "Market 5"),
            Market(name: "Market 6"),
            Market(name: "Market 7"),
            Market(name: "Market 8"),
            Market(name: "Market 9"),
            Market(name: "Market 10"),
            Market(name: "Market 11"),
            Market(name: "Market 12"),
            Market(name: "Market 13"),
            Market(name: "Market 14"),
            Market(name: "Market 15"),
        ])
    }
    
    func getLikedMarkets() -> Observable<[Market]> {
        return Observable.just([
            Market(name: "Market 1"),
            Market(name: "Market 2"),
            Market(name: "Market 5"),
            Market(name: "Market 6"),
            Market(name: "Market 7"),
            Market(name: "Market 12"),
            Market(name: "Market 13"),
            ])
    }
}
