//
//  TitleCellModelType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxCocoa

protocol TitleCellModelType: ViewModelType {
    
    // MARK Title Label
    var titleLabelText: Driver<String?> { get }
}
