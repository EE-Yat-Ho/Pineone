//
//  LoadingService.swift
//  UPlusAR
//
//  Created by baedy on 2020/06/08.
//  Copyright © 2020 최성욱. All rights reserved.
//

import QuartzCore
import SDWebImage
import SnapKit
import UIKit

class LoadingService {
    var loadingView = UIImageView()
    var containerView = UIView()

    var imgListArray: [UIImage] = []

    var retainCount = 0

    fileprivate func setImageList() {
         for countValue in 0..<90 {
             var temp = ""
             if  countValue < 10 {
                 temp = "0\(countValue)"
             } else {
                 temp = "\(countValue)"
             }
             let strImageName: String = "General_Liquid_00\(temp).png"
             let image = UIImage(named: strImageName)
             if image != nil {
                 imgListArray.append(image!)
             }
         }
     }

    fileprivate func setting() {
        setImageList()

        self.loadingView = UIImageView()
        loadingView.animationImages = self.imgListArray
        containerView = UIView(frame: UIScreen.main.bounds)

        loadingView.animationDuration = 2.0

        containerView.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.width.equalTo(94)
            $0.height.equalTo(82)
            $0.center.equalToSuperview()
        }
    }

    private static var sharedService: LoadingService = {
        let service = LoadingService()
        service.setting()
        return service
    }()

    class var shared: LoadingService {
        return sharedService
    }

    func show() {
        DispatchQueue.main.async { [unowned self] in
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                self.retainCount += 1
                self.loadingView.center = window.center
                self.containerView.frame = window.frame
                self.containerView.center = window.center
                window.addSubview(self.containerView)

                self.containerView.snp.remakeConstraints {
                    $0.center.equalToSuperview()
                    $0.width.height.equalToSuperview()
                }

                self.loadingView.startAnimating()
            }
        }
    }

    func hide() {
        retainCount -= 1
        if retainCount <= 0 {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: ({
                    self.loadingView.alpha = 0.3
                    }
                )) {[weak self] _ in
                    self?.loadingView.alpha = 1
                    if self?.retainCount ?? 0 <= 0 {
                        self?.retainCount = 0
                        self?.containerView.removeFromSuperview()
                        self?.loadingView.stopAnimating()
                    }
                }
            }
        }
    }
}

