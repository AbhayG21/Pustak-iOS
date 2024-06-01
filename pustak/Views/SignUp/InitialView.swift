//import SwiftUI
//
//struct InitialView: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var isLoading: Bool = false
//    @State private var navigateToNextScreen: Bool = false
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(alignment: .center, spacing: 48) {
//                    VStack {
//                        Image("login")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width:350,height:300)
//                    }
//                    VStack{
//                        InputField(text: $email, placeholder: "Email", cornerRadius: 10,inputType: .email)
//                        InputField(text: $password, placeholder: "Password", cornerRadius: 10,isSecure: true,inputType: .password)
//                    }
//                    VStack {
//                        NavigationLink(destination: roleDecider(email: email, password: password)) {
//                            NavLink(text:"Login", cornerRadius: 10)
//                        }.disabled(email.isEmpty || password.isEmpty || !isValidEmail(email))
//                        
//                        
//                        HStack{
//                            Rectangle()
//                                .frame(height: 1)
//                                .background(Color.gray)
//                            Text("OR")
//                                .padding(.horizontal,10)
//                                .foregroundColor(.gray)
//                            Rectangle()
//                                .frame(height: 1)
//                                .background(Color.gray)
//                        }
//                        .padding(.horizontal)
//                        NavigationLink(destination:SignUpView())
//                        {
//                            NavLink(text: "Sign Up", cornerRadius: 10)
//                        }
//                    }
//                    
//                }.padding(EdgeInsets(top: 48, leading: 16, bottom: 16, trailing: 16))
//                    .scrollIndicators(.hidden)
//            }
//            .navigationTitle("Log In")
//        }
//        .background(Color.customBackground)
//    }
//}
//
//
//
//
//#Preview{
//    InitialView()
//}
//
//

import SwiftUI

struct InitialView: View {
    @EnvironmentObject var userSession: UserSession
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var userRole: Role = .none

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 48) {
                    VStack {
                        Image("login")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350, height: 300)
                    }
                    VStack {
                        InputField(text: $email, placeholder: "Email", cornerRadius: 10, inputType: .email)
                        InputField(text: $password, placeholder: "Password", cornerRadius: 10, isSecure: true, inputType: .password)
                    }
                    VStack {
                        if isLoading {
                            ProgressView()
                                .frame(width: 100, height: 50)
                        } else {
                            Button(action: {
                                loginUser()
                            }) {
                                NavLink(text: "Login", cornerRadius: 10)
                            }
                            .disabled(email.isEmpty || password.isEmpty || !isValidEmail(email))
                        }

                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .background(Color.gray)
                            Text("OR")
                                .padding(.horizontal, 10)
                                .foregroundColor(.gray)
                            Rectangle()
                                .frame(height: 1)
                                .background(Color.gray)
                        }
                        .padding(.horizontal)

                        NavigationLink(destination: SignUpView()) {
                            NavLink(text: "Sign Up", cornerRadius: 10)
                        }
                    }

                }
                .padding(EdgeInsets(top: 48, leading: 16, bottom: 16, trailing: 16))
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Log In")
            .background(Color.customBackground)
//            .navigationDestination(isPresented: $navigateToNextScreen) {
//                getDestinationView(for: userRole)
//            }
        }
    }

    func loginUser() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            userRole = checkUserRole(email: email, password: password)
            isLoading = false
            userSession.isAuthenticated = true
//            navigateToNextScreen = true
        }
    }
}



struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
