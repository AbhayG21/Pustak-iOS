//
//  SignUpView.swift
//  pustak
//
//  Created by Abhay(IOS) on 29/05/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var confirm: String = ""
    var body: some View {
        NavigationStack {
            ZStack {
//                BackgroundCirclesView()
                ScrollView {
                    VStack(alignment: .center, spacing: 48) {
                            VStack {
                                Image("login")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:200,height:200)
                            }
                        VStack{
                            InputField(text: $name, placeholder: "Full name", cornerRadius: 10)
                                
                           InputField(text: $email, placeholder: "Email", cornerRadius: 10)
                            
                            InputField(text: $phone, placeholder: "Phone number", cornerRadius: 10,inputType: .mobNo)
                            
                        }
                        
                        VStack{
                            InputField(text: $password, placeholder: "Password", cornerRadius: 10,isSecure: true,inputType: .password)
                            InputField(text: $confirm, placeholder: "Confirm password", cornerRadius: 10,inputType: .password)
                        }
                        
                            VStack {
                                NavLink(text: "Proceed", cornerRadius: 10)
                                    .disabled(email.isEmpty || password.isEmpty || name.isEmpty || phone.isEmpty || confirm.isEmpty || (password != confirm))
//                                                .opacity(email.isEmpty || password.isEmpty || name.isEmpty || phone.isEmpty || confirm.isEmpty ? 0.5 : 1.0)
                            }
                            
                    }.padding(EdgeInsets(top: 48, leading: 16, bottom: 16, trailing: 16))
                        .scrollIndicators(.hidden)
                }
            }
            .background(.customBackground)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
