
import UIKit

struct MainRepository {
    static var shared = MainRepository()
    
    // for RxSwift Complete Button
    var dataForScene = DataForScene()
    
    static func mainList() -> [Screen]{
        [.storyBoard,
         .nSLayout,
         .visualFormat,
         .nSLayout_VisualFormat,
         .anchor,
         .snapKit,
         .rxSwift,
         .mVVM]
    }
}

