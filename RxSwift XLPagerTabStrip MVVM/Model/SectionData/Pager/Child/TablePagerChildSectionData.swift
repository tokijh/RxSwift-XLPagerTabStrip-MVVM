//
//  TablePagerChildSectionData.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 28..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwiftExtensions

enum TablePagerChildSectionData {
    case section([Value])
}

extension TablePagerChildSectionData: SectionDataType {
    var items: [Value] {
        switch self {
        case let .section(value): return value
        }
    }
    
    enum Value {
        case string(String)
    }
}
