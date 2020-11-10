//
//  ViewController.swift
//  MemoProject
//
//  Created by 박영호 on 2020/11/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var currentTab:Int = -1
    
    var mainStory:UIStoryboard!
    // return UIStoryboard(name: "Main", bundle: nil)
    //lazy var secondVC = mainStory.instantiateViewController(identifier: "SecondVC") as! SecondVC
    lazy var secondVC = mainStory.instantiateViewController(withIdentifier: "SecondVC")
    lazy var thirdVC = mainStory.instantiateViewController(withIdentifier: "ThirdVC")// as! ThirdVC
    
    enum TabIndex:Int {
        
        case memoList = 1
        case write
        case setting
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStory = UIStoryboard(name: "Main", bundle: nil)
        //연산 프로퍼티
        
    }
    
    
    //    guard currentTab != 0 else { return }
    //
    //    currentTab = 0
    //
    //    self.addChild(secondVC)
    //    self.containerView.addSubview(secondVC.view)
    
    
    @IBAction func write(_ sender: UIButton) {
        
        print(sender.tag)
        
        switch sender.tag {
        case 0://TabIndex.memoList.rawValue:
            print("메모리스트")
            
            guard currentTab != 0 else { return }
            currentTab = 0
            
            self.addChild(secondVC)// 컨트롤하겠다
            self.containerView.addSubview(secondVC.view)// 보여주는 부분
            
//            thirdVC.view.removeFromSuperview()
//            thirdVC.removeFromParent()//자식 컨트롤러를 제거
            
        case TabIndex.write.rawValue:
            print("글쓰기")
            
        case 1://TabIndex.setting.rawValue:
            print("설정")
            guard currentTab != 1 else { return }
            currentTab = 1
            
            self.addChild(thirdVC)// 컨트롤하겠다
            self.containerView.addSubview(thirdVC.view)// 보여주는 부분
            
//            secondVC.view.removeFromSuperview()
//            secondVC.removeFromParent()
            
        default:
            print("아무거나")
        }
    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(indexPath.row)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellData") as! MemoListCell
//
//        cell.cellData.text = data[indexPath.row]
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        performSegue(withIdentifier: "segue", sender: data[indexPath.row])
//    }
