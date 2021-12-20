//
//  AddItemTableViewController.swift
//  BucketList
//
//  Created by A Ab. on 16/05/1443 AH.
//

import UIKit

protocol SecondVCDelegate{
    func addItem(text: String)
    func editItem(text: String, indexPath: IndexPath?)
}

class AddItemTableViewController: UITableViewController {
    
    @IBOutlet weak var items: UITextField!
    var delegate: SecondVCDelegate?
    var edittedItem: String?
    var indexPath: IndexPath?
    var taskType: TaskType?

    override func viewDidLoad() {
        super.viewDidLoad()
        items.text = edittedItem
     
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        guard let text = items.text else {return}
        
        switch taskType{
        case .add:
            delegate?.addItem(text: text)
            
        case .edit:
            delegate?.editItem(text: text, indexPath: indexPath)
            
        case .none:
            print("No tasks")
        }
       
        self.navigationController?.popViewController(animated: true)
        
    }

}
