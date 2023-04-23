# bottomSheet
A Bottom Sheet component made in UIKit.

https://user-images.githubusercontent.com/68376408/168549234-3e02f917-6f58-464b-94bb-5c81569bda5e.mp4

## Usage

When presenting myBottomSheetView you can set its Properties about `maximumContainerHeight`, `currentContainerHeight` and `cornerRadius` to show the different states you want

```swift
let bottomSheet = myBottomSheetView(contentView: self.scrollView, targetView: self.view, targetViewController: self)
    bottomSheet.maximumContainerHeight = 600
    bottomSheet.currentContainerHeight = 200
    bottomSheet.cornerRadius = 20
    bottomSheet.bgColor = .white
    view.addSubview(bottomSheet)
    
```
