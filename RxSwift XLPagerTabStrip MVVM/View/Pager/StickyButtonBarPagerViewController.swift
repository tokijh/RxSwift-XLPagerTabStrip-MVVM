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
    
    open let viewModel: ButtonBarPagerViewModelType
    
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

    fileprivate func lazySetup() {
        containerView.bounces = false
        layoutPager()
        setupRefreshControl()
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
                self?.lazySetup()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK Pager
    fileprivate func setupPager() {
        setupStickyScrollView()
        setupHeaderView()
        setupPagerView()
        setupButtonBar()
    }
    
    // MARK Sticky Scroll View
    open fileprivate(set) lazy var scrollView: MXScrollView = MXScrollView()
    
    fileprivate func setupStickyScrollView() {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    // MARK Header View
    open let headerHeight: CGFloat = 250
    open let minimumHeaderHeight: CGFloat = 39
    
    lazy var headerView: StickyHeaderView = StickyHeaderView()
    
    fileprivate func setupHeaderView() {
        headerView.set(viewModel: StickyHeaderViewModel())
    }
    
    // MARK Pager View
    fileprivate func setupPagerView() {
        settings.style.selectedBarHeight = 3
        settings.style.buttonBarHeight = buttonBarHeight
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
    open let buttonBarHeight: CGFloat = 35
    
    open fileprivate(set) lazy var buttonBarBottomShadow: UIView = {
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
        var offset: CGFloat
        if #available(iOS 11.0, *) {
            let statusHeight = UIApplication.shared.statusBarFrame.height
            let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
            let navBarHeight = navigationController?.navigationBar.bounds.height ?? 0
            offset = statusHeight + (safeAreaInsets.top > 0 ? safeAreaInsets.top : navBarHeight)
        } else {
            offset = (navigationController?.navigationBar.bounds.height ?? 0) + UIApplication.shared.statusBarFrame.height
        }
        
        let rootHeaderView = UIView()
        rootHeaderView.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        let buttonBarWrapperView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.white
            return view
        }()
        rootHeaderView.addSubview(buttonBarWrapperView)
        buttonBarWrapperView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        // Button Bar View
        let buttonBarView: ButtonBarView = self.buttonBarView
        buttonBarView.removeFromSuperview()
        buttonBarWrapperView.addSubview(buttonBarView)
        buttonBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(buttonBarHeight)
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
        scrollView.parallaxHeader.height = headerHeight
        scrollView.parallaxHeader.minimumHeight = minimumHeaderHeight + offset
        scrollView.parallaxHeader.mode = .fill
        
        // Container View
        if #available(iOS 11.0, *) {
            let statusHeight = UIApplication.shared.statusBarFrame.height
            let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
            let navBarHeight = navigationController?.navigationBar.bounds.height ?? 0
            offset = statusHeight + (safeAreaInsets.top > 0 ? safeAreaInsets.top : navBarHeight) + minimumHeaderHeight + safeAreaInsets.bottom
        } else {
            let statusHeight = UIApplication.shared.statusBarFrame.height
            let navBarHeight = navigationController?.navigationBar.bounds.height ?? 0
            offset = statusHeight + minimumHeaderHeight + navBarHeight
        }
        
        let containerView: UIScrollView = self.containerView
        containerView.removeFromSuperview()
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(view).offset(-offset)
            $0.width.equalTo(view)
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return viewModel.childViewControllers.value
    }

    // MARK RefreshControl
    open fileprivate(set) lazy var refreshControl = UIRefreshControl()

    fileprivate func setupRefreshControl() {
        defer { bindRefreshControl() }
        scrollView.addSubview(refreshControl)
        refreshControl.bounds = CGRect(x: refreshControl.bounds.origin.x, y: headerHeight - UIApplication.shared.statusBarFrame.height - (navigationController?.navigationBar.bounds.height ?? 0), width: refreshControl.bounds.size.width, height: refreshControl.bounds.size.height)
        refreshControl.tintColor = UIColor.black
    }

    fileprivate func bindRefreshControl() {
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
}
