//
//  MarketServiceType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

protocol MarketServiceType {
    func getAllMarkets() -> Observable<[Market]>
    func getLikedMarkets() -> Observable<[Market]>
}
