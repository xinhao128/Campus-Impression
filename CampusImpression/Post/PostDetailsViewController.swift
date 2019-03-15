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
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCounting: UILabel!
    
    let commentBar = MessageInputBar();
    
    var selectedPost: PFObject!
    var showsCommentBar = false
    var comments = [PFObject]()
    var likes = [PFObject]()
    var likeCounts = 0
    
    
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

        self.tableView.tableFooterView = UIView()

        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Your date Format"
        
        likes = (selectedPost["likes"] as? [PFObject]) ?? []
        likeCounts = likes.count
        print(likeCounts)
        likeCounting.text = String(likeCounts)
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
        return comments.count
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        let pressed = PFObject(className: "Likes")
        likes = (selectedPost["likes"] as? [PFObject]) ?? []
        likeCounts = likes.count + 1
        print(likeCounts)
        likeCounting.text = String(likeCounts)
//        pressed["author"] = PFUser.current()
//        pressed["post"] = selectedPost
//
//        self.selectedPost.add(pressed, forKey: "likes")
//        self.selectedPost.saveInBackground { (success, error) in
//            if success {
//                print("like saved")
//            } else {
//                print("Error saving like")
//            }
//        }
//        for like in likes {
//            print("\n\nLike:", like)
//            let query = PFQuery(className: "Likes")
//            query.whereKey("objectId", equalTo: like.objectId!)
//            query.includeKey("author")
//            print("\n\nQUERY:", query)
        

//            query.getObjectInBackground(withId: selectedPost.objectId!) { (post: PFObject?, error: Error?) in
//                if let error = error {
//                    print("------aaaaaaaaaaaaaaaaa-----")
//                    self.selectedPost.add(pressed, forKey: "likes")
//                    self.selectedPost.saveInBackground { (success, error) in
//                        if success {
//                            print("like saved")
//                        } else {
//                            print("Error saving like")
//                        }
//                    }
//                    self.likeButton.setImage(UIImage(named:"checkBtn"), for: UIControl.State.normal)
//                } else {
//                    print("------bbbbbbbbbbbbbb------")
//                    pressed.deleteInBackground(block: { (success, error) in
//                        if success {
//                            print("liked deleted")
//                        }
//                        else{
//                            print("Error deleting like")
//                        }
//                    })
//                    self.likeButton.setImage(UIImage(named:"fav-icon"), for: UIControl.State.normal)
//                }
//            }
        }
        
    
//    func updateLikeCount()
//    {
//        let query = PFQuery(className: "Like")
//        query.
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    }

