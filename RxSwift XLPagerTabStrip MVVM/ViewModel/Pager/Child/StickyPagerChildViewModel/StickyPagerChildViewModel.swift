//
//  StickyPagerChildViewModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 28..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class StickyPagerChildViewModel: StickyPagerChildViewModelType {

    let disposeBag = DisposeBag()
    
    required init(sticky: Sticky) {
        self.sticky = BehaviorRelay<Sticky>(value: sticky)
        setup()
    }
    
    func setup() {
        setupTitleText()
        setupSections()
    }
    
    // MARK Title Text
    let titleText = BehaviorRelay<String?>(value: nil)
    
    func setupTitleText() {
        sticky.map({ $0.title }).bind(to: titleText).disposed(by: disposeBag)
    }
    
    // MARK Sticky
    let sticky: BehaviorRelay<Sticky>
    
    // MARK Section
    let sections = BehaviorRelay<[TablePagerChildSectionData]>(value: [])
    let actionReloadSection = PublishSubject<Void>()
    
    func setupSections() {
        sticky
            .map({ $0.rows })
            .map({ $0.map({ TablePagerChildSectionData.Value.string($0) }) })
            .map({ TablePagerChildSectionData.section($0) })
            .map({ [$0] })
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        sections.map({ _ in () }).bind(to: actionReloadSection).disposed(by: disposeBag)
    }
}
