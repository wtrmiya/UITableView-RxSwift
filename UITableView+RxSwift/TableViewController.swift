//
//  TableViewController.swift
//  UITableView+RxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TableViewController:UIViewController {
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(MyCell.self, forCellReuseIdentifier: MyCell.identifier)
        return tableView
    }()
    
    private var months = ["January", "February", "March"]
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindTableView()
    }
}

private extension TableViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
//        tableView.dataSource = self
    }
    
    func bindTableView() {
        // まず、初期データをObservableにして
        let months = Observable.of(["January", "February", "March"])
        
        months
            .bind(to: tableView.rx.items) { // UITableView.rx.itemsにbindする。
                (tableView: UITableView, index: Int, element: String) in
                // IndexPathは自作する必要がある。
                let indexPath = IndexPath(item: index, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.identifier, for: indexPath) as? MyCell else { return UITableViewCell() }
                cell.configure(title: element)
                return cell
            }
            .disposed(by: bag)
    }
}

//extension TableViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return months.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.identifier, for: indexPath) as? MyCell
//        else { return UITableViewCell() }
//
//        cell.configure(title: months[indexPath.row])
//
//        return cell
//    }
//}
