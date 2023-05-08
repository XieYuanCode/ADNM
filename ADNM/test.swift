//
//  test.swift
//  ADNM
//
//  Created by 谢渊 on 2023/5/4.
//

import SwiftUI

struct test: View {
    var body: some View {
      Text("asd")
        .padding()
        .background(.red)
        .foregroundColor(.white)
        .frame(width: 80, height: 30)
        .font(.caption)
        .cornerRadius(10)
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
