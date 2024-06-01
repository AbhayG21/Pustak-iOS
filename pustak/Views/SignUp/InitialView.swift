import SwiftUI

struct InitialView: View {
    @State private var email: String = ""
    @State private var password: String = ""
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
                                    .frame(width:350,height:300)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            }
                        VStack{
                            InputField(text: $email, placeholder: "Email", cornerRadius: 10,inputType: .email)
                            InputField(text: $password, placeholder: "Password", cornerRadius: 10,isSecure: true,inputType: .password)
                        }
                            VStack {
                                NavigationLink(destination: EmptyView()) {
                                    NavLink(text:"Login", cornerRadius: 10)
                                }.disabled(email.isEmpty || password.isEmpty)
                                    
                                
                                HStack{
                                    Rectangle()
                                        .frame(height: 1)
                                        .background(Color.gray)
                                    Text("OR")
                                        .padding(.horizontal,10)
                                        .foregroundColor(.gray)
                                    Rectangle()
                                        .frame(height: 1)
                                        .background(Color.gray)
                                }
                                .padding(.horizontal)
                                NavigationLink(destination:SignUpView())
                                {
                                    NavLink(text: "Sign Up", cornerRadius: 10)
                                }
                            }
                            
                    }.padding(EdgeInsets(top: 48, leading: 16, bottom: 16, trailing: 16))
                        .scrollIndicators(.hidden)
                }
            }
            .background(Color.customBackground)
        }
    }
        
}


