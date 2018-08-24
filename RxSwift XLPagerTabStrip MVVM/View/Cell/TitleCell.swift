//
//  TitleCell.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TitleCell: UITableViewCell {
    
    fileprivate var disposeBag = DisposeBag()
    var viewModel: TitleCellModelType? = nil {
        didSet {
            bind()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        layout()
    }
    
    fileprivate func layout() {
        // Title Label
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(13)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset Binder
        disposeBag = DisposeBag()
    }
    
    // MARK View Model
    open func set(viewModel: TitleCellModelType) {
        self.viewModel = viewModel
    }
    
    fileprivate func bind() {
        guard let viewModel = self.viewModel else { return }
        // View
        viewModel.titleLabelText.drive(titleLabel.rx.text).disposed(by: disposeBag)
    }
    
    // MARK Title Label
    open fileprivate(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}
