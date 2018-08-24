//
//  MarketPagerChildViewModelType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxCocoa

protocol MarketPagerChildViewModelType: TitlePagerChildViewModelType {
    
    init(market: Market)
    
    // MARK Market
    var market: BehaviorRelay<Market> { get }
}
