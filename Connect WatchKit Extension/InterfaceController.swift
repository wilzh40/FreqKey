//
//  InterfaceController.swift
//  Connect WatchKit Extension
//
//  Created by Rameez Remsudeen  on 9/4/15.
//
//

import WatchKit
import Foundation
import CoreMotion


class InterfaceController: WKInterfaceController {
    
    var player: WKAudioFilePlayer!
    let motionManager = CMMotionManager()
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.

        
        motionManager.accelerometerUpdateInterval = 0.1
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
       
        let filePath = NSBundle.mainBundle().pathForResource("tapNoise", ofType: "m4a")
        let fileUrl = NSURL.fileURLWithPath(filePath!)
        let asset = WKAudioFileAsset(URL: fileUrl)
        let playerItem = WKAudioFilePlayerItem(asset: asset)
//        WKAudioFilePlayerItem(asset: asset)

        if motionManager.accelerometerAvailable {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (data, err) -> Void in
                
                print("x mag = \(data!.acceleration.x)")
                
            })
        }
//        player = WKAudioFilePlayer(playerItem: playerItem)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
        motionManager.stopAccelerometerUpdates()
    }
    
    func recordFileURL() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        
        
        let container = fileManager.containerURLForSecurityApplicationGroupIdentifier("group.connect.recordings")
        let fileUrl = container!.URLByAppendingPathComponent("rec.m4a")
        
        return fileUrl
    }

    @IBAction func playButtonTapped() {
//        let filePath = NSBundle.mainBundle().pathForResource("tapNoise", ofType: "m4a")
//        let fileUrl = NSURL.fileURLWithPath(filePath!)
//        let sc = SessionController().beginTransferOfFile(fileUrl) { () -> () in
        
        presentAudioRecorderControllerWithOutputURL(recordFileURL(), preset: WKAudioRecorderPreset.HighQualityAudio, options: nil) { (completion, errn) -> Void in
            
            if completion {
                SessionController().beginTransferOfFile(self.recordFileURL(), completion: { () -> () in
                    
                })
            }
        }
        
        }

}

