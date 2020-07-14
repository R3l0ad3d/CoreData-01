//
//  ViewController.swift
//  CoreData-01
//
//  Created by Joy Reloaded on 11/7/20.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var dataList = Array<User>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fatch()
    }

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

extension ViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let obj = dataList[indexPath.row]
        cell.lblTitle.text = obj.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = dataList[indexPath.row]
        let devices = self.storyboard?.instantiateViewController(identifier: "DevicesViewController") as! DevicesViewController
        devices.owner = obj
        self.navigationController?.pushViewController(devices, animated: true)
    }
}

extension ViewController{
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
        NSEntityDescription.entity(forEntityName: "User",
                                   in: managedContext)!
      
      let person = User(entity: entity,
                                   insertInto: managedContext)
      
      // 3
        person.name = name
      // 4
      do {
        try managedContext.save()
        dataList.append(person)
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
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
            
          
          //3
          do {
            dataList = try managedContext.fetch(fetchRequest)
            tableView.reloadData()
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
}
