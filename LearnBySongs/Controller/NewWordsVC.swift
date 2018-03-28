//
//  NewWordsVC.swift
//  LearnBySongs
//
//  Created by Long Nguyen on 2018/03/21.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import RealmSwift

class NewWordsVC: UIViewController {

    @IBOutlet weak var tblNewWords: UITableView!
    var videos: Results<VideoData>!
    var cellIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cellIndex = GlobalVariables.sharedManager.cellIndex
        
        let realm = RealmServices.shared.realm
        videos = realm.objects(VideoData.self)
        
        getJsonWordsFromString()
        
        tblNewWords.tableFooterView = UIView()
        tblNewWords.delegate = self
        tblNewWords.dataSource = self
    }
    
    func getJsonWordsFromString() {
        // Asynchronous Http call to your api url, using URLSession:
        URLSession.shared.dataTask(with: URL(string: videos[cellIndex!].videoWords)!) { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    // Convert to dictionary where keys are of type String, and values are of any type
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]

                    for j in json {
                    
                    }
                } catch {
                    // Something went wrong
                }
            }
            }.resume()
    }

}

//MARK: - Tableview Delegate, Datasource
/***************************************************************/
extension NewWordsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
