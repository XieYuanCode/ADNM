//
//  GeneralSettingsView.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/11.
//

import SwiftUI

struct GeneralSettingsView: View {
  @AppStorage("LyricInMenubar") private var lyricInMenubar = true
  @AppStorage("DoubleClickMusicBehavior") private var doubleClickMusicBehavior = DoubleClickMusicBehavior.replacePlayList
  
  var body: some View {
    HStack {
      Spacer()
      Form {
        Picker("双击播放", selection: $doubleClickMusicBehavior) {
          Text("用当前歌曲所在的歌曲替换播放列表").tag(DoubleClickMusicBehavior.replacePlayList)
          Text("仅把当个歌曲添加到播放列表").tag(DoubleClickMusicBehavior.replaceSong)
        }
        .pickerStyle(.inline)
        Toggle("菜单栏歌词", isOn: $lyricInMenubar)
      }
      Spacer()
    }
      
  }
}
