//
//  MainVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import RealmSwift

class MainVC: BaseVC {

    @IBOutlet weak var tblMain: UITableView!
    var videos: Results<VideoData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMain.tableFooterView = UIView()
        tblMain.delegate = self
        tblMain.dataSource = self
        
        let realm = RealmServices.shared.realm
        videos = realm.objects(VideoData.self)
    }

}

//MARK: - Tableview Delegate, Datasource
/***************************************************************/
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MainCell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as! MainCell
        cell.lblTitle.text = videos[indexPath.row].videoTitle
        cell.lblAuthor.text = videos[indexPath.row].videoAuthor
        cell.lblDuration.text = "Duration 3:00"
        
        if let url = URL.init(string: videos[indexPath.row].videoThumb) {
            cell.imvVideo.downloadedFrom(url: url)
            cell.imvVideo.roundImage(with: cell.imvVideo)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Sub", bundle: nil)
        let pagingMenuVC = storyboard.instantiateViewController(withIdentifier: "PagingMenuVC") as! PagingMenuVC
        self.navigationController?.pushViewController(pagingMenuVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
