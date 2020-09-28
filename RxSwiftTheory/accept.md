# accept

구현부
~~~
public final class BehaviorRelay<Element>: ObservableType {
    private let _subject: BehaviorSubject<Element>

    /// Accepts `event` and emits it to subscribers
    public func accept(_ event: Element) {
        self._subject.onNext(event)
    }
    ...
~~~
그냥 onNext 해주는거네 emit하나 해주는거임
