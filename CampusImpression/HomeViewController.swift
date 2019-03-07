//
//  HomeViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 2/23/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    var postslimit = 20
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 400
        
        myRefreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
        self.tableView.tableFooterView = UIView()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Your date Format"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadPosts()
    }
    
    // Implement the delay method
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    @objc func loadPosts() {
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        
        let filter = UserDefaults.standard.string(forKey: "Filter")
        if filter != nil && filter != "All" {
            query.whereKey("tag", equalTo: filter!)
        }
        query.order(byDescending: "createdAt")
        query.limit = postslimit
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
        run(after: 2) {
            self.myRefreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let imageFile = (post["image"] as? PFFileObject) ?? nil
        if imageFile == nil {
            return 2
        }
        else {
            return 3
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section + 1 == posts.count {
            loadMorePosts()
        }
    }
    
    func loadMorePosts() {
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        let filter = UserDefaults.standard.string(forKey: "Filter")
        if filter != nil {
            query.whereKey("tag", equalTo: filter!)
        }
        query.order(byDescending: "createdAt")
        postslimit = postslimit + 20
        query.limit = postslimit
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        cell.layer.borderWidth = 2.0
//        cell.layer.borderColor = UIColor.gray.cgColor

        let post = posts[indexPath.section]
        let imageFile = (post["image"] as? PFFileObject) ?? nil

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            
            let user = post["author"] as! PFUser
            cell.postTag.text = "#\(String(describing: post["tag"] as! String))"
            
            // substract timePosted from currentTime
            let currTime = Date()
            let postedTime = post["postedTime"] as? Date
            if postedTime != nil {
                let calendar = Calendar.current
                let timeDiff = calendar.dateComponents([.hour, .minute], from: postedTime!, to: currTime)
                if timeDiff.hour! < 1 {
                    cell.postedBy.text = "\(String(describing: timeDiff.minute!)) mins ago by \(String(describing: user.username!))"
                } else {
                    cell.postedBy.text = "\(String(describing: timeDiff.hour!)) hrs ago by \(String(describing: user.username!))"
                }
            } else {
                cell.postedBy.text = user.username
            }
            cell.postTitle.text = (post["postTitle"] as! String)
            cell.postPreview.text = (post["postContents"] as! String)
            
            return cell
        }
        else if indexPath.row == 1 && imageFile != nil{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            let urlString = imageFile!.url!
            let url = URL(string: urlString)!
            cell.photoView.af_setImage(withURL: url) //you have to import alamofireimage!!!
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell") as! ActionCell
            return cell
        }
    }
}
