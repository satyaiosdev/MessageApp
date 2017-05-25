//
//  SecondVCExtension.swift
//  MessageApp
//
//  Created by Satya Venkata Krishna Achanta on 5/21/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

import UIKit

extension SecondViewController {
  
    
    

    class Message: NSObject{
        var text: String?
        var date: NSDate?
    }

    
    
    func setupData() {
  
        let message = Message()
//        message.friend = satya
        message.text = "Hi I am Satya, Thanks for having me here"
        message.date = NSDate()
        
 
        let venkatMessage = Message()
//        venkatMessage.friend = Venkat
        venkatMessage.text = "I am Venkat, Thanks for having me"
        venkatMessage.date = NSDate()
        
        messages = [message,venkatMessage]
        
    }
    
    
}
