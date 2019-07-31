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
    var postString = "Hello from iOS Developer! Week II"
    
    var gistElemList = [GistFile]()
    var newList = [GistFile]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
         postDataToServer()
         updatePrivateData()
        

    }
    private func postDataToServer(){
        let component = URLComponents(string: "https://api.github.com/gists")
        guard let urlPost = component?.url else {return}
        var requestPost = URLRequest(url: urlPost)
        requestPost.httpMethod = "POST"
        
        //requestPost.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestPost.setValue("token \(token)", forHTTPHeaderField: "Authorization" )
        
        requestPost.httpBody = try! JSONSerialization.data(withJSONObject: ["description":"Stepik week2 POST II", "public": true, "files": ["stepik_iOS_w2_2.txt":["content":postString]]])
        
        let taskPost = URLSession.shared.dataTask(with: requestPost) { (data, response, error) in
            if error != nil{
                print("No Error!")
            }
        //print(response)
            if let response = response as? HTTPURLResponse{
                print(response.statusCode)
            }
        }
        taskPost.resume()
        
//        "{
//        "description": "Hello World Examples",
//        "public": true,
//        "files": {
//            "hello_world.rb": {
//                "content": "class HelloWorld\n   def initialize(name)\n      @name = name.capitalize\n   end\n   def sayHi\n      puts \"Hello !\"\n   end\nend\n\nhello = HelloWorld.new(\"World\")\nhello.sayHi"
//            },
//            "hello_world.py": {
//                "content": "class HelloWorld:\n\n    def __init__(self, name):\n        self.name = name.capitalize()\n       \n    def sayHi(self):\n        print \"Hello \" + self.name + \"!\"\n\nhello = HelloWorld(\"world\")\nhello.sayHi()"
//            },
//            "hello_world_ruby.txt": {
//                "content": "Run `ruby hello_world.rb` to print Hello World"
//            },
//            "hello_world_python.txt": {
//                "content": "Run `python hello_world.py` to print Hello World"
//            }
//        }
//    }"
        
        
        
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
                print(error)
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
