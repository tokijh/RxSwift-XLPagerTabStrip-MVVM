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
    
    required init(stringService: StringServiceType = StringService(),
                  sampleService: SampleServiceType = SampleService(),
                  marketService: MarketServiceType = MarketService(),
                  stickyService: StickyServiceType = StickyService()) {
        self.stringService = stringService
        self.sampleService = sampleService
        self.marketService = marketService
        self.stickyService = stickyService
        setup()
    }
    
    fileprivate func setup() {
        setupSection()
    }
    
    // MARK Service
    let stringService: StringServiceType
    let sampleService: SampleServiceType
    let marketService: MarketServiceType
    let stickyService: StickyServiceType
    
    // MARK Section
    let sections = BehaviorRelay<[MainSectionData]>(value: [])
    let eventDidClickRow = PublishSubject<MainSectionData.Value>()
    
    fileprivate func setupSection() {
        // String
        let sectionDataStringValue = stringService.getStrings().map({ MainSectionData.Value.strings(title: "String", items: $0) })
        let sectionDataString = sectionDataStringValue.map({ [$0] }).map({ MainSectionData.strings($0) })
        
        // Sample
        let sectionDataSampleValue = sampleService.getSamples().map({ MainSectionData.Value.samples(title: "Sample", items: $0) })
        let sectionDataSample = sectionDataSampleValue.map({ [$0] }).map({ MainSectionData.samples($0) })
        
        // Market
        let sectionDataMarketAllValue = marketService.getAllMarkets().map({ MainSectionData.Value.markets(title: "Market All", items: $0) })
        let sectionDataMarketLikedValue = marketService.getLikedMarkets().map({ MainSectionData.Value.markets(title: "Market Liked", items: $0) })
        let sectionDataMarket = Observable.combineLatest([sectionDataMarketAllValue, sectionDataMarketLikedValue]).map({ MainSectionData.markets($0) })
        
        // Sticky
        let sectionDataStickyValue = stickyService.getStickies().map({ $0.map({ MainSectionData.Value.sticky(title: "Sticky", sticky: $0) }) })
        let sectionDataSticky = sectionDataStickyValue.map({ $0 }).map({ MainSectionData.stickies($0) })
        
        Observable.combineLatest([sectionDataString, sectionDataSample, sectionDataMarket, sectionDataSticky])
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        // Event
        eventDidClickRow
            .map({ $0.viewController })
            .filterNil()            
            .bind(to: actionPushVC)
            .disposed(by: disposeBag)
    }
    
    // MARK Action
    // MARK Move
    let actionPushVC = PublishSubject<UIViewController>()
}
