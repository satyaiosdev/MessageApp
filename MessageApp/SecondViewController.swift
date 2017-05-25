//
//  SecondViewController.swift
//  MessageApp
//
//  Created by Satya Venkata Krishna Achanta on 5/20/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

import UIKit



class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    

    
    var firstVC: ViewController!
    
    var nameOfTheUser: String = ""
    var nameOfTheGuest = ""
    var collectionView: UICollectionView!
    let cellId = "collectionCell"
    
    
    var messages: [Message]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameOfTheGuest = nameOfTheUser + " Friend"
        print("it is inside scond VC", nameOfTheUser, nameOfTheGuest)
        
        self.navigationItem.title = "Home"
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        
        self.view.addSubview(collectionView)
        
        setupData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int // It takes number of items- here no.of rows
    {
        if let count = messages?.count{
//            return count
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {                                                            //It takes total collections view layout
        
        return CGSize(width: 350, height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {   //it takes each cell inf
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as!
        MessageCell

        if let message = messages?[indexPath.item]{
            cell.message = message
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       print("It is inside Select")
        let layout = UICollectionViewFlowLayout()
                let thirdVC = ThirdViewController(collectionViewLayout: layout)
                thirdVC.friendName = "Satya Krishna"
                navigationController?.pushViewController(thirdVC, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        print("It is inside select")
//        let layout = UICollectionViewFlowLayout()
//        let thirdVC = ThirdViewController(collectionViewLayout: layout)
//        thirdVC.friendName = "Satya Krishna"
//        navigationController?.pushViewController(thirdVC, animated: true)
//    }
    
    
    
    class MessageCell: BaseClass{
        var message: Message?{
            didSet{
                nameLabel.text = "Satya Krishna"
                messageLabel.text = message?.text
                
                if let date = message?.date{
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "h:mm a"
                    
                    timeLabel.text = dateFormatter.string(from: date as Date)
                }
            }
        }
        
        let profileImageView: UIImageView = { //profile image properties
            var imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 34
            imageView.layer.masksToBounds = true
            imageView.image = UIImage(named: "puppy")
            return imageView
        }()
        
        let containerView: UIView = { //Container View properties to display sender information
            let containersView = UIView()
            //        containersView.backgroundColor = UIColor.darkGray
            return containersView
        }()
        
        
        let dividerLineView: UIView = { //Divider line properties to seperate different rows
            let view = UIView()
            view.backgroundColor = UIColor.red
            return view
        }()
        
        //        let obj = SecondViewController()
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "Friend"
            label.textColor = UIColor.red
            label.font = UIFont.systemFont(ofSize: 18)
            return label
        }()
        
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = "This is sample conversation"
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()
        let timeLabel: UILabel = {
            let label = UILabel()
            label.text = "9:40 a"
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .right
            return label
        }()
        
        override func setupViews(){
            
            addSubview(profileImageView)
            addSubview(containerView)
            addSubview(dividerLineView)
            
            containerView.addSubview(nameLabel)
            containerView.addSubview(messageLabel)
            containerView.addSubview(timeLabel)
//
//            
            //            newContainerView()//to clean the code
            
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            containerView.translatesAutoresizingMaskIntoConstraints = false
            dividerLineView.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            timeLabel.translatesAutoresizingMaskIntoConstraints = false
            
            //Constraints for profile image
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0(68)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(68)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView]))
            
            //Constrains for Container View
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-90-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": containerView]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": containerView]))
            
            //Constrains for Divider Line
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-82-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLineView]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLineView]))
            
            //Inside container view- name label
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0][v1(80)]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": timeLabel]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1(24)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": messageLabel]))
            
            //Inside container view- message label
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": messageLabel]))
            
            
            //Inside container view- time label
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(24)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": timeLabel]))
  
            
            

            //            backgroundColor = UIColor.brown
        }
        
    }
    
    class BaseClass: UICollectionViewCell{
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func setupViews(){
            backgroundColor = UIColor.brown
        }
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
