//
//  companyFIndViewController.swift
//  whatthe
//
//  Created by donggyukim on 05/03/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit
import DropDown

class companyFIndViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var arr : [String] = []
    var arrsp : [String] = []
    var companyinfo = ""
    var dropDownItem = ""
    var deleteCompany = ""
    var dropDown:DropDown?
    
    let a = adminSelectNetworkHandler.getData(resource: "http://192.168.177.213:33018/selectCompany")
    
    
    var comArr : [String] = []
    var comUpArr : [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyinfo = a
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        if let datas = companyinfo.data(using: .utf8){
            print(datas,"datas")
            let jsonT = try? JSONSerialization.jsonObject(with: datas, options:[]) as? [[String:Any]]
            
            
            //var confirmArr = [Int]()
            var adminArr = [String]()
            
            
            var comUp = [String]()
            var com = [String]()
            
            
            var usernumberArr = Set<String>()
            
            if let user = jsonT as? [[String: Any]]{
                
                for userIndex in user {
                    //confirmArr.append(userIndex["confirm"] as! Int)
                    
                    adminArr.append(userIndex["company"] as! String)
                    usernumberArr.insert(userIndex["up_company"] as! String)
                    
                    
                    com.append(userIndex["company"] as! String)
                    comUp.append(userIndex["up_company"] as! String)
                    
                    print(user)
                }
                
            }
            
            // a = confirmArr[0]
            
            
            
            for item in usernumberArr{
                arrsp.append(item)}
            
            //for item in adminArr{
            //    arr.append(item)}
            
            
            for item in com{
                comArr.append(item)}
            
            for item in comUp{
                comUpArr.append(item)}
            
            
            
            
            
        }
        dropDown = DropDown()
        
        // The view to which the drop down will appear on
        dropDown?.anchorView = button // UIView or UIBarButtonItem
        dropDown?.bottomOffset = CGPoint(x: 0, y:(dropDown?.anchorView?.plainView.bounds.height)!)
        // The list of items to display. Can be changed dynamically
        dropDown?.dataSource = arrsp
        // Do any additional setup after loading the view.
        button.addTarget(self, action: #selector(dropDownButton), for: .touchUpInside)
        
        dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            self.button.setTitle(item, for: .normal)
            print(item,"item")
            self.dropDownItem = item
            self.arr.removeAll()
            for i in 0 ... self.comArr.count-1{
                if (self.dropDownItem == self.comUpArr[i]){
                    print(self.comUpArr[i],"comupArr")
                    self.arr.append(self.comArr[i])
                }
            }
            print(self.arr,"arr")
            self.tableView.reloadData()
            
        }
        
    }
    @objc func dropDownButton(){
        dropDown?.show()
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
        
        
        
        
        
        deleteCompany = currentItem!
        
        
        
        self.performSegue(withIdentifier: "detailUpdateCompany", sender: self)
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
