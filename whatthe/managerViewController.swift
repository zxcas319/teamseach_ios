//
//  managerViewController.swift
//  whatthe
//
//  Created by donggyukim on 25/02/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit

class selectUSerDataNetworkHandler{
    
    class func getData(resource: String) -> String {
        
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
            //print(a,"sencond")
            dataTask.resume()
        }
        print(a,"third")
        let reuslt = group.wait(timeout: .distantFuture)
        
        print("\(reuslt)")
        return a
    }
}


class managerViewController: UIViewController {

    @IBOutlet weak var managelabel: UILabel!
    var viewkey = ""
    var b = ""
    var usercompany = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(viewkey == "1"){
           let dest = segue.destination as! companyAdminViewController
        }
        
        else if(viewkey == "2"){
        let dest = segue.destination as! companyUserViewController
            dest.userInfo = usercompany
        }
        
    }
    
    @IBAction func companyAdmin(_ sender: Any) {
        viewkey = "1"
        self.performSegue(withIdentifier: "companyAdmin", sender: self)
    }
    
    @IBAction func userCompany(_ sender: Any) {
        viewkey = "2"
        let a = selectUSerDataNetworkHandler.getData(resource: "http://192.168.177.213:33018/viewUser")
        usercompany = a
    self.performSegue(withIdentifier: "usercompany", sender: self)
        
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
