//
//  StickyButtonBarPagerViewModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 28..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class StickyButtonBarPagerViewModel: StickyButtonBarPagerViewModelType {
    
    let disposeBag = DisposeBag()
    
    required init(sticky: Sticky) {
        self.sticky = BehaviorRelay<Sticky>(value: sticky)
        setup()
    }
    
    func setup() {
        setupChildViewControllers()
        setupPager()
    }
    
    // MARK Sticky
    let sticky: BehaviorRelay<Sticky>
    
    // MARK Child View Controllers
    let childViewControllers = BehaviorRelay<[PageableViewController]>(value: [])
    
    fileprivate func setupChildViewControllers() {
        let child: Observable<PageableViewController> = sticky
            .map({ StickyPagerChildViewModel(sticky: $0) })
            .map({ TablePagerChildViewController(viewModel: $0) })
        Observable.combineLatest([ child, child ])
            .bind(to: childViewControllers)
            .disposed(by: disposeBag)
    }
    
    // MARK Pager
    let actionReloadPager = PublishSubject<Void>()
    
    fileprivate func setupPager() {
        childViewControllers.map({ _ -> Void in () }).bind(to: actionReloadPager).disposed(by: disposeBag)
    }
}
