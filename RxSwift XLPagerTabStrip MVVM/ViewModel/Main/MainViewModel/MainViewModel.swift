//
//  MainViewModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class MainViewModel: MainViewModelType {
    
    let disposeBag = DisposeBag()
    
    required init(stringService: StringServiceType = StringService(), sampleService: SampleServiceType = SampleService()) {
        self.stringService = stringService
        self.sampleService = sampleService
        setup()
    }
    
    fileprivate func setup() {
        setupString()
        setupSample()
        setupSection()
    }
    
    // MARK Service
    let stringService: StringServiceType
    let sampleService: SampleServiceType
    
    // MARK String
    let strings = BehaviorRelay<[String]>(value: [])
    
    fileprivate func setupString() {
        stringService
            .getStrings()
            .bind(to: strings)
            .disposed(by: disposeBag)
    }
    
    // MARK Sample
    let samples = BehaviorRelay<[Sample]>(value: [])
    
    fileprivate func setupSample() {
        sampleService
            .getSamples()
            .bind(to: samples)
            .disposed(by: disposeBag)
    }
    
    // MARK Section
    let sections = BehaviorRelay<[MainSectionData]>(value: [])
    let eventDidClickRow = PublishSubject<MainSectionData.Value>()
    
    fileprivate func setupSection() {
        let sectionDataString = strings.map({ MainSectionData.strings($0) })
        let sectionDataSample = samples.map({ MainSectionData.samples($0) })
        Observable.combineLatest([sectionDataString, sectionDataSample])
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        // Event
//        eventDidClickRow
//            .map({ section -> Sample? in
//                switch section {
//                case let .sample(sample): return sample
//                }
//            })
//            .map({ $0?.viewController })
//            .filterNil()
//            .bind(to: actionPushVC)
//            .disposed(by: disposeBag)
    }
    
    // MARK Action
    // MARK Move
    let actionPushVC = PublishSubject<UIViewController>()
}
