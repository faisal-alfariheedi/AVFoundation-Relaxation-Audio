//
//  ViewController.swift
//  AVFoundation Relaxation Audio
//
//  Created by faisal on 18/05/1443 AH.
//

import UIKit
import AVFoundation
import BAFluidView
import SpriteKit


class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var playstop: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var vi: UIView!
    var audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "m1", ofType: "wav")! ))
    var viewbaf : BAFluidView!
    var slidesync:Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewbaf = BAFluidView(frame: vi.frame, startElevation: 0.5)
        audio.delegate = self
        slidesync = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.sliderupdate), userInfo: nil, repeats: true)
        viewbaf.strokeColor = UIColor.white
        viewbaf.fillColor = UIColor.blue
        viewbaf.keepStationary()
        viewbaf.startAnimation()
//        viewbaf.maxAmplitude = Int(vi.frame.height)
        self.view.insertSubview(viewbaf, aboveSubview: self.vi)
         
        UIView.animate(withDuration: 0.5, animations: { [self] in
        viewbaf.alpha=1.0
        }, completion: nil)
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audio.play()
    
    }
    

    @IBAction func editend(_ sender: UISlider) {
        audio.play(atTime: TimeInterval(Float(audio.duration) * slider.value))
//         for some reason the audio doesn`t want to start at a //specific time
        slidesync = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.sliderupdate), userInfo: nil, repeats: true)
    }
    
    @IBAction func edend(_ sender: UISlider) {
        audio.play(atTime: TimeInterval(Float(audio.duration) * slider.value))
        print(TimeInterval(Float(audio.duration) * slider.value))
        slidesync = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.sliderupdate), userInfo: nil, repeats: true)
    }
    @IBAction func edstart(_ sender: UISlider) {
        audio.stop()
        slidesync.invalidate()
        print(audio.duration)
    }
    
    @IBAction func editstart(_ sender: UISlider) {
        
    }
    
    @IBAction func playstopmeth(_ sender: UIButton) {
        if(audio.isPlaying){
            audio.stop()
            print("stopped")
        }else{
            audio.play()
            print("playing")
        }
    }
    @objc func sliderupdate(){
        if(audio.isPlaying){
        slider.value = Float(audio.currentTime)/Float(audio.duration)
        }
        viewbaf.fill(to: NSNumber(value: Float(audio.currentTime)/Float(audio.duration)))
    }
}

