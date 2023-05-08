//
//  MainContent.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/17.
//

import SwiftUI

struct MainContent: View {
  @EnvironmentObject var viemModel: EnvironmentViewModel
  
  var body: some View {
    if let sidebarItem = viemModel.navigationModel.selectedSidebar {
          Group {
            if(sidebarItem == .OnlineMusic) {
              OnlineMusic()
            } else if(sidebarItem == .Podcast) {
              Podcast()
            } else if(sidebarItem == .PrivateFM) {
              PrivateFM()
            } else if(sidebarItem == .Video) {
              Video()
            } else if(sidebarItem == .Following) {
              Following()
            } else if(sidebarItem == .MyFavouiteMusic) {
              MyfavouiteMusic()
            } else if(sidebarItem == .Downloads) {
              Downloads()
            } else if(sidebarItem == .RecentlyPlayed) {
              RecentlyPlayed()
            } else if(sidebarItem == .CloudStorage) {
              CloudStorage()
            } else if(sidebarItem == .SubscribedBlog) {
              SubscribedBlog()
            } else if (sidebarItem == .MuCollection) {
              MyCollcetion()
            } else if (sidebarItem == .Search){
              SearchResult()
            } else if (sidebarItem == .Player) {
              PlayerView()
            } else if (sidebarItem == .Playlist) {
              PlaylistView()
            } else if (sidebarItem == .Singer) {
              SingerView()
            } else if (sidebarItem == .Album) {
              AlbumView()
            }
          }
    } else {
      OnlineMusic()
    }

  }
}
