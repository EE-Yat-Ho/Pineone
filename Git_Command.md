git init  
현재 위치로 로컬 저장소 생성  

git clone 깃허브링크  
원격 저장소를 통째로 로컬로 내려받음.  
init까지 해줌.  
일반적으로 새로운 개발자가 처음 통째로 내려받을 때 사용함.  

git pull origin master  
원격 저장소에서 로컬로 내려받으면서 병합함.  
사전에 init과 origin 설정까지 해야함. ( origin은 원격 저장소의 주소를 뜻함 )  
일반적으로 원격에 새로운 내용이 없나 확인하면서 사용함.  
작업시작! pull -> ----작업---- -> commit -> pull -> push 끝이 가장 바람직함.  

* A와 B가 같은 파일의 같은 부분을 다르게 수정하고, A가 pull -(1초후)-> B가 pull 하는 경우  
충돌이 발생하며, 나중에 pull한 B에게 충돌을 해결할 의무가 부여됨.  
소스의 해당 부분에는 HEAD, ===== 등으로 다르게 수정한 두 소스를 보여줘서  
정확한 소스로 선택 및 수정할 수 있게 해줌.  
이후 다시 commit 하면 됨.  

git branch A
A라는 이름의 브랜치 생성

git branch -r
원격 브랜치 목록 보기

git branch -a
로컬 브랜치 목록 보기

git branch -m A B
A브랜치 이름을 B로 바꾸기 ( modify )  

git branch -d A 
A브랜치 삭제하기 ( delete )

git checkout A
로컬에서 A브랜치 선택하기

git checkout -t origin/A
원격저장소에서 A브랜치를 로컬에 받아옴
pull로 받아올 경우 master만 받아오고 원하는 브랜치가 안옴
만약 -t 옵션 없이 그냥 받아올 경우, 변경사항들을 commit, push 할 수 없음..!

git push origin --delete A
원격에서 A브랜치를 삭제함
로컬에서 A브랜치를 삭제하고 A브랜치를 push 해도 원격에서 삭제됨
( git branch -d A -> git push origin A )

git add a
수정한 파일 a 선택
git add * 하면 새 파일, 수정 다 선택됨

git commit -m "abc"
add로 선택된 파일들에 "abc"라는 설명을 적으면서 커밋

git push origin A
add하고 commit한 소스들 원격의 A브랜치에 보내기

git fetch origin A
원격의 A브랜치를 FETCH_HEAD라는 특수한 브랜치에 받아옴.
바로 pull해서 merge까지 해버리지말고 신중하게 할 때 사용함.
git diff FETCH_HEAD B 로 B브랜치와 차이점을 확인하거나,
git log --decorate --all --oneline 으로 commit 히스토리를 확인할 수 있다.
이후 안전하게 merge하거나 아에 pull(fetch + merge)해서 작업을 이어나간다.

git pull
문맥상 pull도 있어야하지만 clone과의 차이 때문에 위에 설명해놓음.

git reset -- hard HEAD^
commit한 이전 코드 취소하기

git reset -- soft HEAD^
코드는 나두고 commit만 취소하기

git reset -- merge
merge 취소하기

git hard HEAD && git pull
git 코드 강제로 모두 받아오기

git config --global user.name "NAME"
git 계정의 이름을 NAME으로 변경

git config --global user.email "abc@naver.com"
git 계정의 메일을 abc@naver.com으로 변경

git stash / git stash save "description"
작업코드 임시저장하고 브랜치 바꾸기
아니 git stash 쳤다가 쓰고 저장안한거 다 사라짐 ㅠㅠㅠ

git stash pop
마지막으로 임시저장한 작업코드 가져오기

git branch --set-upstream-to = origin/브랜치이름
git pull no tracking info 에러 해결

git merge A
A브랜치를 현재 Checkout된 브랜치에 Merge하며,
Merge된 결과를 Checkout한 상태가 된다.
project브랜치를 master에 병합하려면 master브랜치를 checkout하고,
git merge project하고, 푸시하면 된다

git 특정 파일만 merge하기
master로 checkout 한 뒤,  
git checkout -p project Diary 하면 다이어리만 머지할 수 있음  
이후 커밋 푸쉬까지 해줘야함  
