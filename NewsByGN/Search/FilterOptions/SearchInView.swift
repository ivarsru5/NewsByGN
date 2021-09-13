//
//  SearchInView.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 12/09/2021.
//

import SwiftUI

struct SearchInView: View {
    @Environment(\.presentationMode) var presentation
    @State var showAlert = false
    @Binding var title: Bool
    @Binding var description: Bool
    @Binding var content: Bool
    
    var disableButton: Bool{
        if !title && !description && !content{
            return true
        }else{
            return false
        }
    }
    
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
                .disabled(disableButton)
                
                Spacer()
                
                Text("Logo")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                    .padding(.leading, 30)
                
                Spacer()
                
                Button(action: {
                    self.title = false
                    self.description = false
                    self.content = false
                    self.showAlert.toggle()
                }, label: {
                    HStack{
                        Text("Clear")
                            .foregroundColor(.orange)
                        Image(systemName: "trash")
                    }
                })
            }
            .padding()
            
            HStack{
                Text("Search in")
                    .bold()
                    .font(.custom("Text", size: 20))
                
                Spacer()
            }
            .padding()
            
            VStack(spacing: 10){
                Toggle("Title", isOn: $title)
                
                Divider()
                
                Toggle("Decription", isOn: $description)
                
                Divider()
                
                Toggle("Content", isOn: $content)
                
                Divider()
            }
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Whoops..."), message: Text("Please select atleast one parameter to continue."), dismissButton: .default(Text("OK")))
            })
            
            Spacer()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}
