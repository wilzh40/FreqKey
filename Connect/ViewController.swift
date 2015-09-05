//
//  ViewController.swift
//  Connect
//
//  Created by Rameez Remsudeen  on 9/4/15.
//
//

import UIKit

extension String {
    func ascii2uint() -> UInt8 {
        let x = self.utf8
        return x[x.startIndex]
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let demo = AudioDemo()
     
        demo.generator.writeByte("W".ascii2uint())
        demo.generator.writeByte("I".ascii2uint())
        demo.generator.writeByte("L".ascii2uint())
        demo.generator.writeByte("S".ascii2uint())
        demo.generator.writeByte("O".ascii2uint())
        demo.generator.writeByte("N".ascii2uint())
        demo.generator.writeByte(0xFF)
     
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
    
   
    
   /* func hex2ascii (example: String) -> String
    {
        
        var chars = [Character]()
        
        for c in example.characters
        {
            chars.append(c)
        }
        
        let numbers =  stride(from: 0, to: chars.count, by: 2).map{
            strtoul(String(chars[$0 ..< $0+2]), nil, 16)
        }
        
        var final = ""
        var i = 0
        
        while i < numbers.count {
            final.append(Character(UnicodeScalar(Int(numbers[i]))))
            i++
        }
        
        return final
    }*/

}

