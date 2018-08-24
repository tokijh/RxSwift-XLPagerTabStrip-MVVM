//
//  StringCellModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class StringCellModel: StringCellModelType {
    
    let disposeBag = DisposeBag()
    
    let string: BehaviorRelay<String>
    
    required init(string: String) {
        self.string = BehaviorRelay<String>(value: string)
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
        _titleLabelText = string.asDriver().map({ Optional<String>($0) })
    }
}
