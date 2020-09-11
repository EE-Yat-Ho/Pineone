## 1. UIView.translatesAutoresizingMaskIntoConstraints

AutoResizingMask를 켜고 끄는 bool타입 프로퍼티  
기본값은 true이며,  
켜둔채로 AutoLayout을 설정할 경우,  
두 레이아웃이 충돌하기 때문에 꺼줘야함.  
~~~
someView.translatesAutoresizingMaskIntoConstraints = false
~~~
  
Storyboard로 객체를 생성할 경우 알아서 false가 되고,  
SnapKit을 사용할 시에도 알아서 false로 바꿔줌.
