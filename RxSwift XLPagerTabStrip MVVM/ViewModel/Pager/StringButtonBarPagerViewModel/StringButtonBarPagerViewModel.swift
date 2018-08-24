//
//  StringButtonBarPagerViewModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class StringButtonBarPagerViewModel: StringButtonBarPagerViewModelType {
    
    let disposeBag = DisposeBag()
    
    required init(strings: [String]) {
        self.strings = BehaviorRelay<[String]>(value: strings)
        setup()
    }
    
    fileprivate func setup() {
        setupChildViewControllers()
        setupPager()
    }
    
    // MARK String
    let strings: BehaviorRelay<[String]>
    
    // MARK Child View Controllers
    let childViewControllers = BehaviorRelay<[PageableViewController]>(value: [])
    
    fileprivate func setupChildViewControllers() {
        strings
            .map({ $0.map({ StringPagerChildViewModel(string: $0) }) })
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
