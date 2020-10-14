//
//  Cell.swift
//  TableMaster
//
//  Created by 박영호 on 2020/10/14.
//

import UIKit

class Cell: UITableViewCell {
    let kind = UILabel()
    var models = [String]()
    let tableView = UITableView()
    var hegihtConstraint = NSLayoutConstraint()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        configure()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ModelCell.self, forCellReuseIdentifier: "ModelCell")
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.clear
        
        kind.textAlignment = .center
    }
    
    func setupLayout() {
        contentView.addSubview(kind)
        contentView.addSubview(tableView)
        //tableView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1), for: .vertical)
        
        kind.translatesAutoresizingMaskIntoConstraints = false
        kind.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        kind.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -30).isActive = true
        kind.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        kind.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        kind.layer.borderWidth = 0.5
        kind.layer.borderColor = UIColor.lightGray.cgColor
        hegihtConstraint = kind.heightAnchor.constraint(equalToConstant: CGFloat(40 * models.count))
        hegihtConstraint.isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -30).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        tableView.layer.borderWidth = 0.5
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    func dataMapping (modelNames: [String], kindName: String) {
        models = modelNames
        //setHeight()
        kind.text = kindName
    }
    
    func setHeight() {
        hegihtConstraint = kind.heightAnchor.constraint(equalToConstant: CGFloat(40 * models.count))
        hegihtConstraint.isActive = true
    }
    
    func updataHeight() {
        hegihtConstraint.constant = CGFloat(40 * models.count)
        kind.layoutIfNeeded()
    }
}

extension Cell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModelCell") as! ModelCell
        cell.model.text = models[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
