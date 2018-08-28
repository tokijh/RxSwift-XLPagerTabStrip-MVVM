//
//  MainSectionData.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwiftExtensions

enum MainSectionData {
    case strings([Value])
    case samples([Value])
    case markets([Value])
    case stickies([Value])
}

extension MainSectionData: SectionDataType {
    var items: [Value] {
        switch self {
        case let .strings(strings): return strings
        case let .samples(samples): return samples
        case let .markets(markets): return markets
        case let .stickies(stickies): return stickies
        }
    }
    
    enum Value {
        case strings(title: String, items: [String])
        case samples(title: String, items: [Sample])
        case markets(title: String, items: [Market])
        case sticky(title: String, sticky: Sticky)
    }
}

// MARK Pagerable
extension MainSectionData.Value: Pagerable {
    var viewController: UIViewController? {
        switch self {
        case let .strings(_, strings): return ButtonBarPagerViewController(viewModel: StringButtonBarPagerViewModel(strings: strings))
        case let .samples(_, samples): return ButtonBarPagerViewController(viewModel: SampleButtonBarPagerViewModel(samples: samples))
        case let .markets(_, markets): return ButtonBarPagerViewController(viewModel: MarketButtonBarPagerViewModel(markets: markets))
        case let .sticky(_, sticky): return StickyButtonBarPagerViewController(viewModel: StickyButtonBarPagerViewModel(sticky: sticky))
        }
    }
}
