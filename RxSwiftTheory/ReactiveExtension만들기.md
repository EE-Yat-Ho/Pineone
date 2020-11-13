# ReactiveExtension만들기
https://github.com/fimuxd/RxSwift/blob/master/Lectures/17_Creating%20Custom%20Reactive%20Extensions/Ch.17%20Creating%20Custom%20Reactive%20Extensions.md
와우 거의 교과서..

~~~
class testabc: UIView {
    static let a = testabc()
}
extension Reactive where Base: testabc {
    func response(abc: Int) -> Observable<String> {
        return Observable.create { observer in
            observer.onNext(String(abc) + "abc")
            return Disposables.create()
        }
    }
}
~~~
해주고
~~~
testabc.a.rx.response(abc: 123).subscribe(onNext: { Toast.show($0) }).disposed(by: rx.disposeBag)
~~~
이거 하면 123abc 나옴 와우우우
