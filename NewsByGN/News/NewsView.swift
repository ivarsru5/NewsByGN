//
//  NewsView.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 01/09/2021.
//

import SwiftUI

struct NewsView: View {
    @StateObject var provider = NewsProvider()
    
    var body: some View {
        ZStack{
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(Color(UIColor.systemGray6))
            
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 50)
                        .shadow(radius: 10)
                    
                    Text("Logo")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
                .padding(.bottom)
                VStack{
                    HStack{
                        Text("News")
                            .bold()
                            .padding(.leading, 15)
                            .padding(.bottom, 15)
                        
                        Spacer()
                    }
                    .padding(.top, 25)
                    
                    ScrollView{
                        ForEach(provider.articles, id: \.id){ article in
                            Link(destination: URL(string: article.newsUrl)!, label: {
                                NewsCell(article: article)
                                    .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .accentColor(Color(UIColor.label))
                            })
                        }
                    }
                }
            }
        }
        .onAppear{
            provider.getNews()
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

class NewsProvider: ObservableObject {
    @Published var articles = [Articles.Article]()
    @Published var image: Image? = nil
    
    func getNews(){
        NetworkManager.shared.getNewsArticles(searchBy: nil) { newsArticles in
            DispatchQueue.main.async {
                self.articles = newsArticles
            }
        }
    }
}
