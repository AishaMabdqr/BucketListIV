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
    
    var taskItems : [NSDictionary]? = []
    var taskId = 0
    var indexPath : IndexPath?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    
        //Get data
        TaskModel.getAllTasks(completionHandler: {
            data, response, error in
            do {
                if let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray{
                    print(tasks)
                
                    for task in tasks {
                        let taskDict = task as! NSDictionary
                        self.taskItems?.append(taskDict)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                 }
            } catch {
                print("Something went wrong")
            }
        })
      }
        
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = taskItems?[indexPath.row]["objective"] as? String
        return cell
    }
    
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "secondVC") as! AddItemTableViewController
        vc.delegate = self
        vc.taskType = .add
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "secondVC") as! AddItemTableViewController
        let id = taskItems?[indexPath.row].value(forKey: "id")
        
        vc.delegate = self
        vc.taskType = .edit
        vc.indexPath = indexPath
        vc.edittedItem = taskItems?[indexPath.row]
        vc.taskId = id as! Int
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let id = taskItems?[indexPath.row].value(forKey: "id") as! Int
        TaskModel.deleteTask(id: id, completionHandler: {
            data, response, error in
                print("")
            })
        taskItems?.remove(at: indexPath.row)
        tableView.reloadData()
    }

}

