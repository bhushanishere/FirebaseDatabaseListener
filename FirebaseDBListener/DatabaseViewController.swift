//
//  DatabaseViewController.swift
//  FirebaseDBListener
//
//  Created by Bhushan  Borse on 14/12/19.
//  Copyright © 2019 Bhushan  Borse. All rights reserved.
//

import UIKit
import SwiftyJSON
import FirebaseDatabase

struct databaseModel : Codable {
    let userName : String
}

class DatabaseViewController: UITableViewController {
    
    var dbReferrance        : DatabaseReference!
    var databaseObjectArray : [databaseModel] = []
    let cellReuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Firebase Database"
        
        dbReferrance = Database.database().reference()
        getListenerForFirebaseDatabase()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
           
           
    func getListenerForFirebaseDatabase()  {
        dbReferrance.observe(DataEventType.value, with: { (snapshot) in
            let postDict = JSON(snapshot.value ?? [])
            guard postDict["users"].count != 0 else {
                return
            }
            
            self.databaseObjectArray = []
            for objectData in postDict["users"].arrayValue {
                let obj = databaseModel.init(userName: objectData["username"].stringValue)
                self.databaseObjectArray.append(obj)
            }
            
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return databaseObjectArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = databaseObjectArray[indexPath.row].userName

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

