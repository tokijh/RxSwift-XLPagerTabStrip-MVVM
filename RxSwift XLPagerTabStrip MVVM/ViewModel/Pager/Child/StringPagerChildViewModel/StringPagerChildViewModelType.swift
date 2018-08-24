//
//  StringPagerChildViewModelType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxCocoa

protocol StringPagerChildViewModelType: TitlePagerChildViewModelType {
    
    init(string: String)
    
    // MARK String
    var string: BehaviorRelay<String> { get }
}
