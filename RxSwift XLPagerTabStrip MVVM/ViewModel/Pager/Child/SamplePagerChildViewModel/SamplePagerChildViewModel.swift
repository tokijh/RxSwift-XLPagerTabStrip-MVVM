//
//  SamplePagerChildViewModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class SamplePagerChildViewModel: SamplePagerChildViewModelType {
    
    let disposeBag = DisposeBag()
    
    required init(sample: Sample) {
        self.sample = BehaviorRelay<Sample>(value: sample)
        setup()
    }
    
    fileprivate func setup() {
        setupTitleText()
    }
    
    // MART Sample
    let sample: BehaviorRelay<Sample>
    
    // MARK Title Text
    let titleText = BehaviorRelay<String?>(value: nil)
    
    fileprivate func setupTitleText() {
        sample
            .map({ $0.title })
            .bind(to: titleText)
            .disposed(by: disposeBag)
    }
}
