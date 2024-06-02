import SwiftUI

struct ContentView: View {
    @StateObject var userSession = UserSession()
    @StateObject var networkManager = AuthNetworkManager()
    
    
    var body: some View {
//        if(!userSession.isAuthenticated){
//            InitialView().environmentObject(userSession)
//        }else{
//            // if-else lagake role based differentiation
//                        AdminProfileView()
//                            .environmentObject(userSession)
//        }
        
        
        if(networkManager.isLoading)
        {
            ProgressView()
                .environmentObject(networkManager)
        }
        
        else{
            if(userSession.isAuthenticated && !userSession.token.isEmpty){
                            switch userSession.role {
                            case .libraryAdmin:
                                AdminMainView()
                                    .environmentObject(userSession)
                            case .librarian:
                                LibrarianMainView()
                                    .environmentObject(userSession)
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
