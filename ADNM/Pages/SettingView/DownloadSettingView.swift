//
//  DownloadSettingView.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/11.
//

import SwiftUI

enum Quality {
  case Normal, High, Lossless, HiRes
}

struct DownloadSettingView: View {
  @AppStorage("Setting.Download.Listen.Quality") private var listenQuality = "High"
  @AppStorage("Setting.Download.Download.Quality") private var downlaadQuality = "High"
  
  var body: some View {
    Text("DownloadSettingView")
  }
}
