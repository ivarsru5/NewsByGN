//
//  SearchNews.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 01/09/2021.
//

import SwiftUI

struct SearchNews: View {
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 100)
                    .shadow(radius: 10)
                
                Text("Logo")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.orange)
            }
            .padding(.bottom)
            
            Spacer()
        }
    }
}

struct SearchNews_Previews: PreviewProvider {
    static var previews: some View {
        SearchNews()
    }
}
