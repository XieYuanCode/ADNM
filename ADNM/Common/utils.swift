//
//  utils.swift
//  ADNM
//
//  Created by 谢渊 on 2023/4/14.
//

import Foundation
import SwiftUI

extension NSDate {
  var timeStamp: String {
    let timeInterval: TimeInterval = self.timeIntervalSince1970
    let timeStamp = Int(timeInterval)
    return "\(timeStamp)"
  }
}

extension Image {
  init?(base64Str: String) {
    guard let data = Data(base64Encoded: base64Str) else { return nil }
    guard let image = NSImage(data: data) else { return nil }
    self.init(nsImage: image)
  }
}

extension View {
  public func toast(isPresenting: Binding<Bool>, text: String) -> some View {
    modifier(ToastModifier(isPresent: isPresenting, text: text))
  }
}

struct ToastModifier: ViewModifier {
  @Binding var isPresent: Bool
  var text: String
  
  func body(content: Content) -> some View {
    ZStack {
      content
      if isPresent {
        Text(text)
          .font(.title3)
          .foregroundColor(.white)
          .frame(minWidth: 80, alignment: .center)
          .zIndex(1.0)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 5)
              .foregroundColor(.black)
              .opacity(0.6)
          )
        }
      }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        isPresent = false
      }
    }
    .padding()
    .opacity(1)
    .animation(.easeIn(duration: 0.1), value: isPresent)
    .edgesIgnoringSafeArea(.all)
   }
}

func cursorToPointingWhenHovering(hovering: Bool) {
  hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
}
