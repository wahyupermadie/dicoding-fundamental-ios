//
//  SearchView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 13/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var searchText = ""
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Spacer()
                Text("Search")
                    .fontWeight(.bold)
                    .frame(alignment: .center)
                    .padding(.trailing, -50)
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Close")
                }
                .frame(alignment: .trailing)
                .padding(.trailing, 12)
            }.padding([.top, .bottom], 8)
            SearchBar(text: self.$searchText)
            Spacer()
            
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    var body: some View {
        HStack {
            TextField("Search....", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .foregroundColor(.red)
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }

               if isEditing {
                   Button(action: {
                       self.isEditing = false
                       self.text = ""

                   }) {
                       Text("Cancel")
                   }
                   .padding(.trailing, 10)
                   .transition(.move(edge: .trailing))
                   .animation(.default)
               }
        }.background(Color.red)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
