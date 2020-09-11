### 1. 이게뭐고
ios 9.0부터 추가된 것  
좀더 간결하고 쉽게 스크롤뷰를 사용하게 해주기 위한 것.  

(내생각임)  
스크롤뷰는 크게 두가지 뷰로 생각할 수 있음  
스크롤하면서 봐야하는 커다란 뷰 하나와  
보여지는 작은 창문같은 뷰 하나  

### 2. ContentLayoutGuide
(내생각임)  
커다란 뷰에 해당함  

### 3. FrameLayoutGuide
(내생각임)
보여지는 작은 뷰에 해당함.. << 이거는 스크롤뷰 아닐까? 흠 모르겠따아ㅏ

### 4. 사용법
ScrollView 안에 contentView나 subView라는 이름으로 뷰 하나를 넣었겠쥐?
contents뷰 상하좌우는 ContentLayoutGuide에 붙힘
스크롤을 위아래로 할 경우, contents뷰.width = FrameLayoutGuide.width
스크롤을 좌우로 할 경우, contents뷰.height = FrameLayoutGuide.height
