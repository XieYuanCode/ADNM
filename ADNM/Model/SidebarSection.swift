//
//  SideBarSection.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/12.
//

import Foundation

struct SidebarSection: Identifiable {
  var id: UUID = UUID()
  
  var name: String
  var children: [SidebarItem]
  var collapsible: Bool = false
}
