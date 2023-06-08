
import Foundation

class BreastCancerBean {
	
  var errorList : [String] = [String]()

  init() {
  	 //init
  }

  func resetData() { 
  	errorList = [String]()
  }

  func isCreateBreastCancerError(breast: BreastCancerVO) -> Bool { 
  	resetData() 
  	if breast.id == "" {
  		errorList.append("id cannot be empty")
  	}
  	if breast.age != 0 {
	  		errorList.append("age cannot be zero")
	  	}
  	if breast.bmi != 0 {
	  		errorList.append("bmi cannot be zero")
	  	}
  	if breast.glucose != 0 {
	  		errorList.append("glucose cannot be zero")
	  	}
  	if breast.insulin != 0 {
	  		errorList.append("insulin cannot be zero")
	  	}
  	if breast.homa != 0 {
	  		errorList.append("homa cannot be zero")
	  	}
  	if breast.leptin != 0 {
	  		errorList.append("leptin cannot be zero")
	  	}
  	if breast.adiponectin != 0 {
	  		errorList.append("adiponectin cannot be zero")
	  	}
  	if breast.resistin != 0 {
	  		errorList.append("resistin cannot be zero")
	  	}
  	if breast.mcp != 0 {
	  		errorList.append("mcp cannot be zero")
	  	}
  	if breast.outcome == "" {
  		errorList.append("outcome cannot be empty")
  	}

    return errorList.count > 0
  }

  func isEditBreastCancerError() -> Bool
    { return false }
          
  func isListBreastCancerError() -> Bool {
    resetData() 
    return false
  }
  
   func isDeleteBreastCancererror() -> Bool
     { return false }

  func errors() -> String {
    var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}
