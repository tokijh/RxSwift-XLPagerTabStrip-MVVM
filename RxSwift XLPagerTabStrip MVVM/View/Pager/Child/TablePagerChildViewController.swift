//
//  TablePagerChildViewController.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 28..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import XLPagerTabStrip
import RxSwift
import RxCocoa

class TablePagerChildViewController: PageableViewController {
    
    fileprivate var disposeBag = DisposeBag()
    
    let viewModel: TablePagerChildViewModelType
    
    init(viewModel: TablePagerChildViewModelType) {
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
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK View
    fileprivate func setupView() {
        view.backgroundColor = .white
        setupTableView()
    }
    
    // MARK Table View
    open fileprivate(set) lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        tableView.dataSource = self
        return tableView
    }()
    
    fileprivate func setupTableView() {
        defer { bindTableView() }
        registerTableViewCells()
    }
    
    fileprivate func registerTableViewCells() {
        tableView.register(cell: TitleCell.self)
    }
    
    fileprivate func bindTableView() {
        viewModel.actionReloadSection.subscribe(onNext: { [weak self] in self?.tableView.reloadData() }).disposed(by: disposeBag)
    }
    
    // MARK IndicatorInfo
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: viewModel.titleText.value)
    }
}

extension TablePagerChildViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections.value[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections.value[indexPath.section].items[indexPath.row]
        
        switch section {
        case let .string(string):
            if let cell = tableView.dequeue(TitleCell.self) {
                cell.set(viewModel: TitleCellModel(title: string))
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
