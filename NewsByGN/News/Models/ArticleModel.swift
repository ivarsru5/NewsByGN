//
//  ArticleModel.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 02/09/2021.
//

import Foundation
import SwiftUI

struct Articles: Codable {
    var articles: [Article]
    
    struct Article: Codable, Identifiable{
        var id = UUID()
        var title: String
        var description: String
        var content: String
        var newsUrl: String
        var image: String
        var publishedAt: String
        
        enum CodingKeys: String, CodingKey{
            case title
            case description
            case content
            case newsUrl = "url"
            case image
            case publishedAt
        }
    }
}
