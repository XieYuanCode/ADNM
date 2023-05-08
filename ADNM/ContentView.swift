//
//  ContentView.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/7.
//

import SwiftUI
import Kingfisher

private struct ShowLoginSheetKey: EnvironmentKey {
  static let defaultValue: Binding<Bool>? = nil
}

extension EnvironmentValues {
  var showLoginSheet: Binding<Bool>? {
    get { self[ShowLoginSheetKey.self] }
    set { self[ShowLoginSheetKey.self] = newValue }
  }
}

struct ContentView: View {
  @EnvironmentObject private var viewModel: EnvironmentViewModel
  
  @State private var defaultSearchKey: String = "搜索歌曲"
  @State private var searchHotKeys: [GetSearchHotKeysResponseDataIdentifiable] = []
  
  @StateObject private var soundManager = SoundManager()
  
  var body: some View {
    NavigationSplitView {
      SidebarView()
    } detail: {
      MainContent()
    }
    .searchable(text: $viewModel.searchText, placement: .toolbar, prompt: defaultSearchKey)
    .searchSuggestions {
      Group {
        if(viewModel.searchText == "") {
          // 搜索关键词为空，默认热搜榜单
          ForEach(searchHotKeys) {searchHotKey in
            Label(searchHotKey.sourceData.searchWord!, systemImage: "music.note")
              .searchCompletion(searchHotKey.sourceData.searchWord!)
          }
        } else {
          // 根据关键词搜索
          Text(viewModel.searchText)
        }
      }
    }
    .toolbar(content: {
      Menu {
        Menu {
          Button("获取Cookies", action: {
            let url = URL(string: baseURL)!
            let cstorage = HTTPCookieStorage.shared
            
            if let cookies = cstorage.cookies(for: url) {
              for cookie:HTTPCookie in cookies {
                debugPrint("name: \(cookie.name)", "value: \(cookie.value)")
              }
            }
            
            if(cstorage.cookies(for: url)?.count == 0) {
              debugPrint("domain：\(baseURL)下有没cookie")
            }
          })
          Button("清除Cookies", action: {
            let url = URL(string: baseURL)!
            let cstorage = HTTPCookieStorage.shared
            
            if let cookies = cstorage.cookies(for: url) {
              for cookie:HTTPCookie in cookies {
                cstorage.deleteCookie(cookie)
              }
            }
            if(cstorage.cookies(for: url)?.count == 0) {
              debugPrint("清除成功")
            }
          })
        } label: {
          Text("Cookie")
        }
        Button("退出登陆", action: {
          Task {
            try await logout()
            viewModel.isLoggined = false
            viewModel.userProfile = nil
          }
        })
        
      } label: {
        Text("账号测试")
      }
      Menu("音乐测试") {
        Menu("在线音乐") {
          Button("播放在线音乐", action: {
            if soundManager.soundPlayer == nil {
              soundManager.playSound(sound: "https://m801.music.126.net/20230505163551/314ed6ab52d7ff27c1f555230277c6b2/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096443301/0652/fb34/bad3/cffcc3878a943877fef35903ed5fef48.mp3")
            }
            soundManager.soundPlayer?.play()
          })
          Button("暂停在线音乐", action: {
            soundManager.soundPlayer?.pause()
          })
        }
        Menu("本地音乐") {
          Button("播放本地音乐", action: {})
          Button("暂停本地音乐", action: {})
        }
      }
      Menu("自定义导航") {
        Button("搜索页面") {
          viewModel.navigationModel.selectedSidebar = .Search
        }
        Button("歌单页面") {
          viewModel.navigationModel.selectedSidebar = .Playlist
        }
        Button("歌手页面") {
          viewModel.navigationModel.selectedSidebar = .Singer
        }
        Button("播放器页面") {
          viewModel.navigationModel.selectedSidebar = .Player
        }
      }
    })
    .task {
      do {
        defaultSearchKey = try await getSearchDefaultKey()
        searchHotKeys = try await getSearchHotKeys()
      } catch {
        defaultSearchKey = "搜索歌曲"
      }
    }
  }
}
