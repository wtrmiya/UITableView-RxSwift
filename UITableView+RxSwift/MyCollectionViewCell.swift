//
//  MyCollectionViewCell.swift
//  UITableView+RxSwift
//
//  Created by Wataru Miyakoshi on 2022/04/28.
//

import UIKit
import SnapKit
final class MyCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: MyCell.self)
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "init"
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ make in
            make.center.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
