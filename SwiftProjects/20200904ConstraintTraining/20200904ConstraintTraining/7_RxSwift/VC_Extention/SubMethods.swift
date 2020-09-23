
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift { // 자잘한 메소도들
    func makeViewArrays(){
        inSelfViewViews.append(scrollView)
        inSelfViewViews.append(completeButton)
        
        inScrollViewViews.append(subView)
        
        inSubViewViews.append(questionLabel)
        inSubViewViews.append(cameraButton1)
        inSubViewViews.append(questionTextView)
        inSubViewViews.append(questionCollectionView)
        inSubViewViews.append(answerLabel)
        inSubViewViews.append(plusButton)
        inSubViewViews.append(tableView)
        inSubViewViews.append(explanationLabel)
        inSubViewViews.append(cameraButton2)
        inSubViewViews.append(explanationTextView)
        inSubViewViews.append(explanationCollectionView)
    }
    
    func completeTap() {
        MainRepository.shared.question = questionTextView.text
        MainRepository.shared.explanation = explanationTextView.text
        MainRepository.shared.answerList = answerList
        MainRepository.shared.questionImageList = questionImageList
        MainRepository.shared.explanationImageList = explanationImageList
        navigationController?.popViewController(animated: true)
    }
}
