//
//  SoundManager.swift
//  ADNM
//
//  Created by 谢渊 on 2023/5/5.
//

import Foundation
import AVFoundation

class SoundManager: ObservableObject {
  var soundPlayer: AVPlayer?
  
  func playSound(sound: String) {
    if let url = URL(string: sound) {
      self.soundPlayer = AVPlayer(url: url)
    }
  }
}
