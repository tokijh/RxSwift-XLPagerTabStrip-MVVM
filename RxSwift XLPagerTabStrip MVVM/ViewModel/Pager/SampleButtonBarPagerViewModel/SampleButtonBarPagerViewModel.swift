//
//  SampleButtonBarPagerViewModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class SampleButtonBarPagerViewModel: SampleButtonBarPagerViewModelType {
    
    let disposeBag = DisposeBag()
    
    required init(samples: [Sample]) {
        self.samples = BehaviorRelay<[Sample]>(value: samples)
        setup()
    }
    
    fileprivate func setup() {
        setupChildViewControllers()
        setupPager()
    }
    
    // MARK Sample
    let samples: BehaviorRelay<[Sample]>
    
    // MARK Child View Controllers
    let childViewControllers = BehaviorRelay<[PageableViewController]>(value: [])
    
    fileprivate func setupChildViewControllers() {
        samples
            .map({ $0.map({ SamplePagerChildViewModel(sample: $0) }) })
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
