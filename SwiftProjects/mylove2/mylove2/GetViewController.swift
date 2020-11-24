//
//  GetViewController.swift
//  mylove2
//
//  Created by 박영호 on 2020/11/24.
//

import UIKit

protocol GetDelegate {
    func get() -> Int
}

class GetViewController: UITableViewController {

    var delegate: GetDelegate!
    var num = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = navigationController?.viewControllers[0] as! GetDelegate
        
        num = delegate.get()
    }
}

extension GetViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        return cell
    }
}
