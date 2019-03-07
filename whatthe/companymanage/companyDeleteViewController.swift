//
//  companyDeleteViewController.swift
//  whatthe
//
//  Created by donggyukim on 26/02/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit

class companyDeleteViewController: UIViewController,


UITableViewDelegate, UITableViewDataSource {
    let arr = ["1","2","3","4"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
     
    }

}
