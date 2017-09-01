import UIKit

class TokenRequestHandler {
    
    class func postDataFrom(params:[String:String]) -> String {
        var data = ""
        
        for (key, value) in params {
            if let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                if !data.isEmpty {
                    data = data + "&"
                }
                data = encodedKey + "=" + encodedValue;
            }
        }
        
        return data
    }

   //class func fetchToken(params:[String:String], completion:@escaping (NSDictionary, NSError?) -> Void)
  class func fetchToken(params:[String:String], completion:@escaping (String, NSError?) -> Void) {
    
    let identity = params["identity"]!
    let deviceId = params["endpointId"]!
    let urlString = "http://10.10.10.140:8080/getToken?identity=\(identity)&endpointId=\(deviceId)"
    print("\(urlString)")
    let requestURL: URL = URL(string: urlString)!
    print("\(requestURL)")
    
    do {
        let data = try Data(contentsOf: requestURL)
        let error = NSError()
        if let returnData = String(data: data, encoding: .utf8) {
            completion(returnData, error as NSError?)
        }else {
            completion(String(),  NSError(domain: "TWILIO", code: 1000, userInfo: [NSLocalizedDescriptionKey: "Incorrect return code for token request."]))
        }
    } catch let error as NSError {
        completion(String(), error)
    }
    
    /*
    if let filePath = Bundle.main.path(forResource: "Keys", ofType:"plist"),
      let dictionary = NSDictionary(contentsOfFile:filePath) as? [String: AnyObject],
      let tokenRequestUrl = dictionary["TokenRequestUrl"] as? String
    {
        //"http://10.10.10.140:8080/getToken?identity=\(identity)&endpointId=\(deviceId)"
        var request = URLRequest(url: URL(string: tokenRequestUrl)!)
        request.httpMethod = "POST"
        let postString = self.postDataFrom(params: params)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                completion(String(), NSError(domain: "TWILIO", code: 1000, userInfo: [NSLocalizedDescriptionKey: "Incorrect return code for token request."]))
                //completion(NSDictionary(), NSError(domain: "TWILIO", code: 1000, userInfo: [NSLocalizedDescriptionKey: "Incorrect return code for token request."]))
                return
            }
            
            if let returnData = String(data: data, encoding: .utf8) {
                completion(returnData, error as NSError?)
            }else {
                completion(String(),  NSError(domain: "TWILIO", code: 1000, userInfo: [NSLocalizedDescriptionKey: "Incorrect return code for token request."]))
            }
            
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
//                print("json = \(json)")
//                completion(json as NSDictionary, error as NSError?)
//            } catch let error as NSError {
//                completion(NSDictionary(), error)
//            }
        }
        task.resume()
    }
    else {
      let userInfo = [NSLocalizedDescriptionKey : "TokenRequestUrl Key is missing"]
      let error = NSError(domain: "app", code: 404, userInfo: userInfo)

      //completion(NSDictionary(), error)
        completion(String(), error)
    }*/
  }
}
