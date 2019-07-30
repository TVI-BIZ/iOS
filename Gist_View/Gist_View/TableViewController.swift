//
//  TableViewController.swift
//  Gist_View
//
//  Created by Vlad Tagunkov on 29/07/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet var myTable: UITableView!
    
    private var token: String = "###"
    var gistElemList = [GistFile]()
    var newList = [GistFile]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
         updatePrivateData()

    }
    private func updatePrivateData() {
        let componnetsPrivate = URLComponents(string: "https://api.github.com/users/TVI-BIZ/gists")
        guard let urlPriv = componnetsPrivate?.url else {return}
        var requestPriv = URLRequest(url: urlPriv)
        requestPriv.setValue("token \(token)", forHTTPHeaderField: "Authorization" )
        
        let taskPriv = URLSession.shared.dataTask(with: requestPriv) { (data, response, error) in
            guard let data = data else {return}
            //let dataString = String(data: data, encoding: .utf8)
            do {
                self.newList = try JSONDecoder().decode([GistFile].self, from: data)
                print(self.newList[0].url ?? 00)
                print(self.newList[0].description ?? 00)
                print(self.newList[1].url ?? 00)
                print(self.newList[1].description ?? 00)
                self.gistElemList = self.newList
                
                DispatchQueue.main.async {
                    self.myTable.reloadData()
                }
                
            } catch let error {
            }
        }
        taskPriv.resume()
        //myTable.reloadData()
    }
    
    
 
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newList.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        //cell.comments.text = gistElemList
        cell.comments.text = String(newList[indexPath.row].comments!)
        cell.creationDate.text = newList[indexPath.row].created_at
        cell.gistURL.text = newList[indexPath.row].description
       

        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
