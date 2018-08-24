//
//  MarketButtonBarPagerViewModelType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxCocoa

protocol MarketButtonBarPagerViewModelType: ButtonBarPagerViewModelType {
    init(markets: [Market])
    
    // MARK Market
    var markets: BehaviorRelay<[Market]> { get }
}
