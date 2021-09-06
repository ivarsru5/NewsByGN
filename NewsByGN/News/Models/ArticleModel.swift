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
        var image: String
        var newsUrl: String
        
        enum CodingKeys: String, CodingKey{
            case title
            case description
            case image
            case newsUrl = "url"
        }
    }
}
