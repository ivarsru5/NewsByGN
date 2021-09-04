//
//  Requests.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 02/09/2021.
//

import Foundation

class Requests: ObservableObject{
    @Published var articles = [Articles.Article]()
    
    func getNewsArticles(searchBy: String?){
        var searchParameter: String
        let urlString = "https://gnews.io/api/v4/"
        let token = "&token=3d36189e692ff476dc16efef4d466898"
        //I dont feal comfortable by placing token in sutch open, but i am doing it on tests purpose.
        
        if searchBy != nil{
            searchParameter = searchBy!
        }else{
            searchParameter = "search?q=example"
        }
        
        guard let url = URL(string: urlString + searchParameter + token) else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let data = data{
                    do{
                        let decodedData = try JSONDecoder().decode(Articles.self, from: data)
                            self.articles = decodedData.articles
                    }catch{
                        
                    }
                }
            }
        }
        .resume()
    }
}
