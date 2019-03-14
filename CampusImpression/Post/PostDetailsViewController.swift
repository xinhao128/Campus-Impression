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
    
    @IBOutlet weak var tag: UILabel!
    @IBOutlet weak var postedBy: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var photoViewHeight: NSLayoutConstraint!
    
    let commentBar = MessageInputBar();
    var selectedPost: PFObject!
    var showsCommentBar = false
    
    var comments = [PFObject]()
    let myRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedPost!)
        loadCurrentPost()
        loadComments()
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self

        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        
        myRefreshControl.addTarget(self, action: #selector(loadComments), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
//        self.tableView.tableFooterView = UIView()

        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    func loadCurrentPost() {
        let user = selectedPost["author"] as! PFUser
        tag.text = "#\(String(describing: selectedPost["tag"] as! String))"
        
        // substract timePosted from currentTime
        let currTime = Date()
        let postedTime = selectedPost["postedTime"] as? Date
        if postedTime != nil {
            let calendar = Calendar.current
            let timeDiff = calendar.dateComponents([.day, .hour, .minute], from: postedTime!, to: currTime)
            if timeDiff.hour! < 1 {
                postedBy.text = "\(String(describing: timeDiff.minute!)) mins ago by \(String(describing: user.username!))"
            } else if timeDiff.day! < 1 {
                postedBy.text = "\(String(describing: timeDiff.hour!)) hrs ago by \(String(describing: user.username!))"
            } else {
                postedBy.text = "\(String(describing: timeDiff.day!)) days ago by \(String(describing: user.username!))"
            }
        } else {
            postedBy.text = user.username
        }
        postTitle.text = (selectedPost["postTitle"] as! String)
        postContent.text = (selectedPost["postContents"] as! String)
        let imageFile = (selectedPost["image"] as? PFFileObject) ?? nil
        if imageFile == nil {
            photoViewHeight.constant = 0
        }
        else {
            let urlString = imageFile!.url!
            let url = URL(string: urlString)!
            photoView.af_setImage(withURL: url)
            photoViewHeight.constant = 185
        }
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
        self.loadComments()
    }
    
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    @objc func loadComments() {
        let query = PFQuery(className: "Comments")
        query.includeKeys(["author", "post"])
        query.whereKey("post", equalTo: selectedPost)
        query.findObjectsInBackground { (comments, error) in
            if comments != nil {
                self.comments = comments!
                self.tableView.reloadData()
            }
        }
        run(after: 2) {
            self.myRefreshControl.endRefreshing()
        }
    }

    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()
        comment["postedTime"] = Date()

        selectedPost.add(comment, forKey: "comments")

        selectedPost.saveInBackground { (success, error) in
            if success {
                print("Comment saved")
                self.tableView.reloadData()
                self.loadComments()
            } else {
                print("Error saving comment")
            }
        }
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let comment = comments[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        cell.commentLabel.text = comment["text"] as? String
        
        // substract timePosted from currentTime
        let currTime = Date()
        let postedTime = comment["postedTime"] as? Date
        if postedTime != nil {
            let calendar = Calendar.current
            let timeDiff = calendar.dateComponents([.day, .hour, .minute], from: postedTime!, to: currTime)
            if timeDiff.hour! < 1 {
                cell.postedBy.text = "\(String(describing: timeDiff.minute!)) mins ago"
            } else if timeDiff.day! < 1 {
                cell.postedBy.text = "\(String(describing: timeDiff.hour!)) hrs ago"
            } else {
                cell.postedBy.text = "\(String(describing: timeDiff.day!)) days ago"
            }
        } else {
            cell.postedBy.text = ""
        }
        let user = comment["author"] as! PFUser
        cell.nameLabel.text = user.username
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if indexPath.row == comments.count + 1 {
//            showsCommentBar = true
//            becomeFirstResponder()
//        commentBar.inputTextView.becomeFirstResponder()
//        }
//    }
    
    @IBAction func commentButtonPressed(_ sender: Any) {
        showsCommentBar = true
        becomeFirstResponder()
        commentBar.inputTextView.becomeFirstResponder()
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
