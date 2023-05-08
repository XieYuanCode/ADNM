//
//  SidebarRow.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/12.
//

import SwiftUI

struct SidebarRow: View {
  var sidebarItem: SidebarItem
  
  var body: some View {
    if(sidebarItem.actionIcon == "") {
      Label(sidebarItem.name, systemImage: sidebarItem.systemImage)
    } else {
      HStack(alignment: .center) {
        Label(sidebarItem.name, systemImage: sidebarItem.systemImage)
        Spacer()
        Button(action: sidebarItem.action) {
          Image(systemName: sidebarItem.actionIcon)
        }
        .buttonStyle(.borderless)
        .help(sidebarItem.actionTooltip)
#if os(macOS)
        .onHover(perform: cursorToPointingWhenHovering)
#endif
      }.padding([.trailing], 10)
    }
    
  }
}
