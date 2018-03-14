//
//  SideMenuVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import RealmSwift

class SideMenuVC: UIViewController {

    var mainNavi : UINavigationController?
    var settingNavi : UINavigationController?
    var settingVC: SettingVC?
    var menuOptions = ["Home", "Setting", "Logout"]
    var users: Results<UserData>!
    
    @IBOutlet weak var tblSideMenu: UITableView!
    @IBOutlet weak var imvUser: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblUserType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = RealmServices.shared.realm
        users = realm.objects(UserData.self)
        
        setupUI()
    }

    //MARK: - Load UI
    /***************************************************************/
    func setupUI() {
        tblSideMenu.tableFooterView = UIView()
        tblSideMenu.delegate = self
        tblSideMenu.dataSource = self
        
        lblUsername.text = users[0].userName
        
        lblUserType.text = getUserType(type: users[0].userType)
        
        if let url = URL.init(string: users[0].userImage) {
            imvUser.downloadedFrom(url: url)
            imvUser.roundImage(with: imvUser)
        }

        settingNavi = kMain_Storyboard.instantiateViewController(withIdentifier: "settingNavi") as? UINavigationController
        settingVC = kMain_Storyboard.instantiateViewController(withIdentifier: "SettingVC") as? SettingVC
    }
    
    func changeViewController(_ index : Int) {
        switch index {
        case 0:
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
            break
        case 1:
            self.navigationController?.pushViewController(settingVC!, animated: true)
            break
        case 2:
            UserDefaults.standard.set("logout", forKey: "LoginState")
            UserDefaults.standard.synchronize()
            RealmServices.shared.deleteAll()
            let loginPageView =  self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.present(loginPageView, animated: true, completion: nil)
            break
        default:
            
            break
        }
        toggleLeft()
    }
}

//MARK: - Tableview Delegate, Datasource
/***************************************************************/
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SideMenuCell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell") as! SideMenuCell
        cell.lblTitle.text = menuOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeViewController(indexPath.row)
    }
}
