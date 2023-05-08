//
//  SideBarItem.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/12.
//

import Foundation

struct SidebarItem: Identifiable, Hashable {
  static func == (lhs: SidebarItem, rhs: SidebarItem) -> Bool {
    return lhs.name == rhs.name
  }
  
  var id: UUID = UUID()
  
  var name: String
  var systemImage: String
  
  
  var actionIcon: String = ""
  var action: () -> Void = {}
  var actionTooltip: String = ""
  
  var destination: ContentDestination
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
