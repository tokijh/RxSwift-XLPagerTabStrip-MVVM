//
//  TitleCellModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class TitleCellModel: TitleCellModelType {
    
    let disposeBag = DisposeBag()
    
    required init(title: String?) {
        self.title = BehaviorRelay<String?>(value: title)
        setup()
    }
    
    fileprivate func setup() {
        setupTitleLabel()
    }
    
    // MARK Title
    let title: BehaviorRelay<String?>
    
    // MARK Title Label
    fileprivate var _titleLabelText: Driver<String?>!
    var titleLabelText: Driver<String?> {
        return _titleLabelText
    }
    
    fileprivate func setupTitleLabel() {
        _titleLabelText = title.asDriver()
    }
}

