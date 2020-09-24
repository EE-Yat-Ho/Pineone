# distinctUntilChanged()

~~~
cell.answerTextField.rx.text
    .distinctUntilChanged()
    .bind { [weak self] newValue in
    self?.textFieldDidChangeSelection(cell.answerTextField)
}.disposed(by:cell.disposebag)
~~~
이런식  
텍스트의 내용이 변화할 때만, 바인드한 클로저 실행  
와 근데 브레이크 포인터에도 안잡히네 개 신기  

