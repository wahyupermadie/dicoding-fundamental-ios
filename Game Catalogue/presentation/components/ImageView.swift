//
//  ImageView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 13/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage?
    @State var isLoading: Bool = true
    
    init(url: String) {
        self.imageLoader = ImageLoader(urlString: url)
    }
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                if self.isLoading {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: geo.size.width, height: geo.size.height)
                }else{
                    Image(uiImage: self.image ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
            }.onReceive(self.imageLoader.didChange) { (data) in
                self.isLoading = false
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "https://wahyupermadi.id")
    }
}
