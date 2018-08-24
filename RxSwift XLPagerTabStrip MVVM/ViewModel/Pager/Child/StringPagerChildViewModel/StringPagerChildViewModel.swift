//
//  StringPagerChildViewModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class StringPagerChildViewModel: StringPagerChildViewModelType {
    
    let disposeBag = DisposeBag()
    
    required init(string: String) {
        self.string = BehaviorRelay<String>(value: string)
        setup()
    }
    
    fileprivate func setup() {
        setupTitleText()
    }
    
    // MART String
    let string: BehaviorRelay<String>
    
    // MARK Title Text
    let titleText = BehaviorRelay<String?>(value: nil)
    
    fileprivate func setupTitleText() {
        string.bind(to: titleText).disposed(by: disposeBag)
    }
}
