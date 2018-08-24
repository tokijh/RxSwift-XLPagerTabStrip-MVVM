//
//  SampleService.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

class SampleService: SampleServiceType {
    func getSamples() -> Observable<[Sample]> {
        return Observable.just([
            Sample(title: "Child1"),
            Sample(title: "Child2"),
            Sample(title: "Child3"),
            Sample(title: "Child4"),
            Sample(title: "Child5"),
            Sample(title: "Child6"),
            Sample(title: "Child7"),
            Sample(title: "Child8"),
            Sample(title: "Child9"),
            Sample(title: "Child10"),
            Sample(title: "Child11"),
            Sample(title: "Child12"),
        ])
    }
}
