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
    }
    
    func bindTableView() {
        // まず、初期データをObservableにしておく。
        // ViewControllerクラスのプロパティにしなくとも良い、
        let months = Observable.of(["January", "February", "March"])
        
        months
            .bind(to: tableView.rx.items) { // データ用ObservableをUITableView.rx.itemsにbindする。
                (tableView: UITableView, index: Int, element: String) in
                // IndexPathは自作する必要がある。
                let indexPath = IndexPath(item: index, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.identifier, for: indexPath) as? MyCell else { return UITableViewCell() }
                cell.configure(title: element)
                return cell
            }
            .disposed(by: bag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: { model in
                print("\(model) was selected")
            })
            .disposed(by: bag)
    }
}

