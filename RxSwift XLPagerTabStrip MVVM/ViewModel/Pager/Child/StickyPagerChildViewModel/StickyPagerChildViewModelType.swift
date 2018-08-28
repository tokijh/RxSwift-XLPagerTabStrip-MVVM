//
//  StickyPagerChildViewModelType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 28..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxCocoa

protocol StickyPagerChildViewModelType: TablePagerChildViewModelType {
    
    init(sticky: Sticky)
    
    // MARK Sticky
    var sticky: BehaviorRelay<Sticky> { get }
}
