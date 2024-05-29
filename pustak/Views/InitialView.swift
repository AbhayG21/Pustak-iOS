import SwiftUI

struct InitialView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundCirclesView()
                ScrollView {
                    VStack(alignment: .center, spacing: 48) {
                            VStack {
                                Image("G5")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                            }
                        VStack{
                            TextField("Username", text: $username)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                            VStack {
                                NavigationLink(destination: BackgroundCirclesView()) {
                                    NavLink(text:"Login", cornerRadius: 15)
                                }
                                // Create Account Text
                                NavigationLink(destination:SignUpView()){
                                    Text("Sign up as a user")
                                        .foregroundStyle(Color.black)
                                }
                            }
                            
                    }.padding(EdgeInsets(top: 48, leading: 16, bottom: 16, trailing: 16))
                        .scrollIndicators(.hidden)
                }
            }
            
        }
    }
}


struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
