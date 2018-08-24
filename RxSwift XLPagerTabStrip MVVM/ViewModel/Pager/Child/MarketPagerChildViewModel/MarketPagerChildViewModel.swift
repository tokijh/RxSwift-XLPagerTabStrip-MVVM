//
//  MarketPagerChildViewModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class MarketPagerChildViewModel: MarketPagerChildViewModelType {
    
    let disposeBag = DisposeBag()
    
    required init(market: Market) {
        self.market = BehaviorRelay<Market>(value: market)
        setup()
    }
    
    fileprivate func setup() {
        setupTitleText()
    }
    
    // MART Market
    let market: BehaviorRelay<Market>
    
    // MARK Title Text
    let titleText = BehaviorRelay<String?>(value: nil)
    
    fileprivate func setupTitleText() {
        market
            .map({ $0.title })
            .bind(to: titleText)
            .disposed(by: disposeBag)
    }
}
