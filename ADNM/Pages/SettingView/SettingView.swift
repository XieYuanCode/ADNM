//
//  SettingView.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/11.
//

import SwiftUI

struct SettingView: View {
  private enum Tabs: Hashable {
    case general, account, privacy, shortcut, download, lyric
  }
  var body: some View {
    TabView {
      GeneralSettingsView()
        .tabItem{
          Label("通用", systemImage: "gear")
        }
        .tag(Tabs.general)
      AccountSettingsView()
        .tabItem {
          Label("账户", systemImage: "person.crop.circle")
        }
        .tag(Tabs.account)
      PrivacySettingView()
        .tabItem{
          Label("信息和隐私", systemImage: "envelope.badge")
        }
        .tag(Tabs.privacy)
      ShortcutSettingView()
        .tabItem{
          Label("快捷键", systemImage: "keyboard")
        }
        .tag(Tabs.shortcut)
      DownloadSettingView()
        .tabItem{
          Label("下载", systemImage: "square.and.arrow.down")
        }
        .tag(Tabs.download)
      LyricSettingView()
        .tabItem{
          Label("歌词", systemImage: "list.triangle")
        }
        .tag(Tabs.lyric)
    }
    .padding()
    .frame(width: 600, height: 400, alignment: .top)
  }
}
