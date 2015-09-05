//
//  ViewController.swift
//  Connect
//
//  Created by Rameez Remsudeen  on 9/4/15.
//
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = JMFSKModemConfiguration.highSpeedConfiguration()
        let modem = JMFSKModem.init(configuration: config)
        modem.connect()
        
        let textToSend : NSString = "Wilson is Cool"
        let data: NSData = textToSend.dataUsingEncoding(NSASCIIStringEncoding)!
        modem.sendData(data)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

