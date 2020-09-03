
###  모든 이니셜라이저는 People class 라고 가정
### Default initializer : property들을 임의의 값으로 세팅
inti () {  
    name = "박영호"  
    age = 25  
}  


### Custom(= designated) initializer : porperty들을 전달받은 인자 값으로 세팅 
init ( name : String, age : Int ) {  
    self.name = name  
    self.age = age  
}  


### Failable ininitailzer : 인자값들이 특정 조건에 맞는 경우 객체 생성을 안함.
init?( name: String, age: Int ) { // inti옆에 ? 들어간 구조  
    self.name = name  
    self.age = age  
    if name == "" {  
        return nil // 이 클래스 객체 생성 안함  
    }  
}  


### Convenience initializer : 모든 인자값을 입력할 필요 없음.
convenience init(age: Int) {  
    self.init(name: "NONAME", age: age)  
}  
여기서 let me = People(25) 를 하게 되면 NONAME, 25살로 세팅되게 됩니다.  
예를들어, NONAME값을 가진 인스턴스 객체가 많이 필요한 경우, 매번 NONAME을 주기는 번거롭습니다.  
이때 convenience init을 쓸 수 있습니다.  
Convenience = Default + Custom  


###  Required initializer : 자신을 상속하는 모든 자식 클래스들이 무조건 따라야함.
class People {  
    var name: String  
    var age: Int  
    required init(name: String, age: Int) {  
        self.name = name  
        self.age = age  
    }  
}  

class Adult: People {  
    required init(name: String, age: Int) {  
        super.init(name: name, age: age)  
    }  
}  
required initialzer는 UIView의 class를 만들 때 자주 등장합니다. 오 맞음  
