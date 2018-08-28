//
//  StickyButtonBarPagerViewController.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import RxCocoa
import RxSwiftExtensions

class StickyButtonBarPagerViewController: ButtonBarPagerTabStripViewController {
    
    fileprivate var disposeBag = DisposeBag()
    
    let viewModel: ButtonBarPagerViewModelType
    
    init(viewModel: ButtonBarPagerViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        defer { bind() }
        setupView()
    }
    
    fileprivate func bind() {
        // Action
        viewModel.actionReloadPager
            .subscribe(onNext: { [weak self] in
                self?.reloadPagerTabStripView()
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupView() {
        defer { bindView() }
        setupPager()
    }
    
    fileprivate func bindView() {
        rx.viewDidLoad
            .subscribe(onNext: { [weak self] in
                // Set default background color
                self?.view.backgroundColor = .white
            })
            .disposed(by: disposeBag)
    }
    
    // MARK Pager
    fileprivate func setupPager() {
        defer { bindPager() }
        setupPagerView()
        setupButtonBar()
    }
    
    fileprivate func bindPager() {
        rx.viewDidLoad
            .subscribe(onNext: { [weak self] in
                self?.containerView.bounces = false
            })
            .disposed(by: disposeBag)
        
        // Layout Pager
        rx.viewDidLoad
            .subscribe(onNext: { [weak self] in
                self?.layoutPager()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK Header View
    
    
    fileprivate func setupHeaderView() {
        
    }
    
    // MARK Pager View
    fileprivate func setupPagerView() {
        settings.style.selectedBarHeight = 3
        settings.style.buttonBarHeight = 36
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 13)
        settings.style.buttonBarItemTitleColor = .red
        settings.style.buttonBarLeftContentInset = 17
        settings.style.buttonBarRightContentInset = 17
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = .red
        }
    }
    
    // MARK Bar Button
    lazy var buttonBarBottomShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    fileprivate func setupButtonBar() {
        defer { bindButtonBar() }
    }
    
    fileprivate func bindButtonBar() {
        rx.viewDidLoad
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.buttonBarView.selectedBar.backgroundColor = .black
                self.buttonBarView.backgroundColor = .white
            })
            .disposed(by: disposeBag)
    }
    
    // MARK Layout Pager (Container View / Bar Button)
    fileprivate func layoutPager() {
        // Button Bar View
        buttonBarView.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.top.equalTo(view.safeAreaLayoutGuide)
            } else {
                $0.top.equalToSuperview()
            }
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(36)
        }
        // Button Bar Bottom Shadow
        view.addSubview(buttonBarBottomShadow)
        buttonBarBottomShadow.snp.makeConstraints {
            $0.top.equalTo(buttonBarView.snp.bottom).offset(3)
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
        // Container View
        containerView.snp.makeConstraints {
            $0.top.equalTo(buttonBarBottomShadow.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return viewModel.childViewControllers.value
    }
}
