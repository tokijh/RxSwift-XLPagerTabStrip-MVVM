//
//  TablePagerChildViewModelType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

protocol TablePagerChildViewModelType: TitlePagerChildViewModelType {
    
    // MARK Section
    var sections: BehaviorRelay<[TablePagerChildSectionData]> { get }
    var actionReloadSection: PublishSubject<Void> { get }
}
