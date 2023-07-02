//
//  SettingsView.swift
//  Todo
//
//  Created by Iuliia Volkova on 02.07.2023.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - Form
                Form {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                } //: Form
            
                // MARK: - Footer
                
                Text("Copyright © All rights reserved.\nBetter Apps ♡ Less Code")
                  .multilineTextAlignment(.center)
                  .font(.footnote)
                  .padding(.top, 6)
                  .padding(.bottom, 8)
                  .foregroundColor(Color.secondary)

            } //: VStack
            .navigationBarTitle("Settings", displayMode: .inline)
        } //: Navigation
    }
}


// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
