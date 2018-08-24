//
//  MainViewModelType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

protocol MainViewModelType: ViewModelType {
    
    init(stringService: StringServiceType, sampleService: SampleServiceType)
    
    // MARK Service
    var stringService: StringServiceType { get }
    var sampleService: SampleServiceType { get }
    
    // MARK String
    var strings: BehaviorRelay<[String]> { get }
    
    // MARK Sample
    var samples: BehaviorRelay<[Sample]> { get }
    
    // MARK Section
    var sections: BehaviorRelay<[MainSectionData]> { get }
    var eventDidClickRow: PublishSubject<MainSectionData.Value> { get }
    
    // MARK Action
    // MARK Move
    var actionPushVC: PublishSubject<UIViewController> { get }
}
