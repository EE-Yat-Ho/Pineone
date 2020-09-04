//
//  MutipleChoiceQuestionViewController.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/04.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit

class MultipleChoiceQuestionViewController_StoryBoard: UIViewController {

    @IBOutlet weak var QuestionCollectionView: UICollectionView!
    @IBOutlet weak var AnswerTableView: UITableView!
    @IBOutlet weak var ExplanationCollectionView: UICollectionView!
    @IBOutlet weak var QuestionTextView: UITextView!
    @IBOutlet weak var ExplanationTextView: UITextView!
    @IBOutlet weak var CompleteButton: UIButton!
    
    func setBorder(instans: AnyObject, color: UIColor?){
        if color == nil {
            instans.layer.borderColor = UIColor(displayP3Red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        } else {
            instans.layer.borderColor = color?.cgColor
        }
        instans.layer.borderWidth = 1.0
        instans.layer.cornerRadius = 5.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorder(instans: QuestionCollectionView, color: nil)
        setBorder(instans: AnswerTableView, color: nil)
        setBorder(instans: ExplanationCollectionView, color: nil)
        setBorder(instans: QuestionTextView, color: nil)
        setBorder(instans: ExplanationTextView, color: nil)
        setBorder(instans: CompleteButton, color: UIColor.systemBlue)
        
        QuestionCollectionView.delegate = self
        AnswerTableView.delegate = self
        ExplanationCollectionView.delegate = self
        
        QuestionCollectionView.dataSource = self
        AnswerTableView.dataSource = self
        ExplanationCollectionView.dataSource = self
        
        let QuestionCollectionViewLayout = UICollectionViewFlowLayout()
        QuestionCollectionViewLayout.itemSize = CGSize(width: 110, height: 110)
        QuestionCollectionViewLayout.minimumLineSpacing = 0
        QuestionCollectionView.collectionViewLayout = QuestionCollectionViewLayout
        
        let ExplanationCollectionViewLayout = UICollectionViewFlowLayout()
        ExplanationCollectionViewLayout.itemSize = CGSize(width: 110, height: 110)
        ExplanationCollectionViewLayout.minimumLineSpacing = 0
        ExplanationCollectionView.collectionViewLayout = ExplanationCollectionViewLayout
    }
}

extension MultipleChoiceQuestionViewController_StoryBoard: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.ImageView.image = UIImage(systemName: "1.circle")
        return cell
        //return collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
    }
}

extension MultipleChoiceQuestionViewController_StoryBoard: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.ExampleNumber.image = UIImage(systemName: String(indexPath.row + 1) + ".circle")
        cell.AnswerInputTextField.text = String(indexPath.row + 1)
        if indexPath.row == 1 {
            setBorder(instans: cell.CorrectOrIncorrect, color: UIColor.systemGreen)
        } else {
            setBorder(instans: cell.CorrectOrIncorrect, color: UIColor.systemRed)
            cell.CorrectOrIncorrect.text = "오답"
            cell.CorrectOrIncorrect.textColor = UIColor.systemRed
        }
        return cell
    }
}
