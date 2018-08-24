//
//  Pager.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

typealias PageableViewController = UIViewController & IndicatorInfoProvider

protocol Pagerable {
    var viewController: UIViewController? { get }
}
