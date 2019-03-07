//
//  ViewController.swift
//  whatthe
//
//  Created by donggyukim on 19/02/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

//
//  ViewController.swift
//  test1
//
//  Created by donggyukim on 12/02/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit


class NetworkHandler{
    
    
    class func getData(resource: String,id: String, pw: String,temp1: String ) -> String {
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
        let postString = ["id": id, "pw": pw]
        
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

class ViewController: UIViewController {
    
    @IBOutlet weak var loginId: UITextField!
    @IBOutlet weak var loginPw: UITextField!
    var temp12 = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if (temp12 == "1"){
        let dest = segue.destination as! secondeViewController
    
        //dest.testlabel.text = temp12
        dest.b = loginId.text!
        
    }
    
    if (temp12 == "2"){
        let dest = segue.destination as! managerViewController
        dest.b = temp12
        //dest.testlabel.text = temp12
        
        
    }
    
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        
        
        let userId = loginId.text
        let userPw = loginPw.text
        
        
        let a = NetworkHandler.getData(resource: "http://192.168.177.213:33018/main",id: userId!,pw: userPw!,temp1: temp12)
        print(a,"aaaa")
        temp12 = a
        
        if(a == "0"){
            let alertController = UIAlertController(title: "회원가입 인증 단계", message: "등록되지 않은 사용자 입니다", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        
        else if(a == "1"){
            self.performSegue(withIdentifier: "tsegue", sender: self)
        }
        else if (a == "2"){
            self.performSegue(withIdentifier: "managePage", sender: self)
        }
        else{
            let alertController = UIAlertController(title: "가입되지 않은 사용자이거나 회원정보가 불일치", message: "회원가입을 하거나 회원정보를 정확히 입력하세요", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        
    }//button
    
    
}


