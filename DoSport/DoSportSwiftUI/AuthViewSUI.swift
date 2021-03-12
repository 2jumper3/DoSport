//
//  AuthViewSUI.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 12/03/2021.
//

#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 13.0, *)
struct AuthViewSUI: View {
    var body: some View {
        HStack {
            Text("Hello, World!")
            Button("Text") { 
                print("Clicked")
            }
        }
    }
}

@available(iOS 13.0, *)
struct AuthViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        AuthViewSUI()
    }
}
