//
//  File.swift
//  Vibez
//
//  Created by Billy Huang on 2022-04-15.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer!

func playSound(key: String, cnt: Int) {
    let url = Bundle.main.url(forResource: key, withExtension: "mp3")
    
    guard url != nil else {
        return
    }
    
    do {
        player = try AVAudioPlayer(contentsOf: url!)
        player?.play()
        player.numberOfLoops = cnt
    } catch {
        print("error")
    }
}

func pauseSound() {
    player.pause()
}
