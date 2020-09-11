## 1. Class initializer delegation 의 3가지 룰
1. designated initializer은 superClass의 designated initializer를 반드시 호출해야 한다.
2. convenience initializer은 동일 클래스의 initializer를 호출해야 한다.
2. convenience initializer은 최종적으로는 designated initializer를 호출해야 한다.
즉, desi < conv1 < conv2 에서 conv2도 desi를 호출한거임!


### 내맘대로 적기
## 1. designated initailizer만 오버라이드 가능
init(), convenience init()은 오버라이드 못함
