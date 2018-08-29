//
//  StickyService.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

class StickyService: StickyServiceType {
    func getStickies() -> Observable<[Sticky]> {
        return Observable.just([
            Sticky(title: "Sticky 1", market: Market(name: "Market Name"), rows: Array(0..<100).map({ "\($0)" }))
        ])
    }
}
