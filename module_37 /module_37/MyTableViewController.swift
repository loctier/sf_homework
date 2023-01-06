//
//  MyTableViewController.swift
//  module_37
//
//  Created by Denis Loctier on 02/01/2023.
//

import UIKit
import Kingfisher

class MyTableViewController: UITableViewController {
    
    @IBOutlet var newsTableView: UITableView!
    
    var articlesList = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
        let anonymousFunction = {(articlesList: [Article]) in
            DispatchQueue.main.async {
                self.articlesList = articlesList
                self.newsTableView.reloadData()
            }
        }
        NewsAPI.shared.fetchNews(onCompletion: anonymousFunction)
    }
}


extension MyTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyTableViewCell
        
        cell.newsTitle.text = articlesList[indexPath.row].title
        cell.newsSource.text = articlesList[indexPath.row].source?.name
        
        let newsImageString = articlesList[indexPath.row].urlToImage
        
        let newsImageUrl = URL(string: newsImageString)
        
        cell.newsImage.kf.setImage(with: newsImageUrl)
        
        return cell
    }
    
}
