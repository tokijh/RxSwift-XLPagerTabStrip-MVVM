//
//  TitlePagerChildViewController.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import XLPagerTabStrip
import RxSwift
import RxCocoa

class TitlePagerChildViewController: PageableViewController {
    
    fileprivate var disposeBag = DisposeBag()
    
    let viewModel: TitlePagerChildViewModelType
    
    init(viewModel: TitlePagerChildViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        defer { layout() }
        setupView()
    }
    
    fileprivate func layout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK View
    fileprivate func setupView() {
        view.backgroundColor = .white
        setupTitleLabel()
    }
    
    // MARK Title Label
    open fileprivate(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    fileprivate func setupTitleLabel() {
        defer { bindTitleLabel() }
    }
    
    fileprivate func bindTitleLabel() {
        viewModel.titleText.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
    }
    
    // MARK IndicatorInfo
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: viewModel.titleText.value)
    }
}
