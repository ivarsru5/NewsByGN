//
//  NewsCell.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 01/09/2021.
//

import SwiftUI

struct NewsCell: View {
    var headline: String
    var description: String
    
    var body: some View {
        HStack{
            
            VStack{
                Text(headline)
                    .bold()
                
                Text(description)
                    .font(.subheadline)
            }
        }
        .frame(width: 300, height: 100, alignment: .center)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(headline: "Tests", description: "TestDescription")
    }
}
