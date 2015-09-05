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
        let demo = AudioDemo()
        demo.generator.writeByte(0xFF)
        demo.generator.writeByte(0xFF)
        demo.generator.writeByte(0xFA)
        demo.generator.writeByte(0xFF)
        demo.generator.writeByte(0xFF)
        demo.generator.writeByte(0xFF)
        demo.generator.writeByte(0xFF)
     

      /*
        let config = JMFSKModemConfiguration.highSpeedConfiguration()
        let modem = JMFSKModem.init(configuration: config)
        modem.connect()
        
        let textToSend : NSString = "Wilson"
        let data: NSData = textToSend.dataUsingEncoding(NSASCIIStringEncoding)!
        modem.sendData(data)
        
        modem.delegate = self
*/
        
        
        // Do any additional setup after loading the view, typically from a nib.
    

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

