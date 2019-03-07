//
//  companyDeleteTableViewController.swift
//  whatthe
//
//  Created by donggyukim on 26/02/2019.
//  Copyright © 2019 donggyukim. All rights reserved.
//

import UIKit

class companyDeleteTableViewController:

    
    
    
UITableViewController {

    var dataList = [[String:String]]()
    /*
     Dictionary를 배열로 갖는 데이터 구조.
     */
    
    var weather:[String] =
        ["cloud", "snowflake", "sun", "umbrella", "wind"]
    /*
     보다 편리하게 사용하기 위해 날씨의 종류를 날씨 아이콘 파일명과 일치시켰습니다.
     */
    
    var area:[String] =
        ["서울", "뉴욕", "도쿄", "런던", "다낭", "바르셀로나", "파리", "샌프란시스코", "보라카이", "모스크바", "베를린"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0...area.count-1{
            dataList.append( [ "area":area[index], "weather":weather[index % weather.count] ] )
        }
        
        /*
         사용할 데이터들을 반복해서 넣는 코드
         */
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "Cell",
                for: indexPath
        )
        
        let currentRowOfList = dataList[indexPath.row]
        let currentWeatherInfo = currentRowOfList["weather"]
        
        cell.textLabel?.text = currentRowOfList["area"]
        cell.detailTextLabel?.text = currentWeatherInfo
        
        switch currentWeatherInfo! {
        case "cloud":
            cell.imageView?.image = UIImage(named: "cloud.png")
        case "sun":
            cell.imageView?.image = UIImage(named: "sun.png")
        case "snowflake":
            cell.imageView?.image = UIImage(named: "snowflake.png")
        case "umbrella":
            cell.imageView?.image = UIImage(named: "umbrella.png")
        case "wind":
            cell.imageView?.image = UIImage(named: "wind.png")
        default:
            print("No Match Image")
        }
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
