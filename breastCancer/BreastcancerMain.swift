              
              
import SwiftUI
import Firebase

@main 
struct breastcancerMain : App {
			
	init() {
	    FirebaseApp.configure()
	       }

	var body: some Scene {
	        WindowGroup {
	            ContentView(model: ModelFacade.getInstance())
	        }
	    }
	} 
