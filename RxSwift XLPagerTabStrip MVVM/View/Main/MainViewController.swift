//
//  MainViewController.swift
//  RxSwift XLPagerTabStrip MVVM
//
//  Created by  Joonghyun-Yoon on 2018. 8. 24..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UITableViewController {
    
    fileprivate var disposeBag = DisposeBag()
    
    let viewModel: MainViewModelType
    
    init(viewModel: MainViewModelType = MainViewModel()) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        defer { bind() }
        setupTableView()
    }
    
    fileprivate func bind() {
        // Action
        viewModel.actionPushVC
            .subscribe(onNext: { [weak self] vc in
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    // Table View
    fileprivate func setupTableView() {
        registerTableViewCells()
    }
    
    fileprivate func registerTableViewCells() {
        tableView.register(cell: TitleCell.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.value.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections.value[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections.value[indexPath.section].items[indexPath.row]
        
        switch section {
        case let .string(string):
            if let cell = tableView.dequeue(TitleCell.self, indexPath: indexPath) {
                cell.set(viewModel: StringCellModel(string: string))
                return cell
            }
        case let .sample(sample):
            if let cell = tableView.dequeue(TitleCell.self, indexPath: indexPath) {
                cell.set(viewModel: SampleCellModel(sample: sample))
                return cell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = viewModel.sections.value[section]
        
        switch section {
        case .strings: return "Strings"
        case .samples: return "Samples"
        }
    }
    
    // MARK Event
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = viewModel.sections.value[indexPath.section].items[indexPath.row]
        viewModel.eventDidClickRow.onNext(section)
    }
}

