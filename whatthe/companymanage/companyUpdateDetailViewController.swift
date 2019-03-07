//
//  companyUpdateDetailViewController.swift
//  whatthe
//
//  Created by donggyukim on 04/03/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit

class UpdateDataNetworkHandler{
    
    class func getData(resource: String,company: String,up_company: String, standard: String ) -> String {
        
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
        let postString = ["company": company,"up_company": up_company, "standard":standard]
        
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


class companyUpdateDetailViewController: UIViewController {
    
    @IBOutlet weak var companytb: UITextField!
    
    @IBOutlet weak var upcompanytb: UITextField!
    var company = ""
    var up_company = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companytb.text = company
        upcompanytb.text = up_company
        // Do any additional setup after loading the view.
        
        
    }
    

    @IBAction func companyUpdatebtn(_ sender: Any) {
        var updateCompanyInfo = companytb.text
        var updateUpCompanyInfo = upcompanytb.text
        let a = UpdateDataNetworkHandler.getData(resource: "http://192.168.177.213:33018/UpdateDetailCompany",company: updateCompanyInfo!,up_company: updateUpCompanyInfo!,standard: company )
        
        let alertController = UIAlertController(title: "부서 업데이트", message: "부서 정보 업데이트 완료", preferredStyle: .alert)
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
