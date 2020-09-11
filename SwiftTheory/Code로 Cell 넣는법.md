## 1. 그냥 cell = UITableCell() 이따구로 하면 안됨..
cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 써줘야함 ㅇㅇ
근데, 저런 아이덴티티를 설정 해줘야겠지?

## 2. tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
tableView.register([원하는 셀 클래스].self, forCellReuseIdentifier: "[원하는 아이덴티티 문자열]") 넣고 하면 됨!!!
