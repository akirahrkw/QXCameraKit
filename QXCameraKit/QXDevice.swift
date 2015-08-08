import Foundation

class QXDevice {
    
    var friendlyName:NSString?
    
    var version:NSString?
    
    var services:NSMutableDictionary
    
    init() {
        self.services = NSMutableDictionary()
    }
    
    func addService(serviceName name:NSString, serviceUrl url:NSString) {
        self.services.setObject(url.stringByAppendingFormat("/%@", name), forKey:name)
    }
    
    func findActionListUrl(service:NSString) -> NSString {
        let value = self.services.objectForKey(service) as? NSString
        return (value != nil) ? value! : "camera"
    }
}