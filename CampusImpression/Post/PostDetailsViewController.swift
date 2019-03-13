//
//  PostDetailsViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/12/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class PostDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {

    let commentBar = MessageInputBar();
    var postId: String!
    var showsCommentBar = false
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 400

        self.tableView.tableFooterView = UIView()

        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Your date Format"
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadPosts()
    }
    
    @objc func loadPosts() {
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.whereKey("objectId", equalTo: postId)
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }

    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()

        selectedPost.add(comment, forKey: "comments")

        selectedPost.saveInBackground { (success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error saving comment")
            }
        }

        tableView.reloadData()

        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        let imageFile = (post["image"] as? PFFileObject) ?? nil
        if imageFile == nil {
            return comments.count + 3
        }
        else {
            return comments.count + 4
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //        cell.layer.borderWidth = 2.0
        //        cell.layer.borderColor = UIColor.gray.cgColor
        let post = posts[indexPath.section]
        let imageFile = (post["image"] as? PFFileObject) ?? nil
        let comments = post["comments"] as? [PFObject] ?? []

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCell") as! PostDetailCell
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoDetailCell") as! PhotoDetailCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            let urlString = imageFile!.url!
            let url = URL(string: urlString)!
            cell.photoView.af_setImage(withURL: url) //you have to import alamofireimage!!!
            return cell
        }
        else if indexPath.row == 1 && imageFile == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionDetailCell") as! ActionDetailCell
            return cell
        }
        else if indexPath.row == 2 && imageFile != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionDetailCell") as! ActionDetailCell
            return cell
        }
        else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            let comment = comments[indexPath.row-2]
            print(comment)
            cell.commentLabel.text = comment["text"] as? String
            let user = comment["author"] as! PFUser
            cell.nameLabel.text = user.username

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        if indexPath.row == comments.count + 3 {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
            
            selectedPost = post
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
