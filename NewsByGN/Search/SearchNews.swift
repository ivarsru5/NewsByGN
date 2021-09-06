//
//  SearchNews.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 01/09/2021.
//

import SwiftUI

enum CurrentView{
    case search
    case news
}

struct SearchNews: View {
    @StateObject var searchManager = SearchManager()
    @State var currentView: CurrentView = .search
    
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
                                        self.searchManager.getNews(search: searchManager.searchParameter)
                                        self.currentView = .news
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
                    
                    if currentView == .search{
                        SearchHistoryView(searchManager: searchManager, currentView: $currentView)
                    } else if currentView == .news{
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
    @Published var searchHistory: [String] = UserDefaults.standard.searchHistory{
        didSet{
            UserDefaults.standard.searchHistory = self.searchHistory
        }
    }
    
    func getNews(search byParameter: String){
        if !searchParameter.isEmpty{
            NetworkManager.shared.getNewsArticles(searchBy: byParameter) { articles in
                DispatchQueue.main.async {
                    self.articles = articles
                    
                    if let index = UserDefaults.standard.searchHistory.firstIndex(of: self.searchParameter){
                        UserDefaults.standard.searchHistory.remove(at: index)
                    }
                    
                    if UserDefaults.standard.searchHistory.count == 10{
                        UserDefaults.standard.searchHistory.removeLast()
                        UserDefaults.standard.searchHistory.append(self.searchParameter)
                    }else{
                        UserDefaults.standard.searchHistory.append(self.searchParameter)
                    }
                }
            }
        }
    }
}

struct SearchHistoryView: View{
    @ObservedObject var searchManager: SearchManager
    @Binding var currentScreen: CurrentView
    
    init(searchManager: SearchManager, currentView: Binding<CurrentView>){
        self.searchManager = searchManager
        self._currentScreen = currentView
        UITableView.appearance().backgroundColor = UIColor.systemGray6
    }
    
    var body: some View{
        List{
            Section(header: Text("Search History"), content: {
                ForEach(searchManager.searchHistory, id:\.self){ parameter in
                    Text(parameter)
                        .onTapGesture {
                            searchManager.searchParameter = parameter
                            searchManager.getNews(search: parameter)
                            currentScreen = .news
                    }
                }
            })
        }
    }
}
