//
//  NewsView.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 01/09/2021.
//

import SwiftUI

struct NewsView: View {
    @StateObject var request = Requests()
    
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 50)
                    .shadow(radius: 10)
                
                Text("Logo")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.orange)
            }
            .padding(.bottom)
            VStack{
                HStack{
                    Text("News")
                        .bold()
                        .padding(.leading, 15)
                    
                    Spacer()
                }
                .padding(.top, 25)
                
                List{
                    ForEach(request.articles, id: \.id){ article in
                        NewsCell(headline: article.title, description: article.description)
                    }
                }
            }
        }
        .onAppear{
            request.getNewsArticles(searchBy: nil)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
