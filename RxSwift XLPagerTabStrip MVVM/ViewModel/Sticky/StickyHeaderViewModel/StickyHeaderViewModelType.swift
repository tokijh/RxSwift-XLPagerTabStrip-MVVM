//
//  StickyHeaderViewModelType.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by 윤중현 on 2018. 8. 29..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxCocoa

protocol StickyHeaderViewModelType: ViewModelType {
    
    // MARK Background Image
    var backgroundImage: Driver<UIImage?> { get }
    
    // MARK Profile Image
    var profileImage: Driver<UIImage?> { get }
    
    // MARK Name Text
    var nameText: Driver<String?> { get }
}
