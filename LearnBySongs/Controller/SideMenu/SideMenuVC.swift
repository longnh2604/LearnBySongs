//
//  SideMenuVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {

    var mainNavi : UINavigationController?
    var menuOptions = ["Home", "Setting", "Logout"]
    
    @IBOutlet weak var tblSideMenu: UITableView!
    @IBOutlet weak var imvUser: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblUserType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    //MARK: - Load UI
    /***************************************************************/
    func setupUI() {
        tblSideMenu.tableFooterView = UIView()
        
        lblUsername.text = ""
        lblUserType.text = ""
        
//        if let url = URL.init(string: UserDefaults.standard.string(forKey: "imageURL")!) {
//            imvAccount.downloadedFrom(url: url)
//            imvAccount.roundImage(with: imvAccount)
//        }
//
//        if let lstSignedin = UserDefaults.standard.string(forKey: "AppClose") {
//            lblLstLogined.text = "直前のサインイン " + lstSignedin
//        }
//
//        helpNavi = kMain_Storyboard.instantiateViewController(withIdentifier: "HelpNavi") as? UINavigationController
//        helpVC = kMain_Storyboard.instantiateViewController(withIdentifier: "HelpVC") as? HelpVC
    }
    
    func changeViewController(_ index : Int) {
        switch index {
        case 0:
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
            break
        case 1:
//            self.navigationController?.pushViewController(helpVC!, animated: true)
            break
        case 2:
            UserDefaults.standard.set("logout", forKey: "LoginState")
            UserDefaults.standard.synchronize()
            RealmServices.shared.deleteAll()
            //            slideMenuVC.dismiss(animated: true, completion: nil)
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
