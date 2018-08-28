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
    
    static let buttonBarHeight: CGFloat = 36
    
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
        setupStickyScrollView()
        setupHeaderView()
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
    
    // MARK Sticky Scroll View
    lazy var scrollView: MXScrollView = MXScrollView()
    
    fileprivate func setupStickyScrollView() {
        
    }
    
    // MARK Header View
    lazy var headerView: MarketHeaderView = MarketHeaderView()
    
    fileprivate func setupHeaderView() {
        
    }
    
    // MARK Pager View
    fileprivate func setupPagerView() {
        settings.style.selectedBarHeight = 3
        settings.style.buttonBarHeight = StickyButtonBarPagerViewController.buttonBarHeight
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
        // Scroll View
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // Header View
        
        let offset: CGFloat
        if #available(iOS 11.0, *) {
            offset = (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0) + UIApplication.shared.statusBarFrame.height
        } else {
            offset = UIApplication.shared.statusBarFrame.height
        }
        
        let rootHeaderView = UIView()
        rootHeaderView.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        let buttonBarWrapperView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.white
            return view
        }()
        rootHeaderView.addSubview(buttonBarWrapperView)
        buttonBarWrapperView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        // Button Bar View
        let buttonBarView: ButtonBarView! = self.buttonBarView
        buttonBarView.removeFromSuperview()
        buttonBarWrapperView.addSubview(buttonBarView)
        buttonBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(StickyButtonBarPagerViewController.buttonBarHeight)
        }
        
        // Button Bar Bottom Shadow
        buttonBarWrapperView.addSubview(buttonBarBottomShadow)
        buttonBarBottomShadow.snp.makeConstraints {
            $0.top.equalTo(buttonBarView.snp.bottom).offset(3)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
        scrollView.parallaxHeader.view = rootHeaderView
        scrollView.parallaxHeader.height = 250
        scrollView.parallaxHeader.minimumHeight = StickyButtonBarPagerViewController.buttonBarHeight + offset
        scrollView.parallaxHeader.mode = .fill
        
        // Container View
        let containerView: UIScrollView = self.containerView
        containerView.removeFromSuperview()
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(view)
            $0.width.equalTo(view)
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return viewModel.childViewControllers.value
    }
}
