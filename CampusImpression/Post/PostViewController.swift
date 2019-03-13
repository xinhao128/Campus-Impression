////
////  PostViewController.swift
////  CampusImpression
////
////  Created by Chanyue Hu on 3/7/19.
////  Copyright © 2019 Xinhao Liang. All rights reserved.
////
//
//import UIKit
//import Parse
//import MessageInputBar
//
//class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    var post: PFObject!
//    let commentBar = MessageInputBar()
//    var showCommentBar = false
//    
//    
//    let testComments = ["test", "howdy", "codepath"]
//
//    @IBOutlet weak var postDetailView: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        postDetailView.delegate = self
//        postDetailView.dataSource = self
//        
//        postDetailView.keyboardDismissMode = .interactive
//        
//        self.postDetailView.rowHeight = UITableView.automaticDimension
//        self.postDetailView.estimatedRowHeight = 400
//        
//        self.postDetailView.tableFooterView = UIView()
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "Your date Format"
//        
//    }
//    
//    override var inputAccessoryView: UIView?{
//        return commentBar
//    }
//    
//    override var canBecomeFirstResponder: Bool {
//        return showCommentBar
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        //self.loadPosts()
//    }
//
//    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
//        let queue = DispatchQueue.main
//        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
//    }
//    
//    
//    
//    @objc func comment() {
//        // create comment
//        showCommentBar = true
//        becomeFirstResponder()
//    }
//    
//    @objc func like() {
//        // like post
//    }
//    
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let comments = (post["comments"] as? [PFObject]) ?? []
//        let imageFile = (post["image"] as? PFFileObject) ?? nil
//        if imageFile == nil {
//            return comments.count + 2
//        }
//        else {
//            return comments.count + 3
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // check if user tapped comment or like button
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let imageFile = (post["image"] as? PFFileObject) ?? nil
//        let comments = (post["comments"] as? [PFObject]) ?? []
//        let emptyCell = UITableViewCell()
//        
//        let actionCell = tableView.dequeueReusableCell(withIdentifier: "ActionCell") as! ActionCell
//        actionCell.commentButton.addTarget(self, action: #selector(PostViewController.comment), for: .touchUpInside)
//
//        actionCell.commentButton.addTarget(self, action: #selector(PostViewController.like), for: .touchUpInside)
//        
////        let user = post["author"] as! PFUser
////
////        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
////        cell.postTitle.text = post["postTitle"] as! String
////        cell.postPreview.text = post["postContents"] as! String
////        cell.postTag.text = "#\(String(describing: post["tag"] as! String))"
////
////        let currTime = Date()
////        let postedTime = post["postedTime"] as? Date
////        if postedTime != nil {
////            let calendar = Calendar.current
////            let timeDiff = calendar.dateComponents([.hour, .minute], from: postedTime!, to: currTime)
////            if timeDiff.hour! < 1 {
////                cell.postedBy.text = "\(String(describing: timeDiff.minute!)) mins ago by \(String(describing: user.username!))"
////            } else {
////                cell.postedBy.text = "\(String(describing: timeDiff.hour!)) hrs ago by \(String(describing: user.username!))"
////            }
////        } else {
////            cell.postedBy.text = user.username
////        }
////
////        // add cell buttons:
////        let actionCell = tableView.dequeueReusableCell(withIdentifier: "ActionCell") as! ActionCell
////        actionCell.commentButton.addTarget(self, action: #selector(PostViewController.comment), for: .touchUpInside)
////
////        actionCell.commentButton.addTarget(self, action: #selector(PostViewController.like), for: .touchUpInside)
////
////
////        // check for image
////        if imageFile != nil {
////            // create cell
////
////
////            // add image to cell
////            let urlString = imageFile!.url!
////            let url = URL(string: urlString)!
//////            cell.photoView.af_setImage(withURL: url) //you have to import alamofireimage!!!
////        }
////
////
////        // check for comments
////        let commentsCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
////
////        if comments.count > 0 {
////            // add coments to comment cell
////            // for loop
////        }
////
////        return cell
//        if imageFile != nil {
//            if indexPath.row == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
//                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
//
//                let user = post["author"] as! PFUser
//                cell.postTag.text = "#\(String(describing: post["tag"] as! String))"
//
//                // substract timePosted from currentTime
//                let currTime = Date()
//                let postedTime = post["postedTime"] as? Date
//                if postedTime != nil {
//                    let calendar = Calendar.current
//                    let timeDiff = calendar.dateComponents([.hour, .minute], from: postedTime!, to: currTime)
//                    if timeDiff.hour! < 1 {
//                        cell.postedBy.text = "\(String(describing: timeDiff.minute!)) mins ago by \(String(describing: user.username!))"
//                    } else {
//                        cell.postedBy.text = "\(String(describing: timeDiff.hour!)) hrs ago by \(String(describing: user.username!))"
//                    }
//                } else {
//                    cell.postedBy.text = user.username
//                }
//                cell.postTitle.text = (post["postTitle"] as! String)
//                cell.postPreview.text = (post["postContents"] as! String)
//
//                return cell
//            }
//            else if indexPath.row == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
//                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
//                let urlString = imageFile!.url!
//                let url = URL(string: urlString)!
//                cell.photoView.af_setImage(withURL: url) //you have to import alamofireimage!!!
//                return cell
//            }
//            else if indexPath.row == 2 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell") as! ActionCell
//                return cell
//            }
//            else {
//                if comments.count != 0{
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
//                    let comment = comments[indexPath.row - 3]
//                    cell.commentLabel.text = comment["text"] as? String
//                    return cell
//                }
//                return emptyCell
//            }
//        }
//        else{
//            if indexPath.row == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
//                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
//
//                let user = post["author"] as! PFUser
//                cell.postTag.text = "#\(String(describing: post["tag"] as! String))"
//
//                // substract timePosted from currentTime
//                let currTime = Date()
//                let postedTime = post["postedTime"] as? Date
//                if postedTime != nil {
//                    let calendar = Calendar.current
//                    let timeDiff = calendar.dateComponents([.hour, .minute], from: postedTime!, to: currTime)
//                    if timeDiff.hour! < 1 {
//                        cell.postedBy.text = "\(String(describing: timeDiff.minute!)) mins ago by \(String(describing: user.username!))"
//                    } else {
//                        cell.postedBy.text = "\(String(describing: timeDiff.hour!)) hrs ago by \(String(describing: user.username!))"
//                    }
//                } else {
//                    cell.postedBy.text = user.username
//                }
//                cell.postTitle.text = (post["postTitle"] as! String)
//                cell.postPreview.text = (post["postContents"] as! String)
//
//                return cell
//            }
//            else if indexPath.row == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell") as! ActionCell
//                return cell
//            }
//            else {
//                if comments.count != 0{
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
//                    let comment = comments[indexPath.row - 3]
//                    cell.commentLabel.text = comment["text"] as? String
//                    return cell
//                }
//                return emptyCell
//            }
//        }
//    }
//}
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//
