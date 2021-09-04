//
//  ArticleModel.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 02/09/2021.
//

import Foundation

struct Articles: Codable {
    var articles: [Article]
    
    struct Article: Codable{
        var id = UUID()
        var title: String
        var description: String
        
        enum CodingKeys: String, CodingKey{
            case title
            case description
        }
    }
}
