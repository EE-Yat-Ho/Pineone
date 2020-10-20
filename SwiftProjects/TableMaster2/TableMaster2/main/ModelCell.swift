//
//  ModelCell.swift
//  TableMaster2
//
//  Created by 박영호 on 2020/10/14.
//

import UIKit

class ModelCell: UITableViewCell {
    let model = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        model.textAlignment = .center
    }
    
    func setupLayout() {
        contentView.addSubview(model)
        model.translatesAutoresizingMaskIntoConstraints = false
        model.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        model.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        model.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        model.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        model.layer.borderWidth = 0.5
        model.layer.borderColor = UIColor.lightGray.cgColor
    }
}
