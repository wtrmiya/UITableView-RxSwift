//
//  CollectionViewController.swift
//  UITableView+RxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CollectionViewController:UIViewController {
    
    private let collectionView:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewController.createLayout())
    
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindCollectionView()
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(44), heightDimension: .absolute(44))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        
        // return layout
        return UICollectionViewCompositionalLayout(section: section)
    }
}

private extension CollectionViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    func bindCollectionView() {
        // まず、初期データをObservableにしておく。
        // ViewControllerクラスのプロパティにしなくとも良い、
        // しても良い。
        let numbers = Observable.of([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
        
        numbers
            .bind(to: collectionView.rx.items) {
                (collectionView: UICollectionView, index: Int, element: Int) in
                let indexPath = IndexPath(item: index, section: 0)
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as? MyCollectionViewCell else { return UICollectionViewCell()}
                cell.configure(title: element.description)
                return cell
            }
            .disposed(by: bag)
        
//        tableView.rx
//            .modelSelected(String.self)
//            .subscribe(onNext: { model in
//                print("\(model) was selected")
//            })
//            .disposed(by: bag)
    }
}

