//
//  NavigationModel.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/11.
//

import SwiftUI
enum ContentDestination: String {
  /// 在线音乐
  case OnlineMusic
  /// 播客
  case Podcast
  /// 私人FM
  case PrivateFM
  /// 视频
  case Video
  /// 关注
  case Following
  /// 我的喜欢
  case MyFavouiteMusic
  /// 下载
  case Downloads
  /// 最近播放
  case RecentlyPlayed
  /// 云盘音乐
  case CloudStorage
  /// 我的博客
  case SubscribedBlog
  /// 我的收藏
  case MuCollection
  /// 搜索
  case Search
  /// 播放器
  case Player
  /// 歌手
  case Singer
  /// 歌单
  case Playlist
  /// 专辑
  case Album
  // 歌曲
  case Song
}


struct NavigationModel {
  var selectedSidebar: ContentDestination? = .OnlineMusic
  
  var searchKey: String?
  var singerID: Int?
  var playlistID: Int?
  var albumID: Int?
  var songID: Int?
  
  mutating func openAlbumView(albumID: Int) {
    self.albumID = albumID
    self.selectedSidebar = .Album
  }
  
  mutating func openSearchView(searchKey: String) {
    self.searchKey = searchKey
    self.selectedSidebar = .Search
  }
  
  mutating func openSongView(songID: Int) {
    self.songID = songID
    self.selectedSidebar = .Song
  }
  
  mutating func openPlaylistView(playlistID: Int) {
    self.playlistID = playlistID
    self.selectedSidebar = .Playlist
  }
  
  mutating func openPlayerView() {
    self.selectedSidebar = .Player
  }
  
  mutating func openSingerView(singerID: Int) {
    self.singerID = singerID
    self.selectedSidebar = .Singer
  }
}
