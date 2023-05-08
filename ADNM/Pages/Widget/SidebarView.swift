//
//  SidevarVIew.swift
//  ADNM
//
//  Created by 谢渊 on 2023/5/6.
//

import SwiftUI

struct SidebarView: View {
  @EnvironmentObject var viewModel: EnvironmentViewModel
  
  @State private var sidebarSections: [SidebarSection] = [
    SidebarSection(name: "在线音乐", children: [
      SidebarItem(name: "发现音乐", systemImage: "party.popper", destination: .OnlineMusic),
      SidebarItem(name: "播客", systemImage: "dot.radiowaves.left.and.right", destination: .Podcast),
      SidebarItem(name: "私人FM", systemImage: "radio", destination: .PrivateFM),
      SidebarItem(name: "视频", systemImage: "video", destination: .Video),
      SidebarItem(name: "关注", systemImage: "person.2", destination: .Following),
    ]),
    SidebarSection(name: "我的音乐", children: [
      SidebarItem(name: "我喜欢的音乐", systemImage: "heart", actionIcon: "bolt.heart", action: {
        debugPrint("心动模式")
      }, actionTooltip: "开启心动模式", destination: .MyFavouiteMusic),
      SidebarItem(name: "下载管理", systemImage: "square.and.arrow.down", destination: .Downloads),
      SidebarItem(name: "最近播放", systemImage: "clock", destination: .RecentlyPlayed),
      SidebarItem(name: "我的音乐云盘", systemImage: "cloud", destination: .CloudStorage),
      SidebarItem(name: "我的博客", systemImage: "dot.radiowaves.left.and.right", destination: .SubscribedBlog),
      SidebarItem(name: "我的收藏", systemImage: "star", destination: .MuCollection),
    ]),
    SidebarSection(name: "创建的歌单", children: [], collapsible: true)
  ]
  
  var body: some View {
    VStack(alignment: .center) {
      List(selection: $viewModel.navigationModel.selectedSidebar) {
        ForEach(sidebarSections) { section in
          Section(content: {
            ForEach(section.children) { sidebarItem in
              NavigationLink(value: sidebarItem.destination) {
                SidebarRow(sidebarItem: sidebarItem)
                  .padding(.leading)
                  .contextMenu {
                    if (sidebarItem.destination == .MyFavouiteMusic) {
                      Button("播放", action: {})
                      Button("下一首播放", action: {})
                      Divider()
                      ShareLink("分享", item: URL(string: "https://developer.apple.com/xcode/swiftui/")!, preview: SharePreview("SharePreview", image: Image("")))
                      Button("复制链接", action: {})
                      Button("下载全部", action: {})
                    }
                  }
              }
            }
          }, header: {
            Text(section.name)
              .font(.system(size: 10, weight: .heavy))
              .foregroundColor(.gray)
              .fontWeight(.bold)
              .contextMenu {
                if(section.name == "创建的歌单") {
                  Button("新建歌单", action: {})
                }
              }
          })
          
        }
      }
      Spacer()
      SidebarLogin()
    }
  }
}
