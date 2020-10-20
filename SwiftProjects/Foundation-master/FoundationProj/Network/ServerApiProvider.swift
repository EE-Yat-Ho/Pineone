import Foundation
import Moya

enum ServerApiProvider {
    case user                                   //사용자 등록 및 세션키 발급
    case modifyUser(nickname: String)           //사용자 프로필 변경
    case tempSession                            //임시 세션키 전달
    case getSession                             //세션키 발급
    case getAppInfo                             //앱 구동시 필요 정보 조회
    case getMain                                //메인화면 조회
    case getCategories(cursor: String?,
                    count: Int)                 //키워드 카테고리 목록 조회
    case getContents(type: String,
                    extra: String?,
                    cursor: String?,
                    count: Int)                  //컨텐츠 조회 - 키워드카테고리/Hot/New
    case getContentsDetail(contents_key: String) //컨텐츠 상세조회
    case getUserContents(type: String,
                        cursor: String?,
                        count: Int)             //사용자 컨텐츠 조회 - 시청/좋아요
    case addUserContents(type: String,
                        contents_key: Int,
                        extra: String?)          //사용자 컨텐츠 등록 - 시청/좋아요/공유
    case deleteUserContents(type: String,
                            contents_key: String)  //사용자 컨텐츠 삭제 - 시청/좋아요
    case getReplies(type: String,
                    contents_key: Int?,
                    cursor: String?,
                    count: Int)                 //댓글 조회
    case addReplies(contents_key: Int,
                    reply_text: String)         //컨텐츠 댓글 등록
    case deleteReplies(reply_key: String)      //컨텐츠 댓글 삭제
    case reportReplies(reply_key: Int,
                       reply_type: String,
                       reply_desc: String?)      //컨텐츠 댓글 신고하기
    case stateLog(opcode: String,
                    req_dt: String,
                    extra: String?,
                    extra2: String?,
                    extra3: String?,
                    spend_time: String?)                               //통계 Raw 로그 수집
    case getTestContent(test_type: String,      //컨텐츠검수/편성검수 목록 조회
                        contents_type: String,
                        cursor: String?,
                        count: Int?)
    case getSerchWords(cursor: String?,         //인기검색어 목록 조회
                       count: Int)
    case getGenre(cursor: String?,
                  count: Int?)                  //장르 목록 조회
    case getGenreCategoiries(genre: String,
                             cursor: String?,
                             count: Int?)       //장르멸 카테고리 목록 조회
    /// 꾸미기 카테고리 목록 조회
    case getDecoCategories(deco_type: String,   // deco_type 1= 꾸미기, 2= 필터
                           cursor: String?,
                           count: Int?)         // default = 10
    /// 카테고리별 꾸미기 목록 조회
    case getDecoCategoryItem(deco_type: String,   // 꾸미기 유형 deco_type 1= 꾸미기, 2= 필터
                             extra_type: String,  // 요청 타입 (1:카테고리,2:Hot, 3:New)
                             extra: String?,      // 요청타입이 1(카테고리)인 경우 꾸미기 카테고리 ID
                             cursor: String?,
                             count: Int?)         // default = 10
    /// 꾸미기 사용 기록 등록
    case setDecoUsed(type: String,          // 꾸미기 사용 기록 유형 ( 1:조회, 2:좋아요)
                     deco_id: String)       // 꾸미기 id
    /// 추천 콘텐츠 목록 조회
    case getRecommend(type: String,   // 꾸미기 유형 deco_type 1= 꾸미기, 2= 필터
                     extra: String?,      // 요청타입이 1(카테고리)인 경우 꾸미기 카테고리 ID
                     count: Int?)         // default = 10
    /// 멀티 배치 컨텐츠 조회
    case getMultiContents(contents_key: Int)   // 멀티 배치 request의 콘텐츠 유니크 키
}



extension ServerApiProvider {
    var errors: Set<ServerApiProvider.ResultCode>? {
        switch self {
        case .getSession : return [.ar_40100001, .ar_40100003, .ar_40100006]
        case .addReplies: return [.ar_40000004]
        case .addUserContents: return [.ar_40100003]
        case .getRecommend: return [.ar_50030001, .ar_40100003]
        case .modifyUser: return [.ar_40000005]
        case .stateLog: return [.ar_40000001]
        case .getContentsDetail: return [.ar_40000007, .ar_40100003]
        default:return nil
        }
    }
}

extension ServerApiProvider {
    enum Error: Swift.Error {
        case serverMaintenance(message: String)
        // 비정상 응답 (오류코드)
        case failureResponse(api: ServerApiProvider, code: ServerApiProvider.ResultCode, desc: String)
        // 잘못된 응답 데이터 (발생시 서버 문의)
        case invalidResponseData(api: ServerApiProvider)
    }

    enum ResultCode: String {
        case ar_00000000 = "00000000" // 정의되지 않은 오류

        case ar_20000000 = "20000000" // 요청 성공
        case ar_20000001 = "20000001" // 이미 등록됨
        case ar_20000002 = "20000002" // 이미 삭제됨

        case ar_40000000 = "40000000" // 유효하지 않은 Header
        case ar_40000001 = "40000001" // 유효하지 않은 Parameter
        case ar_40000002 = "40000002" // Bad request, 클라이언트의 잘못된 요청으로 처리할 수 없음
        case ar_40000004 = "40000004" // 비속어 포함
        case ar_40000003 = "40000003" // 암복호화 처리 과정 오류
        case ar_40000005 = "40000005" // 닉네임 중복
        case ar_40000006 = "40000006" // 세션토큰 만료
        case ar_40000007 = "40000007" // 잘못된 컨텐츠

        case ar_40100000 = "40100000" // Session Key가 유효하지 않음
        case ar_40100001 = "40100001" // 사용자 인증 실패 (미가입자) -> sim이 U+ 인데 가입이 안됨
        case ar_40100002 = "40100002" // 사용자 인증 실패 (인증정보 불일치)
        case ar_40100003 = "40100003" // Resource에 대한 권한 없음 -> sim이 U+꺼가 아닌 타사꺼임
        case ar_40100006 = "40100006" // 협약되지 않은 MVNO 가입자 (이후 API 요청시 CARRIER-TYPE : E 로 요청) -> 알뜰폰임

        case ar_40400000 = "40400000" // Not found, 문서를찾을수없음, 서버에요청을수행할수있는기능 없음(Url).

        case ar_50000000 = "50000000" // Internal server error, 내부서버 오류(잘못된 스크립트 실행 시)
        case ar_50010001 = "50010001" // DB 관련 실패 – insert 에러
        case ar_50010002 = "50010002" // DB 관련 에러 – select 에러
        case ar_50010003 = "50010003" // DB 관련 에러 – update 에러
        case ar_50010004 = "50010004" // DB 관련 에러 – delete 에러
        case ar_50030001 = "50030001" // 추천 플랫폼 연결 실패
    }
}
