//
//  TaskModel.swift
//  BucketList
//
//  Created by A Ab. on 07/06/1443 AH.
//

import Foundation

class TaskModel {
    
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
            if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to POST
                request.httpMethod = "POST"
                // Create some bodyData and attach it to the HTTPBody
                let bodyData = "objective=\(objective)"
                request.httpBody = bodyData.data(using: .utf8)
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
    
    static func updateTask(id: Int,objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {

            if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to POST
                request.httpMethod = "PUT"
                request.allHTTPHeaderFields = [
                                    "Content-Type": "application/json",
                                    "Accept": "application/json"
                                ]
              let jsonDictionary: [String: String] = [
                    "objective": objective,
                                ]
                do{
                let bodyData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
                request.httpBody = bodyData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                    
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                    task.resume()
                }catch{
                    
                }
            }
    }
    
    static func deleteTask(id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
                if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/") {
                    var request = URLRequest(url: urlToReq)
                    request.httpMethod = "DELETE"
                    let bodyData = "id\(id)"
                    request.httpBody = bodyData.data(using: String.Encoding.utf8)
                    
                    let session = URLSession.shared
                    let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                    task.resume()
                }
        }
    
}
