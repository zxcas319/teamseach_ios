//
//  secondeViewController.swift
//  whatthe
//
//  Created by donggyukim on 20/02/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit

class getUserDataNetworkHandler{
    
    class func getData(resource: String,login_id: String) -> String {
        
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
        let postString = ["login_id": login_id]
        
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

class UpdateUserIdNetworkHandler{
    
    class func getData(resource: String,login_id:String ) -> String {
        
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
        
        
        let postString = ["login_id": login_id]
        
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

class selectSessionNetworkHandler{
    
    class func getData(resource: String ) -> String {
        
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
        
        
        let postString = ["loginId": "1"]
        
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


class sessionOutNetworkHandler{
    
    class func getData(resource: String,login_id:String ) -> String {
        
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
        
        
        let postString = ["login_id": login_id]
        
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

class secondeViewController: UIViewController {
    
    

    
    @IBOutlet weak var asd: UILabel!
    var b = ""
    var temp = "0"
    var updateInfo = ""
    var sssionId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         UpdateUserIdNetworkHandler.getData(resource: "http://192.168.177.213:33018/sessionUser", login_id: b)
        
        sssionId = selectSessionNetworkHandler.getData(resource: "http://192.168.177.213:33018/selectSession")
        
        asd.text = sssionId + " 사용자님 환영합니다."
        
        
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(temp == "1"){
            let dest = segue.destination as! companyFIndViewController
        }
        
        else if (temp == "2"){
            let dest = segue.destination as! userUpdateViewController
            dest.updateInfo = updateInfo
            dest.userId = sssionId
        }
        else if (temp == "3"){
            let dest = segue.destination as! ViewController
            
        }
    }
    
    @IBAction func findBtn(_ sender: Any) {
        temp = "1"
        self.performSegue(withIdentifier: "find", sender: self)
    }
    @IBAction func updateBtn(_ sender: Any) {
        temp = "2"
        let c =  getUserDataNetworkHandler.getData(resource: "http://192.168.177.213:33018/editInfo", login_id: sssionId)
        updateInfo = c
        self.performSegue(withIdentifier: "userUpdate", sender: self)
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        
        temp = "3"
        
        sessionOutNetworkHandler.getData(resource: "http://192.168.177.213:33018/sessionOut", login_id: sssionId)
        
        self.performSegue(withIdentifier: "logout", sender: self)
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
