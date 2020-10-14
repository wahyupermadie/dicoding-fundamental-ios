//
//  ProfilView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct ProfilView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("self_icon")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: 400, height: 400)
                Text("I Putu Wahyu Permadi")
                    .padding(.top, -50)
                    .font(.system(size: 22))
                Text("https://github.com/wahyupermadie")
                    .padding(.top, -30)
                    .foregroundColor(.gray)
                Spacer()
            }.navigationBarTitle(Text("Profile"))
        }
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
