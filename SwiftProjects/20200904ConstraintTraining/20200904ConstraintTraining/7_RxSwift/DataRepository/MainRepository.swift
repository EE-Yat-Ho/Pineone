
import UIKit

struct MainRepository {
    static var shared = MainRepository()
    
    // for RxSwift Complete Button
    var question: String!
    var explanation: String!
    var answerList = ["1", "2", "3"]//[String]()
    var questionImageList = [UIImage]()
    var explanationImageList = [UIImage]()
}

struct AssetType{
    var text: String
    var index: Int
}
