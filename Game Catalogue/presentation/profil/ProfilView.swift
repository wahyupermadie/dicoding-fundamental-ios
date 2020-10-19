//
//  ProfilView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct ProfilView: View {
    @State private var showModal = false
    var body: some View {
        NavigationView {
            VStack {
                Image("self_icon")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: 400, height: 400)
                Text(ProfilDataModel.userName)
                    .padding(.top, -50)
                    .font(.system(size: 22))
                Text(ProfilDataModel.userGithub)
                    .padding(.top, -30)
                    .foregroundColor(.gray)
                Button(action: {
                    self.showModal = true
                }){
                    Text("Update Profil")
                      .foregroundColor(.green)
                      .frame(minWidth: 0, maxWidth: .infinity)
                      .font(.system(size: 18))
                      .padding()
                      .overlay(
                          RoundedRectangle(cornerRadius: 8)
                              .stroke(Color.green, lineWidth: 1)
                      )
                }.padding([.top,.leading,.trailing], 16)

            
                Spacer()
                
            }.navigationBarTitle(Text("Profile"))
            .onAppear(perform: {
                ProfilDataModel.synchronize()
            })
            .sheet(isPresented: $showModal, onDismiss: {
                print(self.showModal)
            }) {
                ModalView()
            }
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var name: String = ProfilDataModel.userName
    @State private var github: String = ProfilDataModel.userGithub
    @State private var isNamedEditing = false
    @State private var isGithubEditing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Update Profil")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 36)
            CustomTextField(messageHint: "Enter your name", text: self.$name)
            
            CustomTextField(messageHint: "Enter your github", text: self.$github)
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Submit")
                    .foregroundColor(.green)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.green, lineWidth: 1)
                    )
            }
            .padding(.top, 24)
            Spacer()
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            alignment: .topLeading
        )
        .padding(.top, 18)
        .padding([.leading, .trailing], 16)
    }
}

struct CustomTextField: View {
    var messageHint: String
    @Binding var text: String
    @State private var isEditing = false
    var body: some View {
        HStack {
            TextField(self.messageHint, text: $text)
                .padding(12)
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
        }
        .foregroundColor(.black)
        .background(
            Rectangle()
                .foregroundColor(.gray).opacity(0.2)
        )
        .cornerRadius(8)
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
