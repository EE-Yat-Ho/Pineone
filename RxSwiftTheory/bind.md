# bind

## bind (to:) { }
~~~
public func bind<R1, R2>(to binder: (Self) -> (R1) -> R2, curriedArgument: R1) -> R2
~~~
~~~
answerRelay.bind(to: tableView.rx.items(cellIdentifier: "TableCell", cellType: TableCell.self)) { [weak self]
    index, data, cell in
    cell.exampleNumber.image = UIImage(systemName: String(index + 1) + ".circle")
    cell.answerTextField.text = data//self!.answerList[index]
    cell.xButton.tag = index
    cell.answerTextField.tag = index
    // self 없이
    if cell.isBinded == false {
        self?.bindXButton(cell.xButton) // 버튼, TextField 동적 바인딩
        self?.bindTextField(cell.answerTextField)
        cell.isBinded = true
    }
}.disposed(by: disposeBag)
~~~
제네릭 알지? ㅇㅇ
흠
Self = tableView.rx.items(cellIdentifier: "TableCell", cellType: TableCell.self)
R1 = 후행클로저

;; 잘 모르겠는데..
일단 셀 하나마다 실행되는 클로저라는것만 알지 으으..
일단 미완


## bind (onNext: { } ) == bind { }
~~~
public func bind(onNext: @escaping (Self.Element) -> Void) -> RxSwift.Disposable
~~~

