//
//  NewWordsVC.swift
//  LearnBySongs
//
//  Created by Long Nguyen on 2018/03/21.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit

class NewWordsVC: UIViewController {

    @IBOutlet weak var tblNewWords: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblNewWords.tableFooterView = UIView()
        tblNewWords.delegate = self
        tblNewWords.dataSource = self
    }

}

//MARK: - Tableview Delegate, Datasource
/***************************************************************/
extension NewWordsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NewWordsCell = tableView.dequeueReusableCell(withIdentifier: "newWordsCell") as! NewWordsCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
