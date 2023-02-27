import UIKit
import FirebaseAuth
import FirebaseDatabase

class FirebaseDB
{ static var instance : FirebaseDB? = nil
  var database : DatabaseReference? = nil

  static func getInstance() -> FirebaseDB
  { if instance == nil
    { instance = FirebaseDB() }
    return instance!
  }

  init() {
	  //cloud database link
      connectByURL("https://breastcancer-3d45c-default-rtdb.europe-west1.firebasedatabase.app/")
  }

  func connectByURL(_ url: String)
  { self.database = Database.database(url: url).reference()
    if self.database == nil
    { print("Invalid database url")
      return
    }
    self.database?.child("breastCancers").observe(.value,
      with:
      { (change) in
        var keys : [String] = [String]()
        if let d = change.value as? [String : AnyObject]
        { for (_,v) in d.enumerated()
          { let einst = v.1 as! [String : AnyObject]
            let ex : BreastCancer? = BreastCancerDAO.parseJSON(obj: einst)
            keys.append(ex!.id)
          }
        }
        var runtimebreastCancers : [BreastCancer] = [BreastCancer]()
        runtimebreastCancers.append(contentsOf: BreastCancerAllInstances)

        for (_,obj) in runtimebreastCancers.enumerated()
        { if keys.contains(obj.id) {
        	//check
        }
          else
          { killBreastCancer(key: obj.id) }
        }
      })
  }

func persistBreastCancer(x: BreastCancer)
{ let evo = BreastCancerDAO.writeJSON(x: x) 
  if let newChild = self.database?.child("breastCancers").child(x.id)
  { newChild.setValue(evo) }
}

func deleteBreastCancer(x: BreastCancer)
{ if let oldChild = self.database?.child("breastCancers").child(x.id)
  { oldChild.removeValue() }
}

}
