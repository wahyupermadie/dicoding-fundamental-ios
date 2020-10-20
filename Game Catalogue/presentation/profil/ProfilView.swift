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
    @ObservedObject var viewModel = ProfilViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Image("self_icon")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: 400, height: 400)
                Text(self.viewModel.userName)
                    .padding(.top, -50)
                    .font(.system(size: 22))
                Text(self.viewModel.userGithub)
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
                ModalView(viewModel: self.viewModel)
            }
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel = ProfilViewModel()
    @State private var isNamedEditing = false
    @State private var isGithubEditing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Update Profil")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 36)
            CustomTextField(messageHint: "Enter your name", text: self.$viewModel.userName)
            
            CustomTextField(messageHint: "Enter your github", text: self.$viewModel.userGithub)
            Button(action: {
                if self.viewModel.userName.count != 0 && self.viewModel.userGithub.count != 0 {
                    ProfilDataModel.userName = self.viewModel.userName
                    ProfilDataModel.userGithub = self.viewModel.userGithub
                    ProfilDataModel.synchronize()
                }
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
        ProfilView()
    }
}
