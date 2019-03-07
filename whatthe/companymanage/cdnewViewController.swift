//
//  cdnewViewController.swift
//  whatthe
//
//  Created by donggyukim on 26/02/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit

class sendDeleteDataNetworkHandler{

    class func getData(resource: String,company: String) -> String {
        
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
        let postString = ["delInfo": company]
        
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

class cdnewViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    var arr : [String] = []
    var companyinfo = ""
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if let datas = companyinfo.data(using: .utf8){
            print(datas,"datas")
            let jsonT = try? JSONSerialization.jsonObject(with: datas, options:[]) as? [[String:Any]]
            
            
            //var confirmArr = [Int]()
            var adminArr = [String]()
            var usernumberArr = Set<String>()
            
            if let user = jsonT as? [[String: Any]]{
                
                for userIndex in user {
                    //confirmArr.append(userIndex["confirm"] as! Int)
                    
                   adminArr.append(userIndex["company"] as! String)
                    
                    usernumberArr.insert(userIndex["up_company"] as! String)
                    print(user)
                }
                
            }
            
            // a = confirmArr[0]
         
            arr.removeAll()
            
            for item in usernumberArr{
                arr.append(item)}
           
            for item in adminArr{
                arr.append(item)}
            
        }
        
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
        
        var deleteCompany = currentItem!
        
        let a = sendDeleteDataNetworkHandler.getData(resource: "http://192.168.177.213:33018/companyDelete",company: deleteCompany)
        
        self.performSegue(withIdentifier: "backFromDelete", sender: self)
       
    }
    
    
    @IBAction func btnaction(_ sender: Any) {
       // self.tableView.isHidden = !self.tableView.isHidden
    }
    
}
