//
//  companyUserViewController.swift
//  whatthe
//
//  Created by donggyukim on 04/03/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit

class companyUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var arr : [String] = []
    
    var nameComp : [String] = []
    var phoneComp : [String] = []
    var emailComp : [String] = []
    var ocassionComp : [String] = []
    var idComp : [Int] = []
    var userInfo = ""
    var userName = ""
    var userEmail = ""
    var userPhone = ""
    var userOcassion = ""
    var userId = 0
    var companyInfo = ""
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        print(userInfo,"userinfo")
        
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if let datas = userInfo.data(using: .utf8){
            print(datas,"datas")
            let jsonT = try? JSONSerialization.jsonObject(with: datas, options:[]) as? [[String:Any]]
            
            
            //var confirmArr = [Int]()
            
            var nameArr = [String]()
            var phoneArr = [String]()
            var emailArr = [String]()
            var ocassionArr = [String]()
            var idArr = [Int]()
            
            if let user = jsonT as? [[String: Any]]{
                
                for userIndex in user {
                    //confirmArr.append(userIndex["confirm"] as! Int)
                    nameArr.append(userIndex["name"] as! String)
                    
                    phoneArr.append(userIndex["phone"] as! String)
                    
                    emailArr.append(userIndex["email"] as! String)
                    
                    ocassionArr.append(userIndex["ocassion"] as! String)
                    
                    idArr.append(userIndex["id"] as! Int)
                    print(user)
                }
                
            }
            
            // a = confirmArr[0]
            
            for item in nameArr{
                arr.append(item)}
            
            for item in nameArr{
                nameComp.append(item)}
            
            for item in emailArr{
                emailComp.append(item)}
            
            for item in phoneArr{
                phoneComp.append(item)}
            
            for item in ocassionArr{
                ocassionComp.append(item)}
            
            for item in idArr{
                idComp.append(item)}
            
            print(arr, "arr!!")
        }
        // Do any additional setup after loading the view.
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dest = segue.destination as! companyUserDetailViewController
        dest.userName = userName
        dest.userEmail = userEmail
        dest.userPhone = userPhone
        dest.userOcassion = userOcassion
        dest.userId = userId
        dest.companyInfo = companyInfo
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        Cell.textLabel?.text = arr[indexPath.row]
        
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let Cell = tableView.cellForRow(at: indexPath)
        
        
        //btn.setTitle(Cell?.textLabel?.text, for: .normal)
        //self.tableView.isHidden = true
        
        let indexPath = tableView.indexPathForSelectedRow
        
        //getting the current cell from the index path
        let currentCell = tableView.cellForRow(at: indexPath!)!as UITableViewCell
        
        //getting the text of that cell
        let currentItem = currentCell.textLabel!.text
        
        
        print(currentItem!)
        
        var name = currentItem!
        
        userName = name
        
        var tempInt = 0
        for i in 0 ... nameComp.count-1 {
            if(nameComp[i] == userName){
                tempInt = i
            }
            }
        
       userEmail = emailComp[tempInt]
       print(userEmail)
       userPhone = phoneComp[tempInt]
       userOcassion = ocassionComp[tempInt]
       userId = idComp[tempInt]
       let a = adminSelectNetworkHandler.getData(resource: "http://192.168.177.213:33018/selectCompany")
        companyInfo = a
        
        self.performSegue(withIdentifier: "detailUserUpdate", sender: self)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
