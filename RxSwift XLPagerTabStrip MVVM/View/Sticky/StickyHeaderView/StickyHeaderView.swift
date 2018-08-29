//
//  StickyHeaderView.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StickyHeaderView: UIView {
    
    fileprivate var disposeBag = DisposeBag()
    
    open fileprivate(set) var viewModel: StickyHeaderViewModelType? = nil {
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
    open func set(viewModel: StickyHeaderViewModelType) {
        self.viewModel = viewModel
    }
    
    fileprivate func bind() {
        guard let viewModel = self.viewModel else { return }
        // View
        // Backgroud Image View
        viewModel.backgroundImage.drive(backgroundImageView.rx.image).disposed(by: disposeBag)
        // Profile Image View
        viewModel.profileImage.drive(profileImageView.rx.image).disposed(by: disposeBag)
        // Name Label
        viewModel.nameText.drive(nameLabel.rx.text).disposed(by: disposeBag)
    }
    
    fileprivate func setup() {
        setupView()
    }
    
    fileprivate func setupView() {
        layout()
    }
    
    fileprivate func layout() {
        // Background Image View
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // Profile Image View
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(profileImageViewSize)
            $0.width.equalTo(profileImageViewSize)
        }
        
        // Name Label
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.left.equalTo(profileImageView.snp.right).offset(16)
            $0.right.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    // MARK Background Image View
    open fileprivate(set) lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK Profile Image View
    open let profileImageViewSize: CGFloat = 64
    
    open fileprivate(set) lazy var profileImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView()
        imageView.layer.cornerRadius = self.profileImageViewSize
        return imageView
    }()
    
    // MARK Name Label
    open fileprivate(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
}
