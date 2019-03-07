//
//  enrollViewController.swift
//  whatthe
//
//  Created by donggyukim on 05/03/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit

class enrollNetworkHandler{
    
    
    class func getData(resource: String,login_id: String,login_pw: String,phone: String,email: String, name: String) -> String {
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
        
        let postString = ["login_id": login_id, "login_pw": login_pw,"phone": phone,"email": email,"name":name]
        
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

class enrollViewController: UIViewController {

    @IBOutlet weak var idInput: UITextField!
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var pwInput: UITextField!
    
    @IBOutlet weak var pwInputConfirm: UITextField!
    
    @IBOutlet weak var phoneInput: UITextField!
    
    @IBOutlet weak var emailInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func enrollBtn(_ sender: Any) {
        
        if (pwInput.text! != "" && pwInput.text! == pwInputConfirm.text!){
          enrollNetworkHandler.getData(resource: "http://192.168.177.213:33018/user", login_id: idInput.text!, login_pw: pwInput.text!, phone: phoneInput.text!, email: emailInput.text!, name: nameInput.text!)
            let alertController = UIAlertController(title: "회원가입 완료", message: "매인페이지로 돌아가세요 ", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        else{
            let alertController = UIAlertController(title: "비밀번호 불일치", message: "비밀번호를 확인하세요 ", preferredStyle: .alert)
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

}
