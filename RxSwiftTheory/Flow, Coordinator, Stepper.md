# Flow, Coordinator, Stepper
ha..
사th사th히 파헤쳐주지..

앱델리게이트에서 앱코디네이터가 시작됨 ㅇㅇ

AppCoordinator는 shared로 생성되어있고..
AppCoordinator가 shared로 생성 -> shared.start -> AppCoordinator 안에 있는 IntiFlow.shared도 생성
이게 AppCoordinator안의 mainFlow ㅇㅇ
whenReady 실행.
-> mainFlow 를 클로저가 관찰하게함 
이 클로저는 mainFlow의 Root가 window.rootViewController가 되게하고, window.makeKeyAndVisible을 실행..)

AppCoordinator의 coordinator를 mainFlow와 AppStepper.shared로 coordinate함.
flow는 coordinate하고싶은 navigation이고, stepper는 Flow의 global navigation임.
