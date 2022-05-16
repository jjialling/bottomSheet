# bottomSheet
A Bottom Sheet component made in UIKit.

https://user-images.githubusercontent.com/68376408/168549234-3e02f917-6f58-464b-94bb-5c81569bda5e.mp4

## Usage

When presenting myBottomSheetView you can set its Properties about `defaultMaximumHeight`, `defaultMinimumHeight` and `displayState` to show the different states you want

```swift
let bottomSheet = myBottomSheetView(contentView:scrollView )
    bottomSheet.defaultMaximumHeight = 600
    bottomSheet.defaultMinimumHeight = 200
    bottomSheet.displayState = .maxDisplay
    bottomSheet.frame = self.view.bounds
    view.addSubview(bottomSheet)
    
```
