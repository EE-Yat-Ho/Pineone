//
//  Resource.swift
//  XmlPasing
//
//  Created by 박영호 on 2020/11/04.
//

import UIKit
 
/// NSParserDelegate는 NSObjectProtocol를 채택해야하고, 채택하기 위해 NSObject를 상속받음
class Resource: NSObject {
    static let shared = Resource()
    
    // MARK:- Properties
    var keyToTextDictionary = Dictionary<Keys, String>()
    var dictionaryKey: Keys = .trash
    
    // MARK:- Methods
    /// Key값과 인자들로 완성된 string값 넘겨줌
    func getTextFromKey(key: Keys, arguments: CVarArg...) -> String {
        guard var result = keyToTextDictionary[key] else {
            return ""
        }
        result = String(format: result, arguments: arguments)
        return result
    }
    
    func setResourceDictionary(){
        var xmlFileName = ""
        let nowLanguege = Languege(rawValue: UserDefaults.standard.integer(forKey: "Languege"))
        switch nowLanguege {
        case .korea:
            xmlFileName = "strings_kr"
        case .thailand:
            xmlFileName = "strings_th"
        case .none:
            return
        }
        /// xml 파싱 => 리소스의 딕셔너리 완성
        if let path = Bundle.main.url(forResource: xmlFileName, withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
}

extension Resource: XMLParserDelegate {
    /// <**> 처럼 태그가 열렸을 때 실행되는 함수
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        /// dialog_play_next_setting_change, see_underline 에 <u>가 <string>에 들어가있음...;; 예외처리
        if elementName == "u" { return }
        
        /// 딕셔너리 키가 쓰레기인 경우는 trash로 설정하고, 추후 작업때 무시할 것임.
        dictionaryKey = Keys(rawValue: attributeDict["name"] ?? "trash") ?? .trash
        
        /// 런타임에 언어 변경될 경우, 기존에 있던 텍스트에서 뒤에 붙혀버림.. 그렇다고 안붙히게 만들자니 텍스트를 끊어읽을때도 있어서 안됨
        /// 그래서 그냥 초기화해줘야함
        keyToTextDictionary[dictionaryKey] = ""
    }
    
    /// 태그가 열린 후 발견되는 문자열들에 대해 실행되는 함수
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        /// 딕셔너리 키가 쓰레기인 경우는 무시
        if dictionaryKey == .trash { return }
        
        /// 딕셔너리에 값이 있을경우 붙혀줌 ( 끊어읽을때도 있어서 ), 없을 경우 그 값으로 세팅
        if let targetValue = Resource.shared.keyToTextDictionary[dictionaryKey] { /// 이미 있는 경우 : 이어붙히기
            Resource.shared.keyToTextDictionary[dictionaryKey] = targetValue + string
        } else { /// 처음 넣는 경우 : 그냥 넣기
            Resource.shared.keyToTextDictionary[dictionaryKey] = string
        }
    }
    
    /// </**> 처럼 태그가 닫혔을 때 실행되는 함수
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        /// 완성된 string에 후처리 작업들을 하기위해 생성
        guard var string = Resource.shared.keyToTextDictionary[dictionaryKey] else { return }
        
        /// XMLParser에서 특수문자 앞에 \를 하나 추가하기때문에 제거해주기 ( 역슬래시 2개를 1개로 바꾸는 시도를 했지만.. 실패.. )
        string = string.replacingOccurrences(of: "\\n", with: "\n")
        string = string.replacingOccurrences(of: "\\'", with: "\'")
        
        /// C스트링 처리포맷을 Swift스트링 포맷으로 바꾸는 작업 ( C스트링 포맷은 한글이 자꾸 깨짐.. )
        string = string.replacingOccurrences(of: "%s", with: "%@")
        string = string.replacingOccurrences(of: "%1$s", with: "%1$@")
        
        /// CDATA 내부 태그 처리
        string = string.replacingOccurrences(of: "<br>", with: "\n")
        string = string.replacingOccurrences(of: "<font color=#e83c5a>", with: "")
        string = string.replacingOccurrences(of: "</font>", with: "")
        
        /// 태그가 닫힌 후, 완성된 문자열의 시작과 끝부분의 공백, 탭, 줄바꿈 없애기
        string = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        /// 후처리 끝난 string 다시 넣어주기
        Resource.shared.keyToTextDictionary[dictionaryKey] = string
        
        /// 태그가 닫힌 후, 읽히는 \n\t 등의 문자열은 무시하기 위한 처리
        dictionaryKey = .trash
    }
}

// MARK:- Enums
enum Languege: Int{
    case korea
    case thailand
}

enum Keys: String {
    /// <string>태그가 아니거나 \n\t같은 쓰레기 값들을 무시하기 위한 용도
    case trash
    
    /// U+AR 텍스트들
    case app_name
    /// 홈
    case bottom_nav_title_home
    /// 검색
    case bottom_nav_title_search
    /// 내활동
    case bottom_nav_title_my
    /// 더보기
    case bottom_nav_title_setting
    /// 재생시간
    case play_time
    /// 데이터용량
    case max_size
    /// 출연
    case artist
    /// 콘텐츠 제공기간
    case expire_date
    /// - 콘텐츠를 다운로드 하시면, 슬로우모션 및 구간반복 기능을 이용하실 수 있습니다.\n- 콘텐츠 제공기간은 콘텐츠 제작사 및 기획사의 요청에 따라 변경될 수 있습니다.
    case content_basic_info
    /// 네트워크 접속이 원활하지\n않습니다.\n다운로드 하시겠습니까?
    case buffering_info
    /// 네트워크 연결 상태가 좋지 않습니다.\nU+5G에 가입하면 콘텐츠를\n다운로드하여 끊김없이 시청할 수\n있습니다.
    case buffering_info_other
    /// 계속 시청
    case buffering_button1
    /// 다운로드 후 시청
    case buffering_button2
    /// 재생 종료
    case buffering_button3
    /// 댓글을 남겨주세요.
    case reply_hint
    /// 댓글
    case reply
    /// 등록
    case register
    /// LG U+ 고객님만 댓글을 남길 수 있습니다.
    case reply_not_permit
    /// 신고내용은 200글자 까지만 남길 수 있습니다.
    case report_limit
    /// 다운로드
    case download
    /// 다운로드중
    case downloading
    /// 아니요
    case no
    /// 네
    case yes
    /// 취소
    case cancel
    /// 저장
    case save
    /// 일시정지
    case pause
    /// 다시시작
    case restart
    /// 다시시도
    case retry
    /// 재생하기
    case play
    /// 바로재생
    case play_now
    /// 더보기
    case see_more
    /// 접기
    case see_more_close
    /// 네트워크 확인
    case check_network
    /// 보관함으로 이동
    case go_to_mydownload
    /// 나가기
    case leave
    /// 다운로드 일시 정지됨
    case download_paused
    /// 상세보기
    case view_detail
    /// 접근 권한 동의
    case permission_title
    /// U+ AR 필수 접근 권한 안내
    case permission_app_name
    /// 서비스를 이용하시려면 아래 권한에 반드시 동의해 주셔야 합니다.
    case permission_app_desc
    /// 전화
    case permission_phone
    /// 휴대폰 번호를 자동 확인하여 아이디 입력 없이 바로 로그인 할 수 있습니다. 앱 이용 중 전화가 오면 통화할 수 있습니다.
    case permission_phone_desc
    /// 저장 공간
    case permission_storage
    /// 콘텐츠를 다운로드하거나 촬영한 영상을 저장할 수 있습니다.
    case permission_storage_desc
    /// 카메라
    case permission_camera
    /// 콘텐츠를 활용하여 영상을 촬영할 수 있습니다.
    case permission_camera_desc
    /// 오디오 녹음
    case permission_mic
    /// 영상 촬영 중 음향을 녹음하고 저장하실 수 있습니다.
    case permission_mic_desc
    /// 위치 정보
    case permission_location
    /// 사용자의 네트워크 상태를 확인할 수 있습니다.
    case permission_location_desc
    /// 오늘 하루 보지 않기
    case popup_turn_off_today
    /// 다시 보지 않기
    case popup_turn_off
    /// 약관 동의
    case agreement_title
    /// U+AR 서비스를 이용하시려면 아래 이용 약관 및 정보 수집에 동의해 주세요.
    case agreement_desc
    /// 이용약관동의(필수)
    case agreement_usage
    /// 개인정보수집 및 이용동의 (필수)
    case agreement_private_info
    /// 개인정보처리 위탁 동의 (필수)
    case agreement_info_process
    /// 마케팅 수신동의 (선택)
    case agreement_marketing
    /// ※ 필수 약관에 모두 동의하셔야 서비스를 이용하실 수 있습니다.
    case agreement_extra_desc
    /// 필수 약관에 모두 동의하셔야 다음 단계로 진행 할 수 있습니다.
    case agreement_warn
    /// 모두 확인, 동의합니다.
    case agreement_all
    /// 이벤트 정보 및 광고를 받아 볼 수 있습니다.
    case agreement_marketing_info
    /// 약관에 동의하셔야 서비스를 이용할 수 있습니다
    case agree_cancel_notice
    /// 보기
    case see_underline
    /// 다음
    case next
    /// 닫기
    case close
    /// 확인
    case ok
    /// 종료
    case exit
    /// 계속
    case keep
    /// 이전버전 보기
    case prev_version
    /// 다음버전 보기
    case next_version
    /// 동의하기
    case agreement_and_go
    /// 이전 버튼을 한 번 더 누르시면 앱이 종료됩니다.
    case close_app_confirm
    /// 테마 전체보기
    case theme_view_all
    /// 찜
    case like
    /// 공유
    case share
    /// 사진 (JPG)
    case share_jpg
    /// GIF
    case share_gif
    /// 동영상 (MP4)
    case share_mp4
    /// 최근 본
    case my_recently_viewed
    /// 다운로드
    case my_download
    /// 좋아요
    case my_like
    /// 내가 쓴 댓글
    case my_replies
    /// 동영상/GIF/사진
    case my_contents
    /// 내앨범
    case my_album
    /// 삭제
    case delete
    /// 폰트 변경이 감지되었습니다. 플레이어를 종료합니다.
    case font_error
    /// 공유하기
    case share_content
    /// 선택 항목 삭제
    case my_contents_selection_delete
    /// 한 번 삭제한 콘텐츠는\n복구할 수 없습니다.\n정말 삭제하시겠어요?
    case my_contents_selection_delete_confirm
    /// 동영상/GIF/사진
    case my_contents_camera
    /// 3D 스캔 콘텐츠
    case my_contents_3d
    /// 내가 만든 콘텐츠
    case my_contents_
    /// 스캔한 콘텐츠가 없습니다.\n나만의 3D 콘텐츠를 만들어보세요.
    case qlone_no_contents
    /// 3D 스캔을 위해 <font color=#e83c5a>전용매트</font>가 필요합니다.<br>전용매트를 준비해 주세요.
    case qlone_tutorial_need_mat
    /// 전용매트 다운받기
    case qlone_tutorial_download_btn
    /// 가로화면에서 버튼을 눌러\n스캔을 진행해주세요.
    case qlone_tutorial_do_landscape
    /// 360도 스캔
    case qlone_tutorial_360_scan
    /// 스캔 대상을 올린 뒤 360도\n천천히 돌아가며 스캔을 해주세요.
    case qlone_tutorial_360_scan_msg
    /// 스캔을 계속 진행해주세요.
    case qlone_tutorial_keep_scan
    /// 스캔 대상을 다른 포즈로 올려주세요.
    case qlone_tutorial_other_scan
    /// 보정을 원하는 부분을 길게 누르면\n보정할 수 있어요.
    case qlone_tutorial_after_scan
    /// 다른 포즈를 추가로 스캔하면\n더욱 완벽한 콘텐츠를 만들 수 있어요.
    case qlone_tutorial_after_scan_2
    /// 콘텐츠 이름을 입력해주세요.
    case qlone_make_name_desc
    /// 3D 스캔 테스트
    case qlone_make_name_hint
    /// 지금 종료하시면\n스캔한 데이터는 저장되지 않습니다.\n종료하시겠습니까?
    case qlone_exit_scanning_desc
    /// 콘텐츠가 저장되지 않았습니다.\n정말 종료하시겠습니까?
    case qlone_exit_not_saved_desc
    /// 공유 형식을 선택해주세요.
    case qlone_select_share_type_title
    /// 3D 콘텐츠를\n제작하고 있습니다.
    case qlone_randering
    /// 이벤트
    case setting_event
    /// 공지사항
    case setting_notice
    /// FAQ
    case setting_faq
    /// 1:1문의
    case setting_question
    /// 기타설정
    case setting_other
    /// 전체선택
    case select_all
    /// 닉네임 변경
    case setting_nickname
    /// 이벤트/할인 혜택 알림
    case setting_push
    /// 다양한 이벤트 및 혜택 정보 수신을 동의/거부할 수 있습니다.
    case setting_push_desc
    /// 연속 재생 설정
    case setting_continuous_play
    /// 스티커를 제외한 다음 목록의 영상이 자동으로 재생됩니다.
    case setting_continuous_play_desc
    /// 앱 배경색 화이트
    case setting_bright_theme
    /// 콘텐츠 저장 위치 설정
    case setting_contents_save
    /// 버전정보(최신버전 %s)
    case setting_app_version
    /// 현재 버전 %s
    case setting_current_version
    /// 오픈소스 라이선스
    case setting_opensource_licence
    /// 이용약관동의
    case setting_terms_of_service
    /// 개인정보 처리 위탁 동의
    case setting_private_policy
    /// 개인정보수집 및 이용동의
    case setting_private_policy_collection
    /// 개인정보처리방침
    case setting_private_policy_terms
    /// 최신 버전으로 업그레이드\n할 수 있습니다.\n\n현재 버전 : %s\n최신 버전 : %s
    case setting_update_agreement
    /// 현재 닉네임
    case setting_nick_current_nick
    /// 변경할 닉네임을 입력하세요.(최대15자)
    case setting_nick_change_nick_hint
    /// 닉네임이 변경되었습니다.
    case setting_nick_change_nick_success
    /// 중복된 닉네임입니다.
    case setting_nick_change_nick_duplicate
    /// 업데이트하기
    case setting_version_update
    /// \'내가 만든 콘텐츠\'의\n저장위치를 선택해 주세요.
    case setting_select_storage
    /// 최신 버전입니다.\n\n버전 : %s
    case setting_update_disagree_last_version
    /// U+AR을 이용하면서 궁금했던 점이나 하고 싶은 말을 자유롭게 남겨주세요.\n담당자가 확인 후 메일로 답변 드리겠습니다.
    case setting_question_title2
    /// 문의하신 내용에 답변 드리기 위해 고객님의 이메일 주소를 수집합니다. 답변이 완료되면 수집한 개인정보는, 관련 법령 또는 회사 내부 방침에 따라 보존해야 하는 경우를 제외하고 모두 폐기합니다. 자세한 내용은 LG U+ 홈페이지 U+AR 개인정보처리방침을 참고하세요.
    case setting_question_title3
    /// 답변 받을 이메일 주소를 남겨주세요.
    case setting_question_hint_email
    /// 문의 사항을 남겨주세요.
    case setting_question_hint
    /// 위 내용에 동의합니다.
    case setting_question_agreement
    /// 등록하기
    case setting_question_send
    /// 문의하시겠습니까?
    case setting_question_dialog
    /// 등록되었습니다. 담당자 확인 후 빠른 회신 드리겠습니다.
    case setting_question_toast
    /// 등록에 실패하였습니다.
    case setting_question_failure
    /// 서비스 문의
    case setting_question_title
    /// 1:1 문의 유형을 선택하세요.
    case setting_question_type_select2
    /// 문의 유형을 선택하세요.
    case setting_question_type_select
    /// 앱 이용방법 문의
    case setting_question_type_app_usage
    /// 요금/데이터 문의
    case setting_question_type_price_data
    /// 콘텐츠 종류/품질 문의
    case setting_question_type_contents_quality
    /// 이벤트 문의
    case setting_question_type_event
    /// 기타 문의
    case setting_question_type_others
    /// 그 외 건의사항 또는 개선 요청
    case setting_question_type_feedback
    /// 참여하기
    case setting_event_apply
    /// 내부저장
    case setting_internal_storage
    /// SD카드
    case setting_sd_card
    /// (남은 공간 %s)
    case setting_available_space
    /// 콘텐츠 저장 위치가 변경되었습니다.
    case setting_change_space
    /// 내용
    case contents
    /// 작성자
    case writer
    /// 신고하기
    case report
    /// 사유선택
    case report_select_reason
    /// 부적절한 홍보 게시글
    case report_reason_1
    /// 음란성 또는 청소년에게 부적합한 내용
    case report_reason_2
    /// 명예훼손/사생활 침해 및 저작권 침해 등
    case report_reason_3
    /// 신고했습니다.
    case report_complete
    /// 기타
    case etc
    /// 상세 내용 작성해주세요.
    case report_hint_detail
    /// 댓글
    case player_reply
    /// 댓글을 남겨주세요.
    case player_reply_please_enter
    /// *LG U+ 사용자만 댓글 작성이 가능합니다.
    case player_no_reply
    /// 콘텐츠가 고정 될 바닥면을\n찾기 위해 휴대폰을 좌우로\n천천히 움직여 주세요.
    case player_searching_surface_toast
    /// 이 휴대폰으로는 AR콘텐츠를 재생할 수 없습니\n다. U+홈페이지 또는 FAQ에서 이용 가능한 휴대\n폰을 확인해 주세요.
    case player_unsupported_device
    /// 저장되었습니다.
    case player_save_preview
    /// 재생이 완료되어 동영상 촬영이 중단되었습니다.
    case player_video_recording_end
    /// 모든 콘텐츠를 시청하였습니다.
    case player_play_done
    /// 오늘
    case today
    /// 어제
    case yesterday
    /// 2일전
    case two_days_ago
    /// 3일전
    case three_days_ago
    /// 4일전
    case four_days_ago
    /// 5일전
    case five_days_ago
    /// 6일전
    case six_days_ago
    /// 7일전
    case seven_days_ago
    /// 다운로드순
    case order_date
    /// 용량순
    case order_size
    /// \n서비스 이용에 꼭 필요한 업데이트가 있습니다.앱을 계속 이용하시려면 지금 업데이트 하세요.\n
    case update_popup_major
    /// \n최신 버전으로 업데이트 할 수 있습니다.\n
    case update_popup_miner
    /// 나중에
    case later
    /// 업데이트
    case update
    /// 저장공간이 부족해 저장하지 못했습니다.\n기존에 저장한 콘텐츠를 삭제하거나\n저장 위치를 재설정해 주세요.\n( 최소 여유공간 100MB 필요 )
    case save_file_out_of_storage
    /// 설정으로 이동
    case move_to_setting
    /// 저장하지 않고 플레이어로 돌아갑니다.
    case preview_exit_without_save
    /// 페이지를 열 수 없습니다.
    case could_not_open_page
    /// 오류발생 안내
    case error_occurred
    /// 네트워크 연결상태를 확인하거나 잠시 후 다시 실행해주세요.
    case network_error
    /// 네트워크 접속이 원활하지 않습니다. 잠시 후 다시 시도해주세요.
    case network_error_too_many
    /// 네트워크 접속이 원활하지 않습니다. 5G 또는 기가와이파이 연결상태를 확인해주세요
    case network_error_wifi
    /// 네트워크 접속이 원활하지 않습니다. 잠시 후 다시 시도해주세요
    case network_error_cell
    /// 네트워크 연결이 끊어졌습니다. 잠시 후 다시 실행해주세요
    case server_error
    /// 최근 본 콘텐츠가 여기에 표시됩니다.
    case my_recently_viewed_empty
    /// 다운로드 한 콘텐츠가 여기에 표시됩니다.
    case my_download_empty
    /// 좋아요 한 콘텐츠가 여기에 표시됩니다.
    case my_like_empty
    /// 작성한 댓글이 여기에 표시됩니다.
    case my_reply_empty
    /// 아직 촬영된 콘텐츠가 없습니다.\n다른 분들이 촬영한 영상을\n먼저 둘러보세요.
    case my_contents_empty
    /// 다른 영상 둘러보기
    case my_contents_see_other
    /// 네트워크 연결이 끊어졌습니다. 기기에 저장된 콘텐츠만 재생할 수 있습니다. ‘다운로드’로 이동하시겠습니까?
    case network_error_splash
    /// 해외 로밍중에는 기기에 저장된 콘텐츠만 재생할 수 있습니다. ‘내가 만든 콘텐츠’로 이동하시겠습니까?
    case roaming_status_dialog
    /// 해외 로밍중에는 저장된 콘텐츠만 이용할 수 있습니다.
    case roaming_status
    /// USIM카드가 장착되지 않아 서비스를 시작할 수 없습니다.
    case usim_not_inserted
    /// 대폰 저장 공간이 부족하여 정상적으로 App 실행이 어렵습니다.\n저장공간을 확인해 주세요.
    case insufficient_storage
    /// 콘텐츠 이용 가능 기간이 지났습니다.
    case contents_expiration
    /// 신고로 삭제된 댓글입니다.
    case reply_reported
    /// 삭제된 콘텐츠입니다.
    case deleted_contents
    /// 댓글 내용을\n입력하지 않았습니다.
    case reply_not_entered
    /// 댓글은 200자 까지\n작성됩니다.
    case reply_overflow
    /// 댓글을 등록했습니다.
    case reply_add_completed
    /// 댓글 등록에 실패 했습니다.
    case reply_add_failed
    /// 비속어가 포함된 댓글은 등록할 수 없습니다.
    case reply_include_slang
    /// 댓글이 삭제 되었습니다.
    case reply_delete_completed
    /// 댓글 삭제를 실패 했습니다.
    case reply_delete_failed
    /// 다운로드가 완료되었습니다.
    case download_completed
    /// 다운로드를 중단하고, 해당 파일을 삭제할까요?
    case cancel_download
    /// 해당 콘텐츠는\n다운로드 재생만 지원합니다.\n다운로드 하시겠습니까?
    case cannot_contents_3d_streaming
    /// 스트리밍 재생은\n5G 또는 기가와이파이 환경에서\n이용이 가능합니다.\n다운로드 하시겠습니까?
    case cannot_contents_lte_streaming
    /// U+AR은 5G전용 서비스로,\nLTE 요금제를 이용중인 경우 이용이 제한됩니다.\n자세한 내용은 홈페이지를 참고하세요
    case cannot_lte_warning
    /// 네트워크가 불안정하여 다운로드가 중단되었습니다.
    case download_failed
    /// 다시 다운로드하기
    case download_retry
    /// 콘텐츠를 다시 내려받고 있습니다.
    case download_resumed
    /// 최근 본 콘텐츠를 30개까지 확인할 수 있습니다.
    case recently_viewed_contents_max_limited
    /// %d개의 댓글을 삭제할까요?
    case reply_delete_warn
    /// 내가 작성한 댓글을 삭제하시겠습니까?
    case reply_delete
    /// %d개의 콘텐츠를 삭제할까요?
    case delete_contents_warn
    /// 삭제했습니다.
    case delete_contents_completed
    /// 콘텐츠 삭제를 실패 했습니다.
    case delete_contents_failed
    /// 댓글 신고를 실패 했습니다.
    case reply_report_failed
    /// 재생을 실패 하였습니다.
    case play_failed
    /// 다음 콘텐츠를 이어서 재생합니다.
    case dialog_play_next_wating
    /// 재생까지 남은시간 %d초
    case dialog_play_next_wating_remaining
    /// 연속재생 설정 변경
    case dialog_play_next_setting_change
    /// 데이터 네트워크를 이용 중입니다.\n가입한 요금제에 따라\n데이터 이용 요금이 발생합니다.
    case dialog_cell_warning
    /// 다운로드 하지 않은 콘텐츠는 스트리밍\n으로 재생됩니다.
    case dialog_streaming_warning
    /// 이용 중 주변 사물에 부딪치거나 넘어지는\n사고가 발생하지 않도록 주의해 주세요.
    case dialog_ar_caution1
    /// 특히 유아, 어린이는 안전을 위해 \n꼭 보호자의 지도하에 사용해주세요.
    case dialog_ar_caution2
    /// 회원가입을 완료 했습니다.
    case register_user_completed
    /// AIS AR 앱을 이용하시려면 휴대폰 앱 설정화면에서 %s 권한을 허용해 주세요.
    case permission_rational_desc
    /// 지금 설정하기
    case setting_now
    /// 나중에 하기
    case setting_later
    /// U+ AR 가입자가 아닌 경우,\n%d초 미리보기만 가능합니다.
    case third_party_user_notice
    /// 고객님께서 사용 중인 모바일 요금제는\nU+AR 서비스\n이용 제한됩니다. 자세한 내용은\n유플러스 홈페이지를 참고 하세요.
    case third_party_user_preview_notice_mvno
    /// U+ 고객이 아닌 경우, 서비스 사용에 제한이 있습니다.
    case third_party_user_preview_notice
    /// 저장공간이 부족합니다.\n저장소 용량을 확인하여 사용하지\n않는 콘텐츠를 삭제해주세요.
    case internal_storage_required_size_exceed
    /// 더 이상 시청할 수 없는 콘텐츠 입니다. 콘텐츠 이용 상세 안내는 \'더보기\' 메뉴의 \'공지사항\' 또는 \'FAQ\'에서 확인해 주세요
    case contents_turn_off
    /// 초 미리보기가 끝났습니다.
    case preview_end_alert
    /// 해당 기능은 LTE 환경에서는 이용할 수 없습니다. 5G 또는 기가와이파이 환경에서 이용해 주세요
    case streaming_alert_lte_toast
    /// 5G 네트워크 또는 기가와이파이에 연결해야 이용할 수 있습니다.
    case streaming_alert_wifi_toast
    /// LTE 환경에서는 콘텐츠를 다운로드 후 이용해주세요.
    case contents_lte_download_toast
    /// 해당 콘텐츠는 다운로드 후 이용해 주세요
    case contents_3d_download_toast
    /// 콘텐츠를 끊김없이 시청하기\n위해서는 다운로드 후\n시청하는 것이 좋습니다.\n다운로드 하시겠어요?
    case streaming_alert_5g
    /// 파일이 삭제되어 재생할 수 없습니다.\n다시 다운로드 하시겠어요?
    case streaming_alert_lte
    /// 5G를 통해 LTE보다\n10배 빠른 속도로 다운로드하고 있습니다.
    case download_info_5g
    /// 데이터 절약 모드로 설정되어 있으면 콘텐츠를 제대로 시청할 수 없습니다. 원활한 서비스 이용을 위해 데이터 절약 모드를 해제해 주세요.
    case data_saving_mode_warn
    /// 정면에서 이미지 테두리를 분홍색 인식칸에 맞춰주세요
    case please_recognize_image
    /// 정면에서 이미지 테두리를 분홍색 인식칸에 맞춰주세요
    case please_recognize_fail
    /// 구글 렌즈로 연결 중 입니다.\n해당 작품은 구글 렌즈로 감상할 수 있습니다.
    case move_google_lens
    /// 3초후 설명 페이지로 이동합니다.
    case start_event_page_after_3s
    /// 스틸컷 크게보기
    case see_stillcut
    /// 콘텐츠 스틸컷
    case contents_stillcut
    /// 콘텐츠 목록
    case contents_preview
    /// %1$s까지
    case until_format
    /// TV속 스타, 귀여운 캐릭터와\n함께 사진이나 동영상을\n촬영해보세요.
    case tutorial_onboarding_0_title
    /// 실제로 내 눈앞에 있는 것처럼\n함께 사진이나 동영상을\n촬영해 보세요.
    case tutorial_onboarding_1_title
    /// 촬영한 사진과 동영상을\nSNS에 올려 친구, 가족들과\n즐거움을 나누세요.
    case tutorial_onboarding_2_title
    /// 지금부터 따라 해 보세요.
    case player_tutorial_title_0
    /// 각도조절
    case player_tutorial_title_1
    /// 위치이동
    case player_tutorial_title_2
    /// 크기조절
    case player_tutorial_title_3
    /// 한 손가락을 콘텐츠에 대고\n원하는 방향으로 움직여 보세요.
    case player_tutorial_desc_1
    /// 두 손가락을 콘텐츠에 대고\n움직여 보세요.
    case player_tutorial_desc_2
    /// 두 손가락을 콘텐츠에 대고\n벌렸다 오므려 보세요
    case player_tutorial_desc_3
    /// 바닥 면 인식
    case player_floor_tutorial_title_0
    /// 위치 선택
    case player_floor_tutorial_title_1
    /// 콘텐츠를 고정시킬 바닥면을 찾기 위해\n휴대폰을 좌우로 천천히 움직이세요.
    case player_floor_tutorial_desc_0
    /// 화면에 바둑판이 나타나면\n원하는 위치를 누르세요
    case player_floor_tutorial_desc_1
    /// 시작하기
    case intro_start
    /// 건너뛰기
    case intro_skip
    /// 네트워크 환경에 맞는 최적의 화질이\n자동으로 선택되어, 영상을 끊김 없이\n시청할 수 있습니다.
    case tutorial_txt_1
    /// ※ 단, 다운로드시에는 초고화질로 제공됩니다.
    case tutorial_txt_2
    /// 천
    case thousand
    /// 만
    case ten_thousand
    /// 억
    case billion
    /// LG V50 특별관
    case lge_special
    /// 보고싶은 콘텐츠를 검색하세요.
    case search_hint1
    /// 테마 콘텐츠
    case search_theme_contents
    /// 전체보기
    case view_all
    /// 전체삭제
    case delete_all
    /// 트렌드
    case trends
    /// 최근 검색어
    case search_recent
    /// 연관 검색어
    case search_related
    /// \'%s\'에 대한 검색 결과가 없습니다.\n다른 검색어를 입력해보세요.
    case search_result_null
    /// 검색 결과 총 %d건
    case search_result
    /// 사진/동영상 촬영
    case take_shot
    /// 카메라 전환
    case switch_camera
    /// https://events.uplus.co.kr/5gardance/m/index/?evt_ref=050
    case my_contents_link
    /// 휴대폰 온도가 높으니 주의하시기 바랍니다.
    case warning_temperature
    /// 이미 사용중인 이름입니다.
    case qlone_same_name
    /// 이름 입력 후 저장해주세요.
    case qlone_name_have_blink
    /// 이름에 사용할 수 없는\n특수 문자가 포함되어 있습니다.
    case qlone_name_have_special
    /// 저장은 6글자 까지 제한합니다.
    case qlone_limit_name
    /// 다운로드용 컨텐츠
    case downloadable_content
    /// 스트리밍 용 컨텐츠_중화질
    case streaming_cotent_mid_quality
    /// 스트리밍 용 컨텐츠_고화질
    case streaming_content_high_quality
    /// 스트리밍 용 컨텐츠_초고화질
    case streaming_content_ultra_quality
    /// 퍼포먼스
    case performance
    /// 스티커
    case sticker
    /// 3D 캐릭터
    case threed_character
    /// 홈화면용 썸네일
    case home_thumb
    /// Hot용 썸네일
    case hot_thumb
    /// New용 썸네일
    case new_thumb
    /// My용 썸네일
    case my_thumb
    /// 내부저장소/Download/U+AR/
    case content_path_string
    /// 복사하기
    case copying
    /// 이벤트 상세 설명 이벤트 상세 설명 이벤트 상세 설명 이벤트 상세 설명 이벤트 상세 설명 이벤트 상세 설명 이벤 트 상세 설명 이벤트 상세 설명 이벤트 상세 설명
    case event_detail_desc1
    /// 이벤트 상세 설명 이벤트 상세 설명
    case event_detal_desc2
    /// 이미지 인식 실행
    case excute_recog_image
    /// 5G로 강제 설정
    case force_set_5G
    /// WIFI/셀룰러 모두 적용됩니다.
    case all_network_set
    /// 플레이어 테스트 버튼
    case test_play_btn
    /// 앱 시작후 적용됩니다.
    case apply_after_app_start
    /// 서버변경
    case change_server
    /// 서버 변경 후 앱을 재시작 해주세요!!
    case pls_restart_app_after_change_server
    /// 속도 테스트
    case speed_test
    /// CTN 변경 테스트
    case test_for_change_ctn
    /// 변경 후 앱을 재시작 해주세요!!
    case pls_restart_app_after_change
    /// 검색 테스트 모드 설정
    case test_mode_search
    /// 약관 동의 화면
    case term_agree_screen
    /// 튜토리얼 초기화
    case init_turorial
    /// 검수
    case inspection
    /// 컨텐츠 검수 목록
    case inspect_content_list
    /// 편성 검수 목록
    case program_test_list
    /// 로컬 컨텐츠 검수 목록
    case inspect_local_content_list
    /// 약관동의
    case term_agree
    /// 비디오
    case video
    /// 움짤
    case animated
    /// 사진
    case photo
    /// BTS 스티커 다운받고 상품 받자!
    case tile_bts_promotion
    /// 썸네일
    case thumbnail
    /// 편성
    case program
    /// 재생
    case playback
    /// 텍스트
    case text
    /// GIF
    case gif
    /// 공지사항 제목입니다.
    case title_notice
    /// 공지사항 제목입니다. 공지사항 제목입니다. 공지사항 제목입니다. 공지사항 제목입니다. 공지사항 제목입니다. 공지사항 제목입니다. 공지사항 제목입니다. 공지사항 제목입니다. 공지사항 제목입니다. 공지사항 제목입니다. 공지사항 제목입니다. 공지사항 제목입니다.
    case title_notice_title_notice
    /// 댓글내용입니다. 댓글내용입니다. 댓글내용입니다.
    case replay_content_replay_content
    /// 설현
    case seolhyun
    /// FCM ID 확인
    case fcm_id_confirm
    /// 모두 확인, 동의
    case all_confirm_agree
    /// 클립보드에 복사되었습니다.
    case copied_to_clipboard
    /// 잘못된 URI 입니다.
    case invalid_uri
    /// 필수디렉토리 없음
    case mandatory_folder_not_found
    /// 디버그 모드 설정 성공
    case debug_set_ok
    /// "검수모드 설정까지 "
    case to_inspect_mode_set
    /// 회 남음
    case remain_count
    /// 검수모드 설정됨
    case inspect_mode_setted
    /// 테마
    case theme
    /// 사용하시는 디바이스에서 AIS AR 서비스를 지원하지 않습니다.
    case not_supported_your_device
    /// NW 비정상 상태 혹은 비행기모드에서 앱을 최초로 이용하시는 분은 서비스 이용이 불가합니다
    case network_error_before_login
}
