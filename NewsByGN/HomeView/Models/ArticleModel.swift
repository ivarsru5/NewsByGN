//
//  ArticleModel.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 02/09/2021.
//

import Foundation

struct Articles: Decodable{
    var title: String
    var description: String
    var content: String
    var url: String
    var image: String
    var publishedAt: String
    var source: String
}
