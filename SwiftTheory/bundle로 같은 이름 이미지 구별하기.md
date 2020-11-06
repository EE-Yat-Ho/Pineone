# bundle로 같은 이름 이미지 구별하기
AssetsFileChoice 프로젝트에 있음.

번들 만드는법:
폴더에 이미지 넣고
폴더 이름을 이름.bundle로 바꾼다
끝. 간단. 와우!

번들만든거 xcode에 드래그 앤 드롭해주고

이미지 불러올때
~~~
UIImage(named: "mybundlename.bundle/고양이.jpg")
~~~
라고 하면 됨.
그럼 다른 번들에 있는 고양이이미지랑 구별해서 들고오기 가능!
단, 확장자(jpg)를 다 붙혀줘야하고, x1 x2 x3 를 못해서 assets보다 구림..
