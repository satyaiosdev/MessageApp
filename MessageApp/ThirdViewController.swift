//
//  ThirdViewController.swift
//  MessageApp
//
//  Created by Satya Venkata Krishna Achanta on 5/21/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

import UIKit

class ThirdViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    
   var friendName: String = ""
    
    var messages: [String] = ["Hi how are you doing?", "Its been long time to see you, I hope everything goes well sofar. Bythe way ho is your new house?", "So, You decided not to give reply..!,Hi how are you doing?", "Its been long time to see you, I hope everything goes well sofar. Bythe way ho is your new house?", "So, You decided not to give reply..!,Hi how are you doing?", "Its been long time to see you, I hope everything goes well sofar. Bythe way ho is your new house?", "So, You decided not to give reply..!,Hi how are you doing?", "Its been long time to see you, I hope everything goes well sofar. Bythe way ho is your new house?", "So, You decided not to give reply..!"]
    
    var messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var setupInputTextField: UITextField = {
       let textView = UITextField()
        textView.placeholder = "Enter text here.."
        return textView
    }()
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        let titleColor = UIColor.red
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
        return button
    }()
    func submitButtonClicked(){

        messages.append(setupInputTextField.text!)
        collectionView?.reloadData()
//        let indexPath = NSIndexPath(row:self.messages.count - 1, section: 0)
//        self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .bottom , animated: true)
        
        setupInputTextField.text = nil
        
        print("It is after send button clicked with message: ", messages)
    }
    
    var bottomConstraint: NSLayoutConstraint?// Later used for bottom constraint for textfield
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         messages.append(setupInputTextField.text!)

        self.navigationItem.title = friendName
        self.tabBarController?.tabBar.isHidden = false
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 46 + 7, right: 5)
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        
        
 
//        self.view.addSubview(collectionView!)
        setuptextFieldContainerView()
        setupInputTextView()

    }
    

    func setuptextFieldContainerView(){
        
        self.view.addSubview(messageInputContainerView)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": messageInputContainerView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(48)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": messageInputContainerView]))
        
        bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
        messageInputContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    func handleKeyboardNotification(notification: NSNotification){
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue

            let iskeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            bottomConstraint?.constant = iskeyboardShowing ? -keyboardFrame!.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                
                if iskeyboardShowing
                {
                
                    let indexPath = NSIndexPath(row:self.messages.count - 1, section: 0)
                    self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .bottom , animated: true)
                }
//                let indexPath = NSIndexPath(row:self.messages.count - 1, section: 0)
//                self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
             
            })
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("It is inside override did select")
//        setupInputTextField.endEditing(false)
        view.endEditing(false)
    }
//    -(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//    }

    
    func setupInputTextView() {
        messageInputContainerView.addSubview(sendButton)
        
        messageInputContainerView.addSubview(setupInputTextField)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0][v1(60)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": setupInputTextField, "v1": sendButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": setupInputTextField]))
                view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": sendButton]))
        
        setupInputTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = messages.count {
//            return count
//        }
        return messages.count
    }
    
    

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        cell.messageTextview.text = messages[indexPath.item]
        
        
//        if let messageText = messages[indexPath.item]{
//        cell.backgroundColor = UIColor.gray
        let size = CGSize(width:250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messages[indexPath.item]).boundingRect(with: size, options:options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)

        cell.messageTextview.frame = CGRect(x: 8, y: 0, width: estimatedFrame.width + 20, height: estimatedFrame.height + 20)
        cell.bubbleView.frame = CGRect(x: 0, y: 0, width: estimatedFrame.width + 28, height: estimatedFrame.height + 20)
        
//            }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width:250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messages[indexPath.item]).boundingRect(with: size, options:options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
        
        // width: view.frame.width// it has some constraints issues
        return CGSize(width: 250 , height: estimatedFrame.height + 20)

    }
    
    class MessageCell: BaseClass{
            let messageTextview: UITextView = {
                    let textView = UITextView()
                    textView.font = UIFont.systemFont(ofSize: 18)
                textView.backgroundColor = UIColor.clear
                    textView.text = "Sample Message"
                
                    return textView
                }()
        
        let bubbleView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(white:0.95, alpha:1)
            view.layer.cornerRadius = 15
            view.layer.masksToBounds = true
            
            return view
        }()
        
        override func setupViews(){
            addSubview(bubbleView)
            addSubview(messageTextview)
            
            
                    messageTextview.translatesAutoresizingMaskIntoConstraints = false
            bubbleView.translatesAutoresizingMaskIntoConstraints = false
            
        }
    }
    
    class BaseClass: UICollectionViewCell{
        override init(frame: CGRect){
            super.init(frame: frame)
            setupViews()
        }
        required init?(coder aDecoder: NSCoder){
            fatalError("init(coder:) has not been implemented")
        }
        func setupViews(){
//            backgroundColor = UIColor.brown
        }
    }
    
}




