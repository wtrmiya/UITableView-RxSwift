//
//  TableViewController.swift
//  UITableView+RxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/28.
//

import UIKit
import SnapKit
final class TableViewController:UIViewController {
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(MyCell.self, forCellReuseIdentifier: MyCell.identifier)
        return tableView
    }()
    
    private var months = ["January", "February", "March"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension TableViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        tableView.dataSource = self
    }
}

extension TableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return months.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.identifier, for: indexPath) as? MyCell
        else { return UITableViewCell() }
        
        cell.configure(title: months[indexPath.row])
        
        return cell
    }
}
