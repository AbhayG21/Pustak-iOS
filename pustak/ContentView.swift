import SwiftUI

struct ContentView: View {
    @StateObject var userSession = UserSession()
    @StateObject var networkManager = AuthNetworkManager()
    @StateObject var adminManager = AdminManager()
    var body: some View {
        if(networkManager.isLoading)
        {
            ProgressView()
        }
        
        else{
            if(userSession.isAuthenticated && !userSession.token.isEmpty){
                            switch userSession.role {
                            case .libraryAdmin:
                                AdminMainView()
                                    .environmentObject(userSession)
                                    .environmentObject(adminManager)
                            case .librarian:
                                LibrarianMainView()
                                    .environmentObject(userSession)
                                    .environmentObject(adminManager)
                            case .member:
                                EmptyView()
                                    .environmentObject(userSession)
                            }
                        }else{
                            InitialView()
                                .environmentObject(userSession)
                                .environmentObject(networkManager)
                        }
        }
    }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
