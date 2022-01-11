//
//  AddItemTableViewController.swift
//  BucketList
//
//  Created by A Ab. on 16/05/1443 AH.
//

import UIKit


class AddItemTableViewController: UITableViewController {
    
    @IBOutlet weak var items: UITextField!
    
    var delegate: ViewController?
    var taskType: TaskType?
    var edittedItem: NSDictionary?
    var indexPath: IndexPath?
    var taskId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        items.text = edittedItem?.value(forKey: "objective") as? String
     
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        guard let text = items.text else {return}
        
        switch taskType{
            
        case .add:
            TaskModel.addTaskWithObjective(objective: text, completionHandler: {
                data, response, error in
                do {
                     let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    
                    DispatchQueue.main.async {
                        self.delegate?.taskItems?.append(tasks!)
                        self.delegate?.tableView.reloadData()
                        self.navigationController?.popViewController(animated: true)
                    }
                  
                } catch {
                    print("Something went wrong")
                }
            })
        
        case .edit:
            edittedItem?.setValue(text, forKey: "objective")
            TaskModel.updateTask(id: taskId, objective: text, completionHandler: { data, response, error in
      
                do {
                     let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    
                    DispatchQueue.main.async {
                        self.delegate?.taskItems![self.indexPath!.row] = tasks!
                        self.delegate?.tableView.reloadData()
                        self.navigationController?.popViewController(animated: true)
                    }
                  
                } catch {
                    print("Something went wrong")
                }
            })
            
            
            
            
        case .none:
            print("No tasks")
            
        }
            
           
    }
}
