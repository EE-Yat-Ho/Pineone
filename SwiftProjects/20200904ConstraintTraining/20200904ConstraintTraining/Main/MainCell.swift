//
//  MainCell.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import Reusable
import SnapKit
import Then

class MainCell: UITableViewCell, Reusable {

    let label = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.textAlignment = .center
    }
    
    func setupLayout(){
        self.addSubview(label)
        label.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = .none
    }

}
