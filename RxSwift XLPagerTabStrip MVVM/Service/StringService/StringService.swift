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
            "Child1",
            "Child2",
            "Child3",
            "Child4",
            "Child5",
            "Child6",
            "Child7",
            "Child8",
        ])
    }
}
