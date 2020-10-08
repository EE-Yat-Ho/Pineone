
import UIKit
import RxSwift

extension MultipleChoiceQuestionViewController_RxSwift: vcDelegate {
    func setLayout(){
        inSelfViewViews.append(scrollView)
        inSelfViewViews.append(completeButton)
        
        inScrollViewViews.append(subView)
        
        inSubViewViews.append(questionLabel)
        inSubViewViews.append(questionCameraButton)
        inSubViewViews.append(questionTextView)
        inSubViewViews.append(questionCollectionView)
        inSubViewViews.append(answerLabel)
        inSubViewViews.append(plusButton)
        inSubViewViews.append(tableView)
        inSubViewViews.append(explanationLabel)
        inSubViewViews.append(explanationCameraButton)
        inSubViewViews.append(explanationTextView)
        inSubViewViews.append(explanationCollectionView)
        
        // 모든 뷰 .addSubView 진행
        self.view.addSubviews(inSelfViewViews)
        scrollView.addSubviews(inScrollViewViews)
        subView.addSubviews(inSubViewViews)

        // 특정 뷰 테두리 그리기
        questionTextView.setBorder()
        questionCollectionView.setBorder()
        tableView.setBorder()
        explanationTextView.setBorder()
        explanationCollectionView.setBorder()
        completeButton.setBorder(UIColor.systemBlue)
        // 제약사항 추가
        scrollView.snp.makeConstraints{ $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
        
        subView.snp.makeConstraints{
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width) }
        
        questionLabel.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 30).isActive = true
        questionLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 55).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        questionLabel.snp.makeConstraints{
            $0.leading.equalTo(subView.snp.leading).offset(30)
            $0.top.equalTo(subView.snp.top).offset(55)
            $0.height.equalTo(20) }
        
        questionCameraButton.snp.makeConstraints{
            $0.trailing.equalTo(subView.snp.trailing).offset(-30)
            $0.top.equalTo(subView.snp.top).offset(50)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
        questionTextView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(questionCameraButton.snp.bottom).offset(5)
            $0.height.equalTo(130) }
        
        questionCollectionView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(questionTextView.snp.bottom).offset(5)
            $0.height.equalTo(10)
        }
        
        answerLabel.snp.makeConstraints{
            $0.leading.equalTo(subView.snp.leading).offset(30)
            $0.top.equalTo(questionCollectionView.snp.bottom).offset(10)
            $0.height.equalTo(20) }
        
        plusButton.snp.makeConstraints{
            $0.trailing.equalTo(subView.snp.trailing).offset(-30)
            $0.top.equalTo(questionCollectionView.snp.bottom).offset(5)
            $0.height.equalTo(30)
            $0.width.equalTo(30) }
        
        tableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(plusButton.snp.bottom).offset(5)
            $0.height.equalTo(10)
        }
        explanationLabel.snp.makeConstraints{
            $0.leading.equalTo(subView.snp.leading).offset(30)
            $0.top.equalTo(tableView.snp.bottom).offset(10)
            $0.height.equalTo(20) }
        
        explanationCameraButton.snp.makeConstraints{
            $0.trailing.equalTo(subView.snp.trailing).offset(-30)
            $0.top.equalTo(tableView.snp.bottom).offset(5)
            $0.height.equalTo(30)
            $0.width.equalTo(30) }
        
        explanationTextView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(explanationCameraButton.snp.bottom).offset(5)
            $0.height.equalTo(130) }
        
        explanationCollectionView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(explanationTextView.snp.bottom).offset(5)
            $0.bottom.equalTo(subView.snp.bottom).offset(-100)
            $0.height.equalTo(10)

        }
        completeButton.snp.makeConstraints{
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
            $0.height.equalTo(60) }
    }
    func bindData() {
        bindQuestionCameraButton()
        bindQuestionImagePickerController()
        bindQuestionCollectionView()
        bindPlusButton()
        bindTableView()
        bindExplanationCameraButton()
        bindExplanationImagePickerController()
        bindExplanationCollectionView()
        bindCompleteButton()
    }
    func requestData() {
        answerList = MainRepository.shared.answerList
        answerRelay.accept(MainRepository.shared.answerList)
        questionImageRelay.accept(MainRepository.shared.questionImageList)
        explanationImageRelay.accept(MainRepository.shared.explanationImageList)
    }
    
    
    func tapPlusButton() { // 텍스트 필드 때문에 어쩔수없이 answerList 사용
//        var list = answerRelay.value
//        list.append("")
        answerList.append("")
        answerRelay.accept(answerList)
    }
    func tapXButton(_ cell: TableCell) {
//        var list = answerRelay.value
//        list.remove(at: button.tag)
        answerList.remove(at: tableView.indexPath(for: cell)!.row)
        answerRelay.accept(answerList)
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
        MainRepository.shared.answerList = answerRelay.value
        MainRepository.shared.questionImageList = questionImageRelay.value
        MainRepository.shared.explanationImageList = explanationImageRelay.value
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldDidChangeSelection(_ cell: TableCell) {
        if tableView.indexPath(for: cell)!.row < answerList.count { // 삭제한 경우 뻑나서 추가
            answerList[tableView.indexPath(for: cell)!.row] = cell.answerTextField.text!
        }
    }
    
    
}
