import Foundation

class BreastCancerDAO
{ static func getURL(command : String?, pars : [String], values : [String]) -> String
  { var res : String = "base url for the data source"
    if command != nil
    { res = res + command! }
    if pars.count == 0
    { return res }
    res = res + "?"
    for (i,v) in pars.enumerated()
    { res = res + v + "=" + values[i]
      if i < pars.count - 1
      { res = res + "&" }
    }
    return res
  }

  static func isCached(id : String) -> Bool
    { let x : BreastCancer? = BreastCancer.breastCancerIndex[id]
    if x == nil 
    { return false }
    return true
  }

  static func getCachedInstance(id : String) -> BreastCancer
    { return BreastCancer.breastCancerIndex[id]! }

  static func parseCSV(line: String) -> BreastCancer?
  { if line.count == 0
    { return nil }
    let line1vals : [String] = Ocl.tokeniseCSV(line: line)
    var breastCancerx : BreastCancer? = nil
      breastCancerx = BreastCancer.breastCancerIndex[line1vals[0]]
    if breastCancerx == nil
    { breastCancerx = createByPKBreastCancer(key: line1vals[0]) }
    breastCancerx!.id = line1vals[0]
    breastCancerx!.age = Int(line1vals[1]) ?? 0
    breastCancerx!.bmi = Float(line1vals[2]) ?? 0
    breastCancerx!.glucose = Float(line1vals[3]) ?? 0
    breastCancerx!.insulin = Float(line1vals[4]) ?? 0
    breastCancerx!.homa = Float(line1vals[5]) ?? 0
    breastCancerx!.leptin = Float(line1vals[6]) ?? 0
    breastCancerx!.adiponectin = Float(line1vals[7]) ?? 0
    breastCancerx!.resistin = Float(line1vals[8]) ?? 0
    breastCancerx!.mcp = Float(line1vals[9]) ?? 0
    breastCancerx!.outcome = line1vals[10]

    return breastCancerx
  }

  static func parseJSON(obj : [String : AnyObject]?) -> BreastCancer?
  {

    if let jsonObj = obj
    { let id : String? = jsonObj["id"] as! String?
      var breastCancerx : BreastCancer? = BreastCancer.breastCancerIndex[id!]
      if (breastCancerx == nil)
      { breastCancerx = createByPKBreastCancer(key: id!) }

       breastCancerx!.id = jsonObj["id"] as! String
       breastCancerx!.age = jsonObj["age"] as! Int
       breastCancerx!.bmi = jsonObj["bmi"] as! Float
       breastCancerx!.glucose = jsonObj["glucose"] as! Float
       breastCancerx!.insulin = jsonObj["insulin"] as! Float
       breastCancerx!.homa = jsonObj["homa"] as! Float
       breastCancerx!.leptin = jsonObj["leptin"] as! Float
       breastCancerx!.adiponectin = jsonObj["adiponectin"] as! Float
       breastCancerx!.resistin = jsonObj["resistin"] as! Float
       breastCancerx!.mcp = jsonObj["mcp"] as! Float
       breastCancerx!.outcome = jsonObj["outcome"] as! String
      return breastCancerx!
    }
    return nil
  }

  static func writeJSON(x : BreastCancer) -> NSDictionary
  { return [    
       "id": x.id as NSString, 
       "age": NSNumber(value: x.age), 
       "bmi": NSNumber(value: x.bmi), 
       "glucose": NSNumber(value: x.glucose), 
       "insulin": NSNumber(value: x.insulin), 
       "homa": NSNumber(value: x.homa), 
       "leptin": NSNumber(value: x.leptin), 
       "adiponectin": NSNumber(value: x.adiponectin), 
       "resistin": NSNumber(value: x.resistin), 
       "mcp": NSNumber(value: x.mcp), 
       "outcome": x.outcome as NSString
     ]
  } 

  static func makeFromCSV(lines: String) -> [BreastCancer]
  { var res : [BreastCancer] = [BreastCancer]()

    if lines.count == 0
    { return res }

    let rows : [String] = Ocl.parseCSVtable(rows: lines)

    for (_,row) in rows.enumerated()
    { if row.count == 0 {
    	//check
    }
      else
      { let x : BreastCancer? = parseCSV(line: row)
        if (x != nil)
        { res.append(x!) }
      }
    }
    return res
  }
}

