import Foundation
import SwiftUI


enum InputTypes: String, CaseIterable{
    case email
    case password
    case name
    case mobNo
}
struct InputField: View {
    @Binding var text: String
    var placeholder: String
    var cornerRadius: CGFloat
    var onEditingChanged: (Bool) -> Void = {_ in}
    var onCommit: () -> Void = {}
    var isSecure: Bool = false
    var inputType: InputTypes = .name
    
    var body: some View {
        if(!isSecure){
            TextField(placeholder, text: $text, onEditingChanged: onEditingChanged, onCommit: onCommit)
                .keyboardType(keyboardType(inputType))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding()
                .frame(height: 50)
                .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.accentColor))
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }else{
            SecureField(placeholder, text: $text, onCommit: onCommit)
                .padding()
                .frame(height: 50)
                .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.accentColor))
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))

        }
    }
    private func keyboardType(_ inputType: InputTypes) -> UIKeyboardType {
        switch inputType {
        case .email:
                .emailAddress
        case .password, .name:
                .default
        case .mobNo:
                .decimalPad
        }
        
    }
}

#Preview{
    InitialView()
}
