//
//  ImageVariationsView.swift
//  swiftUi
//
//  Created by Priyanka Pandey on 18/03/25.
//


import SwiftUI

struct TextFieldVariationsView: View {
    @State private var textInput: String = ""
    @State private var secureInput: String = ""
    @State private var emailInput: String = ""
    @State private var numberInput: String = ""
    @State private var multilineInput: String = ""
    @State private var searchInput: String = ""
    @State private var charLimitedInput: String = ""
    @State private var isValidEmail: Bool = true
    @State private var urlInput: String = ""
    
    var body: some View {
        List {
            Section(header: Text("Basic TextField").padding(.vertical, 10)) {
                TextField("Enter text", text: $textInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Section(header: Text("SecureField (Password)").padding(.vertical, 10)) {
                SecureField("Enter password", text: $secureInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Section(header: Text("Email Validation").padding(.vertical, 10)) {
                TextField("Enter email", text: $emailInput, onEditingChanged: { _ in
                    validateEmail()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .border(isValidEmail ? Color.gray : Color.red, width: 1)
                Text(isValidEmail ? "" : "Invalid email format").foregroundColor(.red)
            }
            
            Section(header: Text("Number Input").padding(.vertical, 10)) {
                TextField("Enter number", text: $numberInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("URL Input").padding(.vertical, 10)) {
                TextField("Enter URL", text: $urlInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.URL)
                    .autocapitalization(.none)
            }
            
            Section(header: Text("Multiline TextEditor").padding(.vertical, 10)) {
                TextEditor(text: $multilineInput)
                    .frame(height: 100)
                    .border(Color.gray, width: 1)
            }
            
            Section(header: Text("Search Bar").padding(.vertical, 10)) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search...", text: $searchInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(
                            Button(action: { searchInput = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 8), alignment: .trailing
                        )
                }
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            Section(header: Text("Character Limit").padding(.vertical, 10)) {
                TextField("Max 10 characters", text: $charLimitedInput)
                    .onChange(of: charLimitedInput) { newValue in
                        if newValue.count > 10 {
                            charLimitedInput = String(newValue.prefix(10))
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .navigationTitle("TextField Variations")
    }
    
    private func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        isValidEmail = predicate.evaluate(with: emailInput)
    }
}

struct TextFieldVariationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TextFieldVariationsView()
        }
    }
}
