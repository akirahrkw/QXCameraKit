import Foundation

class HttpAsynchronousRequest:NSObject {
    
    var apiName:NSString
    
    var receiveData:NSMutableData
    
    var closure:APIResponseClosure
    
    var url:NSString
    
    var params:NSString
    
    init(url:NSString, postParams params:NSString, apiName name:NSString, closure:APIResponseClosure) {
        self.receiveData = NSMutableData()
        self.url = url
        self.params = params
        self.apiName = name
        self.closure = closure
    }
    
    func execute(){
        let url = NSURL(string:self.url as String)
        let request = NSMutableURLRequest(URL:url!, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval:10.0)
        request.HTTPMethod = "POST"
        request.HTTPBody = self.params.dataUsingEncoding(NSUTF8StringEncoding)
        
        let connection = NSURLConnection(request:request, delegate:self, startImmediately:false)
        connection!.start()
    }
    
    func connection(connection:NSURLConnection, didReceiveResponse response:NSURLResponse) {
        self.receiveData.length = 0
    }
    
    func connection(connection:NSURLConnection, didReceiveData data:NSData) {
        self.receiveData.appendData(data)
    }

    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        NSLog("HttpRequest didFailWithError = %@", error)
        let errorResponse = "{ \"id\"= 0 , \"error\"=[16,\"Transport Error\"]}"
        let data = errorResponse.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)

        do {
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            self.closure(json:dict, isSucceeded:false)
        } catch {
            self.closure(json:[String: AnyObject](), isSucceeded:false)
        }
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        do {
            let dict = try NSJSONSerialization.JSONObjectWithData(self.receiveData, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
            self.closure(json:dict, isSucceeded:true)
        } catch {
            self.closure(json:[String: AnyObject](), isSucceeded:true)
        }
    }
}