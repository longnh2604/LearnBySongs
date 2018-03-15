//
//  MainVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class MainVC: BaseVC {

    @IBOutlet weak var tblMain: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMain.tableFooterView = UIView()
        tblMain.delegate = self
        tblMain.dataSource = self
    }

}

//MARK: - Tableview Delegate, Datasource
/***************************************************************/
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MainCell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as! MainCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
