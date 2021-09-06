//
//  NewsCell.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 01/09/2021.
//

import SwiftUI

struct NewsCell: View {
    var article: Articles.Article
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(UIColor.systemBackground))
            
            HStack{
                ArticleRemoteImage(urlString: article.image)
                    .frame(width: 150)
                
                VStack{
                    Text(article.title)
                        .bold()
                        .multilineTextAlignment(.leading)
                    
                    Text(article.description)
                        .font(.subheadline)
                        .padding(.top, 10)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .frame(width: 400, height: 130)
    }
}

struct RemoteImage: View{
    var image: Image?
    
    var body: some View{
        image?.resizable() ?? Image(systemName: "photo").resizable()
    }
}

struct ArticleRemoteImage: View{
    @StateObject var imageLoader = ImageLoader()
    let urlString: String
    
    var body: some View{
        RemoteImage(image: imageLoader.image)
            .onAppear{ imageLoader.loadImage(from: urlString) }
    }
}

final class ImageLoader: ObservableObject{
    @Published var image: Image? = nil
    
    func loadImage(from url: String){
        NetworkManager.shared.downloadImages(fromURLString: url) { uiImage in
            guard let image = uiImage else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: image)
            }
        }
    }
}
