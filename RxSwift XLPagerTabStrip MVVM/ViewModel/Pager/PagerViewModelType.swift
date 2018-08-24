//
//  PagerViewModelType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import XLPagerTabStrip
import RxSwift
import RxCocoa

protocol PagerViewModelType: ViewModelType {
    
    // MARK Child View Controllers
    var childViewControllers: BehaviorRelay<[PageableViewController]> { get }
    
    // MARK Pager
    var actionReloadPager: PublishSubject<Void> { get }
}
