//
//  companyUserDetailViewController.swift
//  whatthe
//
//  Created by donggyukim on 04/03/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit
import DropDown

class UpdateDetailUserNetworkHandler{
    
    class func getData(resource: String,name: String, phone: String, email: String, ocassion: String, confirm: String, company_id: String, standard: String ) -> String {
        
        var a = String()
        
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)
        
        guard let url = URL(string: "\(resource)") else {
            print("URL is nil")
            return ""
        }
        
        // Request
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let postString = ["name": name,"phone": phone, "standard":standard,"email": email,"confirm": confirm,"company_id": company_id,"ocassion":ocassion]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        
        // dataTask
        let group = DispatchGroup.init()
        
        
        let queue = DispatchQueue.global()
        
        
        group.enter()
        queue.async{
            let dataTask = defaultSession.dataTask(with: request) { data, response,
                error -> Void in
                // getting Data Error
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                    
                }
                guard error == nil else {
                    print("Error occur: \(String(describing: error))")
                    return
                }
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    
                    print("error=\(String(describing: error))")
                    
                    return
                    
                }
                
                let responseString = String(data: data, encoding: .utf8)
                a = responseString!
                
                print(responseString!,"first")
                group.leave()
                
            }
            print(a,"sencond")
            dataTask.resume()
        }
        print(a,"third")
        let reuslt = group.wait(timeout: .distantFuture)
        
        print("\(reuslt)")
        return a
    }
}


class companyUserDetailViewController:

UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    
    @IBOutlet weak var useremail: UITextField!
    
    @IBOutlet weak var userphone: UITextField!
    
    @IBOutlet weak var userocassion: UITextField!
    
    
    var userName = ""
    var userEmail = ""
    var userPhone = ""
    var userOcassion = ""
    var userId = 0
    var companyInfo = ""
    
    var comArr : [String] = []
    var upComArr : [String] = []
    var companyIdArr : [Int] = []
    
    var dropDown:DropDown?
    
    var dropDown2:DropDown?
    
    var dropDown3:DropDown?
    
    var sendCompany = ""
    var sendUpCompany = ""
    var sendConfirm = ""
    var sendCompanyId = ""
    @IBOutlet weak var comBtn: UIButton!
    @IBOutlet weak var comDetailBtn: UIButton!
    
    @IBOutlet weak var confirmBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = userName
        useremail.text = userEmail
        userphone.text = userPhone
        userocassion.text = userOcassion
        // Do any additional setup after loading the view.
        
        if let datas = companyInfo.data(using: .utf8){
            print(datas,"datas")
            let jsonT = try? JSONSerialization.jsonObject(with: datas, options:[]) as? [[String:Any]]
            
            
            var comUp = Set<String>()
            var com = [String]()
            var comId = [Int]()
            
            if let user = jsonT as? [[String: Any]]{
                
                for userIndex in user {
                    //confirmArr.append(userIndex["confirm"] as! Int)
                    
                    
                    
                    
                    com.append(userIndex["company"] as! String)
                    comUp.insert(userIndex["up_company"] as! String)
                    comId.append(userIndex["id"] as! Int)
                    print(user)
                }
                
            }
            
            
            for item in com{
                comArr.append(item)}
            
            for item in comUp{
                upComArr.append(item)}
            
            for item in comId{
                companyIdArr.append(item)}
            
        }
        
        dropDown = DropDown()
        
        // The view to which the drop down will appear on
        dropDown?.anchorView = comBtn // UIView or UIBarButtonItem
        dropDown?.bottomOffset = CGPoint(x: 0, y:(dropDown?.anchorView?.plainView.bounds.height)!)
        // The list of items to display. Can be changed dynamically
        dropDown?.dataSource = upComArr
        // Do any additional setup after loading the view.
        comBtn.addTarget(self, action: #selector(dropDownButton), for: .touchUpInside)
        
        dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            self.comBtn.setTitle(item, for: .normal)
            print(item,"item")
            self.sendCompany = item
            var temp = 0
            for i in 0 ... self.comArr.count-1{
                if (self.comArr[i] == item){
                    temp = i
                }
            }
             self.sendCompanyId = String(self.companyIdArr[temp])
            }
        
        dropDown2 = DropDown()
        
        // The view to which the drop down will appear on
        dropDown2?.anchorView = comDetailBtn // UIView or UIBarButtonItem
        dropDown2?.bottomOffset = CGPoint(x: 0, y:(dropDown?.anchorView?.plainView.bounds.height)!)
        // The list of items to display. Can be changed dynamically
        dropDown2?.dataSource = comArr
        // Do any additional setup after loading the view.
        comDetailBtn.addTarget(self, action: #selector(dropDownButton2), for: .touchUpInside)
        
        dropDown2?.selectionAction = { [unowned self] (index: Int, item: String) in
            self.comDetailBtn.setTitle(item, for: .normal)
            print(item,"item")
            self.sendUpCompany = item
        }
        
        dropDown3 = DropDown()
        
        // The view to which the drop down will appear on
        dropDown3?.anchorView = comDetailBtn // UIView or UIBarButtonItem
        dropDown3?.bottomOffset = CGPoint(x: 0, y:(dropDown3?.anchorView?.plainView.bounds.height)!)
        // The list of items to display. Can be changed dynamically
        dropDown3?.dataSource = ["0","1","2"]
        // Do any additional setup after loading the view.
        confirmBtn.addTarget(self, action: #selector(dropDownButton3), for: .touchUpInside)
        
        dropDown3?.selectionAction = { [unowned self] (index: Int, item: String) in
            self.confirmBtn.setTitle(item, for: .normal)
            print(item,"item")
            self.sendConfirm = item
        }
        
        }
    @objc func dropDownButton(){
        dropDown?.show()
    }
    
    @objc func dropDownButton2(){
        dropDown2?.show()
    }
    
    @objc func dropDownButton3(){
        dropDown3?.show()
    }
    

    @IBAction func updateInfo(_ sender: Any) {
        let a = UpdateDetailUserNetworkHandler.getData(resource: "http://192.168.177.213:33018/UpdateDetailUsers", name: username.text!, phone: useremail.text!, email: userphone.text!, ocassion: userocassion.text!, confirm: sendConfirm, company_id: sendCompanyId, standard: String(userId))
     
        let alertController = UIAlertController(title: "유저 업데이트", message: "유저 정보 업데이트 완료", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
}

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


