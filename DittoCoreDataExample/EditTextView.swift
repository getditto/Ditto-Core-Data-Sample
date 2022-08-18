//
//  EditTextView.swift
//  DittoCoreDataExample
//
//  Created by Neil Ballard on 7/27/22.
//

import Foundation
import SwiftUI
import CoreData
struct EditTextView: View {
    
    var callback: ((String) -> Void)
    @State var text = ""
    @Environment(\.presentationMode) var presentationMode
    
    init(text: String?, _ callback: @escaping (String) -> Void) {
        self.callback = callback
        if let text = text {
            self.text = text
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Enter Some Text").foregroundColor(.black)
                TextField("", text: $text).foregroundColor(.black).accentColor(.black).frame(width: 300, height: 300, alignment: .center).textFieldStyle(.roundedBorder)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: saveText) {
                        Text("Save")
                    }
                }
            }
        }
        
    }
    
    func saveText() {
        self.callback(text)
        presentationMode.wrappedValue.dismiss()
    }
}

