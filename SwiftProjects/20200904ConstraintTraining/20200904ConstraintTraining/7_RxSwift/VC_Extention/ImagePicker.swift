
import UIKit
import RxSwift
import RxCocoa

extension MultipleChoiceQuestionViewController_RxSwift: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func addImageTap(_ sender: UIButton) {
        imageButtonTag = sender.tag
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            //imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :Any]){
        dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage{
            if imageButtonTag == 1 {
                questionImageList.append(img)
                collectionReload(tag: 1)
            } else {
                explanationImageList.append(img)
                collectionReload(tag: 2)
            }
        }
    }
}
