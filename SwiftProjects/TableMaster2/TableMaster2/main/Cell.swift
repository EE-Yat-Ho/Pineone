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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        configure()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // 테이블과 레이블 설정들.
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ModelCell.self, forCellReuseIdentifier: "ModelCell")
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.clear
        
        kind.textAlignment = .center
    }
    
    // 테이블과 레이블 레이아웃.
    func setupLayout() {
        contentView.addSubview(kind)
        contentView.addSubview(tableView)
        
        kind.translatesAutoresizingMaskIntoConstraints = false
        kind.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        kind.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -30).isActive = true
        kind.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        kind.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        kind.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        kind.layer.borderWidth = 0.5
        kind.layer.borderColor = UIColor.lightGray.cgColor
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -30).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        tableView.layer.borderWidth = 0.5
        tableView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // 큰 셀에 데이터 넣어주기
    func dataMapping (modelNames: [String], kindName: String) {
        models = modelNames
        kind.text = kindName
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
