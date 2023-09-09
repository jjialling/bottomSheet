# bottomSheet
A Bottom Sheet component made in UIKit.

https://github.com/jjialling/bottomSheet/assets/68376408/6aa24d08-f3cb-4699-af25-beaea7c75082


## Usage

When presenting myBottomSheetView you can set its Properties about `mininumHeight`, `maximumHeight` and `dismissibleHeight` to show the different states you want

```swift
// Declare bottomSheet
private lazy var bottomSheet: myBottomSheetView = {
    let bottomSheet = myBottomSheetView(contentView: self.scrollView, targetView: self.view, targetViewController: self)
    return bottomSheet
}()

override func viewDidLoad() {
    super.viewDidLoad()
    // Setup BottomSheet in viewDidLoad
    setupBottomSheet()
}

func setupBottomSheet()  {
    // Customization
    bottomSheet.mininumHeight = 200
    bottomSheet.maximumHeight = 600
    bottomSheet.dismissibleHeight = 150
    bottomSheet.bgColor = .magenta
    bottomSheet.cornerRadius = 10
    bottomSheet.bottomSheetViewMode = .normal
 }
    
```
## Customization

```swift
/// Set height it will dismiss
let dismissibleHeight: CGFloat

/// Set maximum height
let maximumHeight: CGFloat

/// Set mininum height
let mininumHeight: CGFloat

/// Set corner
let cornerRadius: CGFloat

/// Set background color
let bgColor: UIColor

/// Set navigation title
let title: String

/// Set navigation view
let navgationView: UIView?

/// if the sheet dismiss finished
let dismissCompletion: (() -> Void)?

/// BottomSheetViewMode options:
/// normal: default
/// title: it can input title
/// customNav: it can put the custom View in the navigation
let bottomSheetViewMode: myBottomSheetViewMode
```
