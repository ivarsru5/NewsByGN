//
//  SearchNews.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 01/09/2021.
//

import SwiftUI

struct SearchNews: View {
    @StateObject var searchManager = SearchManager()
    
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(Color(UIColor.systemGray6))
                
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 150)
                            .shadow(radius: 10)
                        
                        VStack{
                            Text("Logo")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(.orange)
                            
                            HStack{
                                HStack{
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(Color.secondary)
                                    TextField("Search", text: $searchManager.searchParameter) {(_) in } onCommit:{
                                        self.searchManager.getNews()
                                    }
                                    .foregroundColor(Color.secondary)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 30)
                                                .foregroundColor(Color(UIColor.systemGray6)))
                                
                                
                                NavigationLink(destination: EmptyView(), label: {
                                    Circle()
                                        .frame(width: 53, height: 53)
                                        .foregroundColor(Color(UIColor.systemGray6))
                                        .overlay(Image(systemName: "square.and.pencil")
                                                    .foregroundColor(Color.secondary))
                                })
                                
                                NavigationLink(destination: EmptyView(), label: {
                                    Circle()
                                        .frame(width: 53, height: 53)
                                        .foregroundColor(Color(UIColor.systemGray6))
                                        .overlay(Image(systemName: "arrow.up.arrow.down")
                                                    .foregroundColor(Color.secondary))
                                })
                            }
                            .padding()
                        }
                    }
                    .padding(.bottom)
                    
                    Spacer()
                    
                    ScrollView{
                        ForEach(searchManager.articles, id: \.id){ article in
                            Link(destination: URL(string: article.newsUrl)!, label: {
                                NewsCell(article: article)
                                    .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .accentColor(Color(UIColor.label))
                            })
                        }
                    }
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
        }
    }
}


class SearchManager: ObservableObject{
    @Published var articles = [Articles.Article]()
    @Published var searchParameter: String = ""
    
    func getNews(){
        if !searchParameter.isEmpty{
            NetworkManager.shared.getNewsArticles(searchBy: searchParameter) { articles in
                DispatchQueue.main.async {
                    self.articles = articles
                }
            }
        }
    }
}
