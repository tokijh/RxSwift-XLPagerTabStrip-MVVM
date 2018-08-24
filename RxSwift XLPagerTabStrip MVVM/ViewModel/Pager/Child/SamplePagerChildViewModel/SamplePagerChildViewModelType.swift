//
//  SamplePagerChildViewModelType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxCocoa

protocol SamplePagerChildViewModelType: TitlePagerChildViewModelType {
    
    init(sample: Sample)
    
    // MARK Sample
    var sample: BehaviorRelay<Sample> { get }
}
