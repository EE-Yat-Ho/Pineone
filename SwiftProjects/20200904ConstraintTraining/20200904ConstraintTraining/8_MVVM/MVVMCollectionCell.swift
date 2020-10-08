//
//  MVVMCollectionCell.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/07.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit

class MVVMCollectionCell: UICollectionViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }
    }
}
