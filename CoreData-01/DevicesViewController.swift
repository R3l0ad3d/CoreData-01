//
//  DevicesViewController.swift
//  CoreData-01
//
//  Created by Joy Reloaded on 13/7/20.
//

import UIKit
import CoreData

class DevicesViewController: UITableViewController {
    
    var owner : User?
    var devicesList = Array<Device>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        fatch()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return devicesList.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        // Configure the cell...
        let obj = devicesList[indexPath.row]
        cell.lblTitle.text = obj.device
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "Add", message: "", preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "add name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { action -> Void in
            
            let textfield =  alert.textFields?.first
            self.save(name: (textfield?.text)!)
            print(textfield?.text as Any)
            alert.dismiss(animated: true) {
                
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )
        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
    
}

extension DevicesViewController{
    func save(name: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Device",
                                   in: managedContext)!
      
      let device = Device(entity: entity,
                                   insertInto: managedContext)
        
      // 3
        device.device = name
        device.owner = owner
        
        
      // 4
      do {
        try managedContext.save()
        devicesList.append(device)
        tableView.reloadData()
        print("data save")
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func fatch()  {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
        
        
          //2
        let fetchRequest : NSFetchRequest<Device> = Device.fetchRequest()
            
          
          //3
          do {
            let dataList = try managedContext.fetch(fetchRequest).filter({ (device) -> Bool in
                return device.owner == owner
            })
            
            devicesList = dataList
            tableView.reloadData()
            print("fetch data : \(devicesList.count)")
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
}
