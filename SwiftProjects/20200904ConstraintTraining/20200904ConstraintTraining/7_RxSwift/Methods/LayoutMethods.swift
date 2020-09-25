
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift { // 자잘한 메소도들
    func makeViewArrays(){
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
    }
    
    func addConstraint(){
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
            if questionImageList.count == 0 {
                $0.height.equalTo(10)
            } else {
                $0.height.equalTo(CGFloat((questionImageList.count + 2) / 3) * collectionItemSize)
            }
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
            if answerList.count == 0 {
                $0.height.equalTo(10)
            } else {
                $0.height.equalTo(43.5 * CGFloat(answerList.count))
            }
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
            if explanationImageList.count == 0 {
                $0.height.equalTo(10)
            } else {
                $0.height.equalTo(CGFloat((explanationImageList.count + 2) / 3) * collectionItemSize)
            }
        }
        completeButton.snp.makeConstraints{
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
            $0.height.equalTo(60) }
    }
}
