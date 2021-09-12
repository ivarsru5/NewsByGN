//
//  FilterSearch.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 06/09/2021.
//

import SwiftUI
import Foundation

struct FilterSearch: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var manager: SearchManager
    @State var clearAll = false
    
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
                    self.manager.startDate = nil
                    self.manager.endDate = nil
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
                        DatePickerTextField(date: $manager.startDate, clearAll: $clearAll, placeHolder: "yyyy/mm/dd")
                            .frame(height: 30)
                            .onTapGesture {
                                self.clearAll = false
                            }
                        
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
                        DatePickerTextField(date: $manager.endDate, clearAll: $clearAll, placeHolder: "yyyy/mm/dd")
                            .frame(height: 30)
                            .onTapGesture {
                                self.clearAll = false
                            }
                        
                        Image(systemName: "calendar")
                            .font(.custom("SF Symbols", size: 20))
                            .foregroundColor(.orange)
                    }
                    
                    Divider()
                        .frame(height: 2)
                        .background(Color.orange)
                }
                .padding(.top, 15)
                
                NavigationLink(destination: SearchInView(title: $manager.title,
                                                         description: $manager.decription,
                                                         content: $manager.content),
                               label: {
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
                manager.filterNews(from: manager.articles, search: manager.searchParameter)
                presentation.wrappedValue.dismiss()
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


struct DatePickerTextField: UIViewRepresentable{
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    @Binding var date: Date?
    @Binding var clearAll: Bool
    public var placeHolder: String
    
    func makeUIView(context: Context) -> UITextField {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self.helper,
                                  action: #selector(self.helper.dateValueChanged),
                                  for: .valueChanged)
        self.textField.placeholder = self.placeHolder
        self.textField.inputView = self.datePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self.helper,
                                         action: #selector(self.helper.doneButtonAction))
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        self.textField.inputAccessoryView = toolBar
        
        self.helper.dateChanged = {
            self.date = self.datePicker.date
            if self.date == nil{
                self.date = self.datePicker.date
            }
        }
        
        self.helper.doneButton = {
            if self.date == nil{
                self.date = self.datePicker.date
            }
            self.textField.resignFirstResponder()
        }
        
        return self.textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = self.date{
            uiView.text = self.dateFormatter.string(from: selectedDate)
        }
        if self.date == nil{
            uiView.text = nil
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    class Coordinator{
        
    }
    
    class Helper{
        public var dateChanged: (() -> Void)?
        public var doneButton: (() -> Void)?
        
        @objc func dateValueChanged(){
            self.dateChanged?()
        }
        @objc func doneButtonAction(){
            self.doneButton?()
        }
    }
}
