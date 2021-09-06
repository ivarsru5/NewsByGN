//
//  Requests.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 02/09/2021.
//

import Foundation
import SwiftUI

class NetworkManager{
    static let shared = NetworkManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func getNewsArticles(searchBy: String?, completion: @escaping(([Articles.Article]) -> Void)){
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
            if let data = data{
                do{
                    let decodedData = try JSONDecoder().decode(Articles.self, from: data)
                    completion(decodedData.articles)
                }catch{
                    print("Load failed: \(error.localizedDescription)")
                }
            }
        }
        .resume()
    }
    
    func downloadImages(fromURLString urlString: String, completion: @escaping (UIImage?) -> Void){
        let cacsheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacsheKey){
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else{
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: cacsheKey)
            completion(image)
        }
        .resume()
    }
}
