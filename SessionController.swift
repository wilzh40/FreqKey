//
//  SessionController.swift
//  Connect
//
//  Created by Rameez Remsudeen  on 9/5/15.
//
//

import Foundation
import WatchConnectivity
import Contacts

class SessionController {
    
    ///  Ideally present UI updates in completion handler.
    /// Transfers file at URL from phone to watch and vice versa depending on the target that's calling. 
    func beginTransferOfFile (file:NSURL, completion:() -> ()) {
        
        let fileTransfer = WCSession.defaultSession().transferFile(file, metadata: nil)
        
        while fileTransfer.transferring {
            
        }
        
        completion()
    }
    
    static func requestContactInfo() {
        
    }
    
    static func completeExchange() {
        
    }
    
    static func initiateConnection() {
        WCSession.defaultSession().sendMessage(["action":"transfer"], replyHandler: { (reply) -> Void in
            
            
            }) { (err) -> Void in
                
        }
    }
}