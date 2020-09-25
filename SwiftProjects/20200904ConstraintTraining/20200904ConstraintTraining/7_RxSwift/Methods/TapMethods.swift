
import UIKit
import RxSwift

extension MultipleChoiceQuestionViewController_RxSwift { // TableView
    func tapPlusButton() {
        answerList.append("")
        reloadTableView()
    }
    func tapXButton(_ sender: UIButton) {
        answerList.remove(at: sender.tag)
        reloadTableView()
    }
    func tapQuestionCameraButton() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            questionImagePicker.sourceType = .savedPhotosAlbum
            questionImagePicker.allowsEditing = false
            present(questionImagePicker, animated: true, completion: nil)
        }
    }
    func tapExplanationCameraButton() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            explanationImagePicker.sourceType = .savedPhotosAlbum
            explanationImagePicker.allowsEditing = false
            present(explanationImagePicker, animated: true, completion: nil)
        }
    }
    func tapCompleteButton() {
        MainRepository.shared.question = questionTextView.text
        MainRepository.shared.explanation = explanationTextView.text
        MainRepository.shared.answerList = answerList
        MainRepository.shared.questionImageList = questionImageList
        MainRepository.shared.explanationImageList = explanationImageList
        navigationController?.popViewController(animated: true)
    }
}
