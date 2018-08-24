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
            Market(title: "Market 1"),
            Market(title: "Market 2"),
            Market(title: "Market 3"),
            Market(title: "Market 4"),
            Market(title: "Market 5"),
            Market(title: "Market 6"),
            Market(title: "Market 7"),
            Market(title: "Market 8"),
            Market(title: "Market 9"),
            Market(title: "Market 10"),
            Market(title: "Market 11"),
            Market(title: "Market 12"),
            Market(title: "Market 13"),
            Market(title: "Market 14"),
            Market(title: "Market 15"),
        ])
    }
    
    func getLikedMarkets() -> Observable<[Market]> {
        return Observable.just([
            Market(title: "Market 1"),
            Market(title: "Market 2"),
            Market(title: "Market 5"),
            Market(title: "Market 6"),
            Market(title: "Market 7"),
            Market(title: "Market 12"),
            Market(title: "Market 13"),
            ])
    }
}
