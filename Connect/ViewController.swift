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
        // Gets a base representation of a char
        let x = self.utf8
        return x[x.startIndex]
    }
}

class ViewController: UIViewController, CharReceiver{
    
    var text: UITextView!

    override func viewDidLoad() {
        
        // Add label
        text = UITextView(frame: CGRectMake(50,100,self.view.bounds.width/2, self.view.bounds.height/2))
        text.editable = false
        text.text = ""
        view.addSubview(text)
        
        
        super.viewDidLoad()
        let demo = AudioDemo()
        demo.recognizer.addReceiver(self)
        
     
        demo.generator.writeByte("W".ascii2uint())
        demo.generator.writeByte("I".ascii2uint())
        demo.generator.writeByte("L".ascii2uint())
        demo.generator.writeByte("S".ascii2uint())
        demo.generator.writeByte("O".ascii2uint())
        demo.generator.writeByte("N".ascii2uint())
        demo.generator.writeByte(" ".ascii2uint())
     
        demo.generator.writeByte("Z".ascii2uint())
        demo.generator.writeByte("H".ascii2uint())
        demo.generator.writeByte("A".ascii2uint())
        demo.generator.writeByte("O".ascii2uint())
        demo.generator.writeByte("!".ascii2uint())
        
        
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
    
    func receivedChar(var input: Int8) {

        let string = withUnsafePointer(&input) {
            //String.fromCString(UnsafePoint($0))!
            if let char = NSString(CString: $0, encoding: NSUTF8StringEncoding) {
                text.text = text.text + String(char)

            }

        }
        
//        text.text = text.text + String.fromCStringRepairingIllFormedUTF8(&
//            input)
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

