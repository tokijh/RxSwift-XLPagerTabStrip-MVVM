//
//  MainSectionData.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwiftExtensions

enum MainSectionData {
    case strings([String])
    case samples([Sample])
}

extension MainSectionData: SectionDataType {
    var items: [Value] {
        switch self {
        case let .strings(strings): return strings.map({ Value.string($0) })
        case let .samples(samples): return samples.map({ Value.sample($0) })
        }
    }
    
    enum Value {
        case string(String)
        case sample(Sample)
    }
}
