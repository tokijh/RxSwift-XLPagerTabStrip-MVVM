//
//  StringService.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

class StringService: StringServiceType {
    func getStrings() -> Observable<[String]> {
        return Observable.just([
            "String 1",
            "String 2",
            "String 3",
            "String 4",
            "String 5",
            "String 6",
        ])
    }
}
