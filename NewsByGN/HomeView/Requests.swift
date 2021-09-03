//
//  Requests.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 02/09/2021.
//

import Foundation

class Requests: ObservableObject{
    var articles = [Articles]()
    
    func getNewsArticles(searchBy: String?){
        var searchParameter: String
        let urlString = "https://gnews.io/api/v4/"
        let token = "&3d36189e692ff476dc16efef4d466898"
        //I dont feal comfortable by placing token in sutch open, but i am doing it on tests purpose.
        
        if searchBy != nil{
            searchParameter = searchBy!
        }else{
            searchParameter = "search?q=example"
        }
        
        guard let url = URL(string: urlString + searchParameter + token) else {
            return
        }
    }
}
