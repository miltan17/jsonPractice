//
//  ViewController.swift
//  JSON Practice
//
//  Created by Miltan on 7/3/18.
//  Copyright © 2018 Milton. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let rawData = ["One", "Two", "Three"]
    var courses = [Courses]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        getCourse()
    }

    //MARK:- Parse Json Data
    func getCourse(){
        //Single element
//        let jsonURL = "http://api.letsbuildthatapp.com/jsondecodable/course"
        
        //Array as 1, 2, 3, 4
//        let jsonURL = "http://api.letsbuildthatapp.com/jsondecodable/courses"
        
        //Array as String: 1 2 3 4
        let jsonURL =  "http://api.letsbuildthatapp.com/jsondecodable/website_description"
        
        guard let url = URL(string: jsonURL) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { return }
            guard let data = data else{ return }
            
            do{
                //Single element
//                guard let jsonSingle = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
//                let course = Courses(json: jsonSingle)
//                self.courses.append(course)
//                print(self.courses)
                
                
                //Array as 1, 2, 3, 4
//                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject] else { return }
//                
//                if let coursesArray: [AnyObject] = jsonArray {
//                    for index in 0...coursesArray.count-1 {
//                        let object = coursesArray[index] as! [String: AnyObject]
//                        let course = Courses(id: object["id"] as! Int, name: object["name"] as! String, link: object["link"] as! String, imageUrl: object["imageUrl"] as! String)
//                        self.courses.append(course)
//                    }
//                }
                
                //Array as String: 1 2 3 4
                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                
                if let coursesArray = jsonArray["courses"] {
                    for index in 0...coursesArray.count-1 {
                        let object = coursesArray[index] as! [String: AnyObject]
                        let course = Courses(id: object["id"] as! Int, name: object["name"] as! String, link: object["link"] as! String, imageUrl: object["imageUrl"] as! String)
                        self.courses.append(course)
                    }
                }
                
                
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch let err{
                print(err)
            }
        }
        task.resume()
    }
    
    //MARK:- TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
//        cell.textLabel?.text = rawData[indexPath.row]
        cell.textLabel?.text = courses[indexPath.row].name
        return cell
    }
}

struct Courses{
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        link = json["link"] as? String ?? ""
        imageUrl = json["imageUrl"] as? String ?? ""
    }
    
    init(id: Int, name: String, link: String, imageUrl:String) {
        self.id = id
        self.name = name
        self.link = link
        self.imageUrl = imageUrl
    }
}























