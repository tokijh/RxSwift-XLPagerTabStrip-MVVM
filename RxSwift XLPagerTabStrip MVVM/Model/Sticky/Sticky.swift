//
//  Sticky.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

class Sticky {
    var title: String? = nil
    var market: Market?
    var rows: [String] = []
    
    init(title: String? = nil, market: Market? = nil, rows: [String] = []) {
        self.title = title
        self.market = market
        self.rows = rows
    }
}
