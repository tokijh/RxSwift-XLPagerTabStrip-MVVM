//
//  MarketHeaderView.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol MarketHeaderViewModelType: ViewModelType {
    
}

class MarketHeaderViewModel: MarketHeaderViewModelType {
    
}

class MarketHeaderView: UIView {
    
    fileprivate var disposeBag = DisposeBag()
    
    open fileprivate(set) var viewModel: MarketHeaderViewModelType? = nil {
        didSet {
            disposeBag = DisposeBag()
            bind()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK View Model
    open func set(viewModel: MarketHeaderViewModelType) {
        self.viewModel = viewModel
    }
    
    fileprivate func bind() {
        guard let viewModel = self.viewModel else { return }
        // View
//        viewModel.titleLabelText.drive(titleLabel.rx.text).disposed(by: disposeBag)
    }
    
    fileprivate func setup() {
        setupView()
    }
    
    fileprivate func setupView() {
        backgroundColor = UIColor.red
        layout()
    }
    
    fileprivate func layout() {
        // Market Image View
        addSubview(marketImageView)
        marketImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.height.equalTo(36)
            $0.width.equalTo(36)
        }
        
        // Title Label
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(marketImageView)
            $0.left.equalTo(marketImageView).offset(16)
            $0.right.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    // MARK Market Image View
    fileprivate(set) lazy var marketImageView: UIImageView = UIImageView()
    
    // MARK Title Label
    fileprivate(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
}
