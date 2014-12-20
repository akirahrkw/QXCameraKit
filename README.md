# QXCameraKit

swift API library for Sony QX camera
this library provides API wrapper to connect to Sony QX Camera easily.

this library is originally based on Camera Remote API beta SDK from Sony
http://www.sony.net/Products/di/en-gb/products/ec8t/
https://developer.sony.com/develop/cameras/
https://developer.sony.com/2013/11/29/how-to-develop-an-app-using-the-camera-remote-api-2/

### Demo

http://instagram.com/p/txmivXPIm7/

### Examples

please check this sample app
https://github.com/akirahrkw/SampleQXCameraKit

### Using blocks

```swift
import QXCameraKit

...

manager = QXAPIManager()
manager.openConnection({[unowned self] (result:Bool, error:NSError?) -> () in
    if(result) {
        manager.startLiveImage({ [unowned self] (image:UIImage, error:NSError?) -> () in
...
...
...
        })
    }
})

```

### Podfile
coming soon...

### Author
* Akira Hirakawa (http://www.akirahrkw.com)

## Licenses
All source code is licensed under the [MIT License](http://opensource.org/licenses/MIT)