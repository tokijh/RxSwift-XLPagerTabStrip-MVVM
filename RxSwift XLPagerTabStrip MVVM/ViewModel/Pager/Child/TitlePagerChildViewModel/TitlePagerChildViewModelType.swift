//
//  TitlePagerChildViewModelType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxCocoa

protocol TitlePagerChildViewModelType: ViewModelType {
    
    // MARK Title Text
    var titleText: BehaviorRelay<String?> { get }
}
