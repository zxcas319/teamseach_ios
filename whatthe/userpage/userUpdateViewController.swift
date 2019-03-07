//
//  userUpdateViewController.swift
//  whatthe
//
//  Created by donggyukim on 05/03/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit

class UpdateUserNetworkHandler{
    
    class func getData(resource: String,name: String,login_pw: String,login_id: String,phone: String,email: String ) -> String {
        
        var a = String()
        
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)
        
        guard let url = URL(string: "\(resource)") else {
            print("URL is nil")
            return ""
        }
        
        // Request
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let postString = ["name": name,"login_id": login_id,"login_pw": login_pw,"phone": phone,"email": email]
        
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


class userUpdateViewController: UIViewController {
    var updateInfo = ""
    var userId = ""
    var userEmail = ""
    var userPhone = ""
    var userPw = ""
    var userName = ""
    
    var emailArr : [String] = []
    var phoneArr : [String] = []
    var namedArr : [String] = []
    var pwdArr : [String] = []
    
    @IBOutlet weak var namef: UITextField!
    
    @IBOutlet weak var pwf: UITextField!
    
    @IBOutlet weak var phonef: UITextField!
    @IBOutlet weak var emailf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let datas = updateInfo.data(using: .utf8){
            print(datas,"datas")
            let jsonT = try? JSONSerialization.jsonObject(with: datas, options:[]) as? [[String:Any]]
            
            
            //var confirmArr = [Int]()
            var email = [String]()
            var phone = [String]()
            var name = [String]()
            var pw = [String]()
            
            var usernumberArr = Set<String>()
            
            if let user = jsonT as? [[String: Any]]{
                
                for userIndex in user {
                    //confirmArr.append(userIndex["confirm"] as! Int)
                    
                    
                    email.append(userIndex["email"] as! String)
                    
                    phone.append(userIndex["phone"] as! String)
                    
                    name.append(userIndex["name"] as! String)
                    
                    pw.append(userIndex["login_pw"] as! String)
                    
                    print(user)
                }
                
            }
            
            // a = confirmArr[0]
            
            
            
            for item in email{
                emailArr.append(item)}
            
            for item in phone{
                phoneArr.append(item)}
            
            for item in pw{
                pwdArr.append(item)}
            
            for item in name{
                namedArr.append(item)}
        
            namef.text = namedArr[0]
            emailf.text = emailArr[0]
            pwf.text = pwdArr[0]
            phonef.text = phoneArr[0]
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func userUpdate(_ sender: Any) {
      UpdateUserNetworkHandler.getData(resource: "http://192.168.177.213:33018/user", name: namef.text!, login_pw: pwf.text!, login_id: userId, phone: phonef.text!, email: emailf.text!)
        
        let alertController = UIAlertController(title: "업데이트 완료", message: "정보 수정 완료 ", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
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
