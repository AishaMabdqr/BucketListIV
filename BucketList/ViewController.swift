//
//  ViewController.swift
//  BucketList
//
//  Created by A Ab. on 16/05/1443 AH.
//

import UIKit

enum TaskType{
    case add
    case edit
}

class ViewController: UITableViewController {
    
    var items : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
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
        vc.edittedItem = items[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    

}

extension ViewController: SecondVCDelegate{
    func addItem(text: String) {
        items.append(text)
        tableView.reloadData()
    }
    
    func editItem(text: String, indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }

        items[indexPath.row] = text
        tableView.reloadData()
    }
}
