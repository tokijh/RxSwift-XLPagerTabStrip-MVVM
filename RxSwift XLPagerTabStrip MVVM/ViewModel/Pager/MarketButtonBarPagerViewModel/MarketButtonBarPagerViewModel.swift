//
//  MarketButtonBarPagerViewModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class MarketButtonBarPagerViewModel: MarketButtonBarPagerViewModelType {
    
    let disposeBag = DisposeBag()
    
    required init(markets: [Market]) {
        self.markets = BehaviorRelay<[Market]>(value: markets)
        setup()
    }
    
    fileprivate func setup() {
        setupChildViewControllers()
        setupPager()
    }
    
    // MARK Market
    let markets: BehaviorRelay<[Market]>
    
    // MARK Child View Controllers
    let childViewControllers = BehaviorRelay<[PageableViewController]>(value: [])
    
    fileprivate func setupChildViewControllers() {
        markets
            .map({ $0.map({ MarketPagerChildViewModel(market: $0) }) })
            .map({ $0.map({ TitlePagerChildViewController(viewModel: $0) }) })
            .bind(to: childViewControllers)
            .disposed(by: disposeBag)
    }
    
    // MARK Pager
    var actionReloadPager = PublishSubject<Void>()
    
    fileprivate func setupPager() {
        childViewControllers.map({ _ -> Void in () }).bind(to: actionReloadPager).disposed(by: disposeBag)
    }
}
