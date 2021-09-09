//
//  FilterSearch.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 06/09/2021.
//

import SwiftUI

struct FilterSearch: View {
    @Environment(\.presentationMode) var presentation
    @State var filterDate = ""
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.orange)
                        .font(.custom("SF Sybols", size: 25))
                })
                
                Spacer()
                
                Text("Logo")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                    .padding(.leading, 30)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    HStack{
                        Text("Clear")
                            .foregroundColor(.orange)
                        Image(systemName: "trash")
                    }
                })
            }
            .padding()
            VStack{
                HStack{
                    Text("Filter")
                        .font(.custom("Text", size: 28).bold())
                    
                    Spacer()
                }
                .padding(.init(top: 5, leading: 15, bottom: 5, trailing: 0))
                
                HStack{
                    Text("Date")
                        .font(.custom("Text", size: 20).bold())
                    
                    Spacer()
                }
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 0))
            }
            
            VStack{
                VStack{
                    HStack{
                        Text("From")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                        
                        Spacer()
                    }
                    
                    HStack{
                        TextField("yyyy/mm/dd", text: $filterDate)
                        
                        Image(systemName: "calendar")
                            .font(.custom("SF Symbols", size: 20))
                            .foregroundColor(.orange)
                    }
                    
                    Divider()
                        .frame(height: 2)
                        .background(Color.orange)
                }
                
                VStack{
                    HStack{
                        Text("To")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                        
                        Spacer()
                    }
                    
                    HStack{
                        TextField("yyyy/mm/dd", text: $filterDate)
                        
                        Image(systemName: "calendar")
                            .font(.custom("SF Symbols", size: 20))
                            .foregroundColor(.orange)
                    }
                    
                    Divider()
                        .frame(height: 2)
                        .background(Color.orange)
                }
                .padding(.top, 15)
                
                NavigationLink(destination: EmptyView(), label: {
                    HStack{
                        Text("Search in")
                            .bold()
                        
                        Spacer()
                        
                        Text("All")
                            .bold()
                            .foregroundColor(.secondary)
                    }
                })
                .padding(.top, 25)
                
                Divider()
                    .frame(height: 2)
                    .padding(.top, 10)
            }
            .padding()
            
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 400, height: 50, alignment: .center)
                        .foregroundColor(.orange)
                    
                    Text("Apply filter")
                        .bold()
                        .foregroundColor(Color(UIColor.systemBackground))
                }
            })
            .padding(.bottom, 10)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct FilterSearch_Previews: PreviewProvider {
    static var previews: some View {
        FilterSearch()
    }
}
