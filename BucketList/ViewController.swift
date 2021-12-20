//
//  ViewController.swift
//  BucketList
//
//  Created by A Ab. on 16/05/1443 AH.
//

import UIKit
import CoreData

enum TaskType{
    case add
    case edit
}

class ViewController: UITableViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items : [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
    }
    
    func fetchItems(){
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do{
            let results = try managedObjectContext.fetch(itemRequest)
            items = results as! [Item]
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    func saveContext(){
        do{
            try managedObjectContext.save()
        }catch {
            print(error)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text
        return cell
    }
    
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "secondVC") as! AddItemTableViewController
        vc.taskType = .add
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "secondVC") as! AddItemTableViewController
        vc.taskType = .edit
        vc.delegate = self
        vc.indexPath = indexPath
        vc.edittedItem = items[indexPath.row].text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        saveContext()
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    

}

extension ViewController: SecondVCDelegate{
    func addItem(text: String) {
        let newItemEntity = Item(context: managedObjectContext)
        newItemEntity.text = text
        saveContext()
        
        items.append(newItemEntity)
        tableView.reloadData()
    }
    
    func editItem(text: String, indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }

        items[indexPath.row].text = text
        saveContext()
        tableView.reloadData()
    }
}
