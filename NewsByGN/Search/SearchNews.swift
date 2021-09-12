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
    @State var dislayModalView = false
    
    var body: some View {
        NavigationView{
            ZStack{
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
                                    
                                    
                                    NavigationLink(destination: FilterSearch(manager: searchManager), label: {
                                        Circle()
                                            .frame(width: 53, height: 53)
                                            .foregroundColor(Color(UIColor.systemGray6))
                                            .overlay(Image(systemName: "square.and.pencil")
                                                        .foregroundColor(Color.secondary))
                                    })
                                    
                                    Button(action: {
                                        dislayModalView.toggle()
                                    }, label: {
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
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
            HalfModalView(isShown: $dislayModalView, modalHeight: 400){
                VStack{
                    
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


class SearchManager: ObservableObject{
    @Published var articles = [Articles.Article]()
    @Published var searchParameter: String = ""
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var title = true
    @Published var decription = true
    @Published var content = true
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
                        UserDefaults.standard.searchHistory.removeFirst()
                        UserDefaults.standard.searchHistory.append(self.searchParameter)
                    }else{
                        UserDefaults.standard.searchHistory.append(self.searchParameter)
                    }
                }
            }
        }
    }
    
    func filterNews(from articles: [Articles.Article], search parameter: String){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        
        let searchedArticles = searchIn(from: articles,
                                        title: self.title,
                                        description: self.decription,
                                        content: self.content,
                                        search: parameter)
        
        self.articles = searchedArticles.compactMap({ article in
            var comparedArticle: Articles.Article?
            
            guard let articleDate = formatter.date(from: article.publishedAt) else{
                return nil
            }
            
            if startDate != nil && endDate != nil{
                if articleDate > startDate! && articleDate < endDate!{
                    comparedArticle = article
                }
            }
            return comparedArticle
        })
    }
    
    func searchIn(from atricles: [Articles.Article] ,title: Bool, description: Bool, content: Bool, search parameter: String) -> [Articles.Article]{
        var filteredArticles = [Articles.Article]()
        
        for searchArticle in articles{
            
            if title{
                if seperateString(articleString: searchArticle.title, search: parameter){
                    filteredArticles.append(searchArticle)
                }
            }else if description{
                if seperateString(articleString: searchArticle.description, search: parameter){
                    filteredArticles.append(searchArticle)
                }
            }else if content{
                if seperateString(articleString: searchArticle.content, search: parameter){
                    filteredArticles.append(searchArticle)
                }
            }
        }
        return filteredArticles
    }
    
    func seperateString(articleString: String, search paramater: String) -> Bool{
        let array = articleString.components(separatedBy: " ")
        if array.contains(paramater){
            return true
        }else{
            return false
        }
    }
}
