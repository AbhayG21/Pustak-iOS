import SwiftUI

struct ContentView: View {
    @StateObject var userSession = UserSession()
    var body: some View {
        if(!userSession.isAuthenticated){
            InitialView().environmentObject(userSession)
        }else{
            // if-else lagake role based differentiation
                        AdminProfileView()
                            .environmentObject(userSession)
        }
    }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
