//
//  StickyHeaderViewModel.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by 윤중현 on 2018. 8. 29..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxCocoa

class StickyHeaderViewModel: StickyHeaderViewModelType {
    
    // MARK Background Image
    open var backgroundImage: Driver<UIImage?> {
        return Driver<UIImage?>.just(#imageLiteral(resourceName: "bgSticky"))
    }
    
    // MARK Profile Image
    open var profileImage: Driver<UIImage?> {
        return Driver<UIImage?>.just(#imageLiteral(resourceName: "icProfile"))
    }
    
    // MARK Name Text
    open var nameText: Driver<String?> {
        return Driver<String?>.just("Name")
    }
}
