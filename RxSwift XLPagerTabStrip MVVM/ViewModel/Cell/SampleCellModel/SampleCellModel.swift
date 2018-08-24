//
//  SampleCellModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class SampleCellModel: SampleCellModelType {
    
    let disposeBag = DisposeBag()
    
    let sample: BehaviorRelay<Sample>
    
    required init(sample: Sample) {
        self.sample = BehaviorRelay<Sample>(value: sample)
        setup()
    }
    
    fileprivate func setup() {
        setupTitleLabel()
    }
    
    // MARK Title Label
    fileprivate var _titleLabelText: Driver<String?>!
    var titleLabelText: Driver<String?> {
        return _titleLabelText
    }
    
    fileprivate func setupTitleLabel() {
        _titleLabelText = sample.asDriver().map({ $0.title })
    }
}
