//
//  ViewController.swift
//  TableMaster
//
//  Created by 박영호 on 2020/10/14.
//

import UIKit

class ViewController: UIViewController {
    let tableView = UITableView()
    var data = [String:[String]]()
    var kindList = [String]()
    var modelList = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupLayout()
        loadData()
    }
    
    // 테이블 설정들
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.clear
    }
    
    // 테이블 레이아웃들
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // 데이터 불러오기.
    // 위로 드래그 후 내려오면 테이블이 리로드되기 때문에 결국 인덱싱 접근이 되어야함.
    // 때문에 딕셔너리가 아닌 배열 형태로 모든 데이터를 가지고 있어야함.
    func loadData() {
        data = MainRepository.shared.data
        for (key,_) in data {
            kindList.append(key)
        }
        for kind in kindList {
            if let k = data[kind] {
                modelList.append(k)
            }
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // 섹션 별 행 갯수 = 제품군 별 모델 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kindList.count
    }

    // 셀이 재사용큐에서 빠져나왔을 때,
    // 셀안의 테이블에 올바른 데이터를 넣어준다고해도,
    // 자동으로 리로드되지않음!! 그래서 리로드해줌.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.dataMapping(modelNames: modelList[indexPath.row], kindName: kindList[indexPath.row])
        cell.tableView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(modelList[indexPath.row].count * 40)
    }
}
