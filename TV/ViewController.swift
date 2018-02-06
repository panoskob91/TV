//
//  ViewController.swift
//  TV
//
//  Created by Paagiotis  Kompotis  on 05/02/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import UIKit

class Show {
    let imageURL: String?
    let title: String
    let averageRating: Float?
    let summary: String?
    
    init(title: String, averageRating: Float?, summary: String?, imageURL: String?) {
        self.title = title
        self.averageRating = averageRating
        self.summary = summary
        self.imageURL = imageURL
    }
}


class ViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate, UITableViewDelegate {

    @IBOutlet var searchBar: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var TVShowsTable: UITableView!
   
    var shows: [Show] = [Show]()
    
    
    
    let CELLID: String = "CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UIGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        TVShowsTable.dataSource = self
        TVShowsTable.delegate = self
        TVShowsTable.tableFooterView = UIView()
        //TVShowsTable.rowHeight = 100
        TVShowsTable.rowHeight = 500
        TVShowsTable.estimatedRowHeight = UITableViewAutomaticDimension
        
        searchBar.delegate = self
        
        
        setupSearchButton()
        setupSearchBar()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SearchButtonPressed(_ sender: UIButton) {
        if let searchText = searchBar.text{
            var userQueryUrl: String = "http://api.tvmaze.com/search/shows?q=\(searchText)"
            userQueryUrl = userQueryUrl.replacingOccurrences(of: " ", with: "+")
            parseJSON(url: userQueryUrl)
        }
        
        dismissKeyboard()
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let searchText = searchBar.text{
            var userQueryUrl: String = "http://api.tvmaze.com/search/shows?q=\(searchText)"
            userQueryUrl = userQueryUrl.replacingOccurrences(of: " ", with: "+")
            parseJSON(url: userQueryUrl)
        }
        
        dismissKeyboard()
            return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        dismissKeyboard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
        
    }
    
    @objc func dismissKeyboard(){
        searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath) as! TVShowCell
        cell.titleLabel.text = "Title: " + shows[indexPath.row].title
        if let average = shows[indexPath.row].averageRating{
            cell.averageLabel.text = "Average: " + String(describing: average)
            cell.averageLabel.font = UIFont(name: "Ananda Personal Use.ttf", size: 17)
        }
        if (shows[indexPath.row].averageRating == nil){
            cell.averageLabel.text = ""
        }
        if let summary = shows[indexPath.row].summary{
            cell.summaryLabel.text = "Summary: " + summary
            cell.summaryLabel.font = UIFont(name: "Ananda Personal Use.ttf", size: 16)
        }
        cell.summaryLabel.numberOfLines = 0
        
        cell.img.contentMode = .scaleAspectFill
        
        let imageURL = shows[indexPath.row].imageURL
        if (imageURL != nil){
            let imgUrl = URL(string: shows[indexPath.row].imageURL!)
            cell.img.image = UIImage(data: try! Data(contentsOf: imgUrl!))
        }else{
            cell.img.image = UIImage(named: "emptyimage")
        }
                return cell
    }
    
    func parseJSON(url: String) {
        let urlRequest = URL(string: url)
        
        //empty array
        if (!shows.isEmpty){
            shows = []
        }
        
        URLSession.shared.dataTask(with: urlRequest!) { (data, response, error) in
            if (error != nil ){
                print(error!)
            }else{
                if let data = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:AnyObject]]
                        //print(jsonObject)
                        for index in 0..<jsonObject.count{
                            let title = jsonObject[index]["show"]!["name"] as! String
                            let average = (jsonObject[index]["show"]!["rating"] as AnyObject)["average"] as? Float
                            var summary = jsonObject[index]["show"]!["summary"] as? String
                            let imageURL = (jsonObject[index]["show"]!["image"] as AnyObject)["medium"] as? String
                            summary = summary?.plainTextFromHTML()
                            
                            let show = Show(title: title, averageRating: average, summary: summary, imageURL: imageURL)
                            
                            self.shows.append(show)
                            //if let imgURL = imageURL{
                            //    print(imgURL)
                            //}
                                DispatchQueue.main.async {
                                    self.TVShowsTable.reloadData()
                                }
                            
                        }
                        
                        
                    }catch let err{
                        print(err)
                    }
                }
            }
            
            
        }.resume()
    }
    
    func setupSearchButton(){
        searchButton.layer.cornerRadius = 5
        searchButton.backgroundColor = UIColor.rgb(r: 242, g: 242, b: 242, alpha: 1)
    }
    func setupSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = UIColor.rgb(r: 250, g: 250, b: 250, alpha: 1)
        let color = UIColor.rgb(r: 51, g: 51, b: 51, alpha: 1)
        searchBar.attributedPlaceholder = NSAttributedString(string: searchBar.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : color])
    }
    
}

