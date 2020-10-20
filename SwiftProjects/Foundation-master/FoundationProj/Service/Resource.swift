//
//  Resource.swift
//  UPlusAR
//
//  Created by baedy on 2020/04/02.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Foundation
import UIKit

struct R {
    struct String {
        struct Home {}
        struct ARPlayer {}
        struct Contents {}
        struct MoreSee {}
        struct Search {}
        struct Activity {}
        struct Album {}
        struct Inspecting {}
        struct Permission {}
        struct Terms {}
        struct Intro {}
        struct LockSetting {}
        struct AugmentedImage {}
        struct Popup {}
        struct Reply {}
        struct Popover {}
        struct Login {}
    }

    struct Color {}

    struct Image {}
}

extension R.String {
    /// 안내
    static let guide    = "안내"
    /// 알림
    static let notice   = "알림"
    /// 시스템 점검
    static let systemMaintenance = "시스템 점검"
    /// 완료
    static let done     = "완료"
    /// 확인
    static let confirm  = "확인"
    /// 취소
    static let cancel   = "취소"
    /// 닫기
    static let close    = "닫기"
    /// 삭제
    static let delete   = "삭제"
    /// 사용
    static let use      = "사용"
    /// 수락
    static let accept   = "수락"
    /// 적용
    static let apply    = "적용"
    /// 해제
    static let release  = "해제"
    /// 저장
    static let save     = "저장"
    /// 이동
    static let move     = "이동"
    /// 로그인
    static let login    = "로그인"
    /// 동의
    static let agree    = "동의"
    /// 나중에 하기
    static let later    = "나중에 하기"
    /// 앱 종료
    static let exitApp  = "종료"
    /// 나가기
    static let exit     = "나가기"
    /// 보내기
    static let send     = "보내기"
    /// 재시도
    static let retry    = "다시 시도"
    /// 네트워크 확인
    static let networkSet = "네트워크 확인"
    /// 설정
    static let setting  = "설정"
    /// 상세 보기
    static let detail   = "상세 보기"
    /// 전체선택
    static let selectAll = "전체선택"
    /// 다음
    static let next = "다음"
    /// 다시 보지 않기
    static let dontShowMe = "다시 보지 않기"
    /// 등록
    static let regist = "등록"
    /// 보관함으로 이동
    static let moveDownload = "보관함으로 이동"

    /// 해외 로밍중에는 저장된 콘텐츠만\n이용할 수 있습니다.
    static let roamingDesc = "해외 로밍중에는 저장된 콘텐츠만\n이용할 수 있습니다."

    /// 오류발생 안내
    static let networkErrorNoti = "오류발생 안내"
    /// 네트워크 연결상태를 확인하거나\n잠시 후 다시 실행해주세요.
    static let networkErrorDesc = "네트워크 연결상태를 확인하거나\n잠시 후 다시 실행해주세요."

    /// 로그인이 필요한 서비스입니다.\n로그인 해주세요.
    static let needs_login = "로그인이 필요한 서비스입니다.\n로그인 해주세요."
    /// 서비스 연결이 지연되고 있습니다.\n인터넷 연결 상태를 확인해주세요.
    static let network_error_message = "서비스 연결이 지연되고 있습니다.\n인터넷 연결 상태를 확인해주세요."
    /// 일시적으로 서비스 이용이\n원활하지 않습니다.\n(\($0))
    static let error_message: (String) -> String = { "일시적으로 서비스 이용이\n원활하지 않습니다.\n(\($0))" }

    /// GNB

    /// 홈
    static let home = "홈"
    /// 장르
    static let search = "장르"
    /// 내앨범
    static let album = "내앨범"
    /// 내활동
    static let activity = "내활동"
    /// 더보기
    static let moreSee = "더보기"
}

/// 홈
extension R.String.Home {
    /// 고객님의 취향 맞춤 콘텐츠
    static let customizeContents = "고객님의 취향 맞춤 콘텐츠"
}

extension R.String.ARPlayer {
    // 왼쪽 상단 버튼들
    /// 설정
    static let setting = "설정"
    /// 반전
    static let reverse = "반전"
    /// 타이머
    static let timer = "타이머"
    /// 바닥고정
    static let fixFloor = "바닥고정"
    /// 정보
    static let info = "상세정보"

    // 하단 버튼들
    /// 초기화
    static let refresh = "초기화"
    /// 필터
    static let filter = "필터"
    /// 꾸미기
    static let deco = "꾸미기"
    /// 더보기
    static let sticker = "더보기"

    // 캡쳐용
    /// 비디오
    static let video = "비디오"
    /// 움짤
    static let gif = "움짤"
    /// 사진
    static let picture = "사진"

    /// 설정에서 카메라 사용을 켜면 카메라를 끌 수 있어요.
    static let settingTooltip = "설정에서 카메라 사용을 켜면 카메라를 끌 수 있어요."
    /// 바닥고정으로 콘텐츠를 원하는 곳에 위치시켜 보세요.
    static let fixGroundTooltip = "바닥고정으로 콘텐츠를 원하는 곳에 위치시켜 보세요."
    /// 구간반복 기능이 '실행/해제'되었습니다. parameter true/false
    static let repeatToast: (Bool) -> String = { "구간반복 기능이 \($0 ? "실행" : "해제")되었습니다." }
    /// N 배속
    static let speedToast: (Float) -> String = { "\($0) 배속" }
    /// 해당 기능은 콘텐츠 다운로드 후\n이용 가능합니다.
    static let needDownloadPopup = "해당 기능은 콘텐츠 다운로드 후\n이용 가능합니다."
    /// "해당 콘텐츠는 다운로드 후\n이용할 수 있습니다.\n다운로드 하시겠습니까?"
    static let needDownloadPopupInContentDetail = "해당 콘텐츠는 다운로드 후\n이용할 수 있습니다.\n다운로드 하시겠습니까?"
    /// 바닥고정을 해제하면 동시보기 모드가 비활성화 됩니다.
    static let fixGroundOffGuide = "바닥고정을 해제하면 동시보기 모드가 비활성화 됩니다."

    // 튜토리얼
    /// 다음으로
    static let next = "다음으로"
    /// 시작하기
    static let start = "시작하기"

    /// 각도를 맞춰보세요.
    static let startTutorialAngle = "각도를 맞춰보세요."
    /// 위치를 옮겨보세요.
    static let startTutorialLocation = "위치를 옮겨보세요."
    /// 크기를 맞춰보세요.
    static let startTutorialSize = "크기를 맞춰보세요."

    /// 고정할 바닥면을 찾기 위해\n휴대폰을 좌우로 천천히 움직이세요.
    static let groundFixTutorial1 = "고정할 바닥면을 찾기 위해\n휴대폰을 좌우로 천천히 움직이세요."
    /// 화면에 바둑판이 나타나면\n원하는 위치를 누르세요.
    static let groundFixTutorial2 = "화면에 바둑판이 나타나면\n원하는 위치를 누르세요."
    /// 한 손가락을 대고 원하는 방향으로 각도조절\n두 손가락을 움직여서 위치 이동
    static let groundFixTutorial3 = "한 손가락을 대고 원하는 방향으로 각도조절\n두 손가락을 움직여서 위치 이동"
    /// 안드로이드용 콘텐츠는 재생할 수 없습니다.
    static let isAOSContent = "안드로이드용 콘텐츠는 재생할 수 없습니다."

    /// 콘텐츠를 불러오지 못했습니다.\n다시 시도해주세요.
    static let isNotAvailableContent = "콘텐츠를 불러오지 못했습니다.\n다시 시도해주세요."

    /// 다운로드 시 더욱 빠른 시청이 가능합니다. 다운로드 하시겠습니까?
    static let streamingError = "다운로드 시 더욱 빠른 시청이 가능합니다.\n다운로드 하시겠습니까?"

    /// 선택한 컨텐츠를 삭제하시겠습니까?
    static let alert_multi_contents_delete = "선택한 컨텐츠를 삭제하시겠습니까?"
    /// 바닥고정을 해제하면\n동시보기 모드가 비활성화 됩니다.
    static let alert_multi_contents_mode_inactive = "바닥고정을 해제하면\n동시보기 모드가 비활성화 됩니다."
    /// 배치 가능한 콘텐츠 숫자가 초과 되었습니다.
    static let toast_multi_contents_count_limit_exceed = "배치 가능한 콘텐츠 숫자가 초과 되었습니다."
    /// 동시보기 외 콘텐츠 선택 시\n동시보기된 콘텐츠가 초기화 됩니다.
    static let alert_multi_contents_reset = "동시보기 외 콘텐츠 선택 시\n동시보기된 콘텐츠가 초기화 됩니다."
    /// 바닥고정을 ON으로 켜면\n여러개의 콘텐츠를 동시에 볼 수 있습니다.
    static let alert_multi_contents_fix_ground_on = "바닥고정을 ON으로 켜면\n여러개의 콘텐츠를 동시에 볼 수 있습니다."
    /// '컨텐츠 이름' 불러오고있습니다.
    static let contentLoading = { (contentName: String) -> String in "'\(contentName)'\n불러오고 있습니다." }
    /// 네트워크 접속이 원활하지 않아\n콘텐츠를 바로 재생할 수 없습니다.\n다운로드 후 이용해 주세요.
    static let buffering10Sec = "네트워크 접속이 원활하지 않아\n콘텐츠를 바로 재생할 수 없습니다.\n다운로드 후 이용해 주세요."
    /// 재생이 완료되어 동영상 촬영이\n중단되었습니다.
    static let completePlayThenStopRecord = "재생이 완료되어 동영상 촬영이\n중단되었습니다."
}

/// 컨텐츠
extension R.String.Contents {
    /// 콘텐츠를 다운로드 하시면, 슬로우모션 및 구간반복 기능을 이용하실 수 있습니다.
    static let content_basic_info1 = "콘텐츠를 다운로드 하시면, 슬로우모션 및 구간반복 기능을 이용하실 수 있습니다."
    /// 콘텐츠 제공기간은 콘텐츠 제작사 및 기획사의 요청에 따라 변경될 수 있습니다.
    static let content_basic_info2 = "콘텐츠 제공기간은 콘텐츠 제작사 및 기획사의 요청에 따라 변경될 수 있습니다."
    /// 콘텐츠를 다운로드 후 설치하시면, 서비스를 이용하실 수 있습니다.
    static let content_basic_argame_info1 = "콘텐츠를 다운로드 후 설치하시면, 서비스를 이용하실 수 있습니다."
    /// 콘텐츠 제공기간은 콘텐츠 제작사 및 기획사의 요청에 따라 변경될 수 있습니다.
    static let content_basic_argame_info2 = "콘텐츠 제공기간은 콘텐츠 제작사 및 기획사의 요청에 따라 변경될 수 있습니다."
    /// 해당 콘텐츠는 다운로드 재생만 지원합니다.\n다운로드 하시겠습니까?
    static let cotnent_need_downloding = "해당 콘텐츠는 다운로드 재생만 지원합니다.\n다운로드 하시겠습니까?"
    /// 스트리밍 재생은 5G 또는 기가와이파이 환경에서 이용이 가능합니다.\n 다운로드 하시겠습니까?
    static let content_need_5G_OR_WIFI_State = "스트리밍 재생은 5G 또는 기가와이파이 환경에서 이용이 가능합니다.\n 다운로드 하시겠습니까?"
    /// 5G 네트워크를 통해 LTE보다 10배 빠른 속도로 콘텐츠를 다운로드하고 있습니다.
    static let content_5G_download = "5G 네트워크를 통해 LTE보다 10배 빠른 속도로 콘텐츠를 다운로드하고 있습니다."
    /// 다운로드를 중단하고 해당 파일을 삭제할까요?
    static let content_delete_downloding = "다운로드를 중단하고 해당 파일을 삭제할까요?"
    /// 다운로드가 완료되었습니다.
    static let content_download_completed = "다운로드가 완료되었습니다."
    /// 다운로드에 실패 했습니다.
    static let content_download_fail = "다운로드에 실패 했습니다."
    /// 댓글을 남겨주세요.
    static let pleaseRegistReply = "댓글을 남겨주세요."
    /// 묶음 콘텐츠 목록
    static let packedContentList = "묶음 콘텐츠 목록"
    /// 연관 콘텐츠
    static let relatedContent = "연관 콘텐츠"
    /// 재생 시간
    static let playTime = "재생 시간"
    /// 데이터 용량
    static let dataSize = "데이터 용량"
    /// 출연진정보
    static let artistInfo = "출연진정보"
    /// 제공 기간
    static let limitDate = "제공 기간"
}

/// 내 활동 텍스트 모음
extension R.String.Activity {
    /// 최근 본 타이틀
    static let recently_title = "최근 본"
    /// 다운로드 타이틀
    static let donwload_title = "다운로드"
    /// 찜 타이틀
    static let like_title = "찜"
    /// 내가 쓴 댓글 타이틀
    static let reply_title = "내가 쓴 댓글"
    /// 선택 항목 삭제 (xx)
    static let delete_count: (Int) -> String = { "선택 항목 삭제 (\($0))" }
    /// 삭제 팝업
    static let alert_delete_count: (Int) -> String = { "\($0)개 콘텐츠를 삭제할까요?" }
    /// 삭제가 완료되었습니다.
    static let toast_delete_success = "삭제가 완료되었습니다."
    /// 콘텐츠 이용 기간이 만료되었습니다.
    static let content_expired = "콘텐츠 이용 기간이 만료되었습니다."
    /// 최근 본 콘텐츠가 여기에 표시됩니다.
    static let empty_content_recently = "최근 본 콘텐츠가 여기에 표시됩니다."
    /// 다운로드 한 콘텐츠가 여기에 표시됩니다.
    static let empty_content_download = "다운로드 한 콘텐츠가 여기에 표시됩니다."
    /// 찜 한 콘텐츠가 여기에 표시됩니다.
    static let empty_content_like = "찜 한 콘텐츠가 여기에 표시됩니다."
    /// 작성한 댓글이 여기에 표시 됩니다.
    static let empty_content_reply = "작성한 댓글이 여기에 표시 됩니다."
    /// 다운로드순
    static let sort_download_title = "다운로드순"
    /// 용량순
    static let sort_allSize_title = "용량순"
}

extension R.String.MoreSee {
    /// 이벤트
    static let eventTabTitle = "이벤트"
    /// 공지사항
    static let noticeTabTitle = "공지사항"
    /// FAQ
    static let FAQTabTitle = "FAQ"
    /// 1:1 문의
    static let questionTabTitle = "1:1문의"
    /// 기타설정
    static let etcTabTitle = "기타설정"

    /// 닉네임 변경
    static let nickNameChange = "닉네임 변경"
    /// 비밀번호 변경
    static let passwordChange = "비밀번호 변경"
    /// 설정한 비밀번호를 변경할 수 있습니다.
    static let passwordChangeSub = "설정한 비밀번호를 변경할 수 있습니다."
    /// 19+ 콘텐츠 숨김
    static let adultBlock = "19+ 콘텐츠 숨김"
    /// 19+ 카테고리 및 19+ 콘텐츠가 앱에 노출되지 않도록 합니다.
    static let adultBlockSub = "19+ 카테고리 및 19+ 콘텐츠가 앱에 노출되지 않도록 합니다."
    /// 19+ 콘텐츠 잠금
    static let adultLock = "19+ 콘텐츠 잠금"
    /// 비밀번호를 입력해야 19+ 콘텐츠를 시청할 수 있도록 설정합니다.
    static let adultLockSub = "비밀번호를 입력해야 19+ 콘텐츠를 시청할 수 있도록 설정합니다."
    /// 이벤트/할인 혜택 알림
    static let benefitAlert = "이벤트/할인 혜택 알림"
    /// 다양한 이벤트 및 혜택 정보 수신을 동의/거부할 수 있습니다.
    static let benefitSub = "다양한 이벤트 및 혜택 정보 수신을 동의/거부할 수 있습니다."
    /// 연속 재생 설정
    static let forwardPlay = "연속 재생 설정"
    /// 스티커를 제외한 다음 목록의 영상이 자동으로 재생됩니다.
    static let forwardSub = "스티커를 제외한 다음 목록의 영상이 자동으로 재생됩니다."
    /// 콘텐츠 저장 위치 설정
    static let storageLocation = "콘텐츠 저장 위치 설정"
    /// 버전정보(최신버전 00.00.00)
    static let version: (String) -> String = { "버전정보(최신버전 \($0))" }
    /// 현재 버전 00.00.00
    static let versionSub: (String) -> String  = { "현재 버전 \($0)" }
    /// 오픈소스 라이선스
    static let openSource = "오픈소스 라이선스"
    /// 이용약관동의
    static let terms = "이용약관동의"
    /// 개인정보처리방침
    static let privacyPolicy = "개인정보처리방침"
    /// 종료된 이벤트입니다
    static let endEventTitle = "종료된 이벤트입니다"
    /// AR 게임 출시 이벤트
    static let arGameEvent = "AR 게임 출시 이벤트"
    /// 현재 앱 버전
    static let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

    /// 닉네임을 입력해 주세요
    static let nickNamePlaceholder = "닉네임을 입력해 주세요."
    /// 현재 닉네임
    static let currentNickname = "현재 닉네임"
    /// 변경할 닉네임 입력
    static let changeNickNameGuide = "변경할 닉네임 입력"
    /// 닉네임이 변경되었습니다.
    static let nickNameChanged = "닉네임이 변경되었습니다."
    /// 중복된 닉네임입니다.
    static let multipleNickName = "중복된 닉네임입니다."
    /// 1:1 문의
    /// 서비스 문의
    static let questionTitle = "서비스 문의"
    /// U+AR을 이용하면서 궁금했던 점이나 하고 싶은 말을 자유롭게 남겨주세요.\n 담당자가 확인 후 메일로 답변 드리겠습니다.
    static let questionDetail = "U+AR을 이용하면서 궁금했던 점이나 하고 싶은 말을 자유롭게 남겨주세요.\n담당자가 확인 후 메일로 답변 드리겠습니다."

    /// 문의 유형을 선택하세요.
    static let chooseQuestion = "문의 유형을 선택하세요."
    /// 앱 이용방법 문의
    static let appUse = "앱 이용방법 문의"
    /// 요금/데이터 문의
    static let chargeData = "요금 / 데이터 문의"
    /// 콘텐츠 종류/품질 문의
    static let content = "콘텐츠 종류 / 품질 문의"
    /// 이벤트 문의
    static let event = "이벤트 문의"
    /// 기타 문의
    static let etc = "기타 문의"
    /// 휴대폰 인증
    static let certification = "휴대폰 인증"
    /// 그 외 건의사항 또는 개선 요청
    static let improvement = "그 외 건의사항 또는 개선 요청"
    /// 등록하기
    static let registerButtonTitle = "등록하기"
    /// 답변 받을 이메일 주소를 남겨주세요.
    static let emailPlaceholderMsg = "답변 받을 이메일 주소를 남겨주세요."
    /// 문의 사항을 남겨주세요.
    static let questionPlaceholderMsg = "문의 사항을 남겨주세요."
    /// 문의하신 내용에 답변 드리기 위해 고객님의 이메일 주소를 수집합니다. 답변이 완료되면 수집한 개인정보는, 관련 법령 또는 회사 내부 방침에 따라 보존해야 하는 경우를 제외하고 모두 폐기합니다. 자세한 내용은 LG U+ 홈페이지 U+AR 개인 정보처리방침을 참고하세요.
    static let infoTextMsg = "문의하신 내용에 답변 드리기 위해 고객님의 이메일 주소를 수집합니다. 답변이 완료되면 수집한 개인정보는, 관련 법령 또는 회사 내부 방침에 따라 보존해야 하는 경우를 제외하고 모두 폐기합니다. 자세한 내용은 LG U+ 홈페이지 U+AR 개인 정보처리방침을 참고하세요."
    /// 위 내용에 동의합니다.
    static let agreeTextMsg = "위 내용에 동의합니다."
    /// 문의를 보내시겠습니까?
    static let sendMessageAsk = "문의를 보내시겠습니까?"
    /// 등록되었습니다.\n담당자 확인 후 빠른 회신 드리겠습니다.
    static let registerToastMsg = "등록되었습니다.\n담당자 확인 후 빠른 회신 드리겠습니다."
    /// 문의 실패
    static let sendMessageFail = "문의 실패"

    /// 버전 업데이트가 필요합니다.
    static let requestUpdateString = "버전 업데이트가 필요합니다."
    /// 최신 버전입니다.
    static let latestVersionString = "최신 버전입니다."
    /// 버전 :
    static let versionString = "버전 : "
    /// 현재 버전 :
    static let currentVersionDescriptionString = "현재 버전 : "
    /// 최신 버전 :
    static let latestVersionDescriptionString = "최신 버전 : "

    /// 이전 버전 보기
    static let preversVersion = "이전 버전 보기"

    /// 다음 버전 보기
    static let nextVersion = "다음 버전 보기"
}

extension R.String.Album {
    /// 3D 스캔 콘텐츠
    static let qlTitle = "3D 스캔 콘텐츠"
    /// 동영상/GIF/사진
    static let media = "동영상/GIF/사진"
    /// 내가 만든 콘텐츠
    static let albumTitle = "내가 만든 콘텐츠"
    /// 생성된 콘텐츠가 없습니다.
    static let empty_content_media = "생성된 콘텐츠가 없습니다."
    /// 선택 항목 삭제
    static let deleteItem = "선택 항목 삭제"
    /// 공유하기
    static let shared = "공유하기"
    /// 한 번 삭제하면\n다시 복구할 수 없습니다.\n그래도 삭제하시겠습니까?
    static let deleteContent = "한 번 삭제하면\n다시 복구할 수 없습니다.\n그래도 삭제하시겠습니까?"
    /// 한번 삭제한 콘텐츠는 복구할 수 없습니다. 정말 삭제하시겠습니까?
    static let deleteAlbumContent = "한번 삭제한 콘텐츠는\n복구할 수 없습니다.\n정말 삭제하시겠습니까?"
    /// 저장하지 않고 플레이어로\n돌아가시겠습니까?
    static let popNoneSave = "저장하지 않고 플레이어로\n돌아가시겠습니까?"
    /// 삭제가 완료되었습니다.
    static let deleteComplete = "삭제가 완료되었습니다."
    /// 삭제되었습니다.
    static let deleteCaptureComplete = "삭제되었습니다."
    /// 공유가 실패했습니다.\n다시 시도해 주세요.
    static let shareFail = "공유가 실패했습니다.\n다시 시도해 주세요."
    /// 공유가 완료되었습니다.
    static let shareComplete = "공유가 완료되었습니다."
    /// 저장되었습니다.
    static let saveComplete = "저장되었습니다."
    /// 아직 촬영된 콘텐츠가 없네요\n다른 분들이 촬영한 영상을 먼저 둘러보세요
    static let emptyTooltipTitle = "아직 촬영된 콘텐츠가 없네요\n다른 분들이 촬영한 영상을 먼저 둘러보세요"
    /// 다른 영상 둘러보기 시 띄우는 링크
    static let eventLink = "https://events.uplus.co.kr/5gardance/m/index/?evt_ref=050"
}

extension R.String.Search {
    /// Search Bar PlaceHolder
    /// 테마 콘텐츠
    static let themaTitle = "테마 콘텐츠"
    /// 전체보기
    static let themaShowAll = "전체보기"
    /// 전체삭제
    static let deleteTotalAllString = "전체삭제"
    /// 보고 싶은 콘텐츠를 검색하세요
    static let searchBarPlaceHolder = "보고 싶은 콘텐츠를 검색하세요"

    /// 연관 검색어
    static let relatedSearchString = "연관 검색어"
    /// 최근 검색어
    static let recentlySearchedString = "최근 검색어"
    /// 검색 결과 총
    static let searchResultCount1 = "검색 결과 총 "
    /// 건
    static let searchResultCount2 = "건"

    /// 상세보기
    static let showDetailString = "상세보기"

    ///  에 대한 검색 결과가 없습니다.\n다른 검색어를 입력해보세요.
    static let noResultString = " 에 대한 검색 결과가 없습니다.\n다른 검색어를 입력해보세요."
    /// 최근 검색어가 없습니다.
    static let noRecentlyTableString = "최근 검색어가 없습니다."
    /// 최신순
    static let orderTypeRecently = "최신순 "
    /// 인기순
    static let orderTypeFamous = "인기순 "
    /// 검색어를 입력해 주세요
    static let needKeywordString = "검색어를 입력해 주세요"
    /// 9999.99.99
    static let dateSampleString = "9999.99.99"
}

extension R.String.Inspecting {
    /// 검수 화면
    static let inspectingMainTitle = "검수 화면"

    /// 5G로 강제 설정
    static let networkSettingTitle = " 5G로 강제 설정"
    /// WIFI/셀룰러 모두 적용됩니다.
    static let networkSettingDetail = "WIFI/셀룰러 모두 적용됩니다."

    /// 서버변경
    static let serverChangeTitle = "서버변경"
    /// 서버 변경 후 앱을 재시작 해 주세요!!
    static let serverChangeDetail = "서버 변경 후 앱을 재시작 해 주세요!!"

    /// CTN 변경 테스트
    static let changeCTNTestTitle = "CTN 변경 테스트"
    /// 변경 후 앱을 재시작 해 주세요!!
    static let changeCTNTestDetail = "변경 후 앱을 재시작 해 주세요!!"
    /// FCM ID
    static let FCMIDTitle = "FCM ID"
    /// FCM ID 확인
    static let checkFCMIDTitle = "FCM ID 확인"
    /// FCM ID 가져오기를 실패하였습니다.
    static let failToLoadFCMID = "FFCM ID 가져오기를 실패하였습니다."
    /// 약관 동의 화면
    static let checkTOSTitle = "약관 동의 화면"
    /// 튜토리얼 초기화
    static let resetTutorialTitle = "튜토리얼 초기화"

    /// 컨텐츠 검수 목록
    static let inspectingContentTitle = "컨텐츠 검수 목록"
    /// 편성 검수 목록
    static let inspectingOrganizationTitle = "편성 검수 목록"
    /// 로컬 컨텐츠 검수 목록
    static let inspectingLocalContentTitle = "로컬 컨텐츠 검수 목록"
    /// 개발 서버
    static let devServer = "개발 서버"
    /// 검수 서버
    static let stagingServer = "검수 서버"
    /// 상용 서버
    static let proServer = "상용 서버"
    /// 유심정보 사용
    static let usim = "유심정보 사용"
    /// 자사(U+)
    static let uplus = "자사(U+)"
    /// 타사(SKT)
    static let skt = "타사(SKT)"
    /// 타사(KT)
    static let kt = "타사(KT)"
    /// 검수(U+)
    static let inspectionUPlus = "검수(U+)"
}

extension R.String.Permission {
    /// 접근 권한 동의
    static let title = "접근 권한 동의"
    /// U+AR 필수 접근 권한 안내
    static let mainMsg = "U+AR 필수 접근 권한 안내"
    /// 서비스를 이용하시려면 아래 권한에 반드시 동의 해주셔야 합니다.
    static let subMsg = "서비스를 이용하시려면 아래 권한에 반드시 동의 해주셔야 합니다."

    /// 카메라, 콘텐츠를 활용하여 영상을 촬영할 수 있습니다.
    static let camera: (String, String) = ("카메라", "콘텐츠를 활용하여 영상을 촬영할 수 있습니다.")
    /// 사진, 콘텐츠를 다운로드하거나 촬영한 영상을 저장할 수 있습니다.
    static let picture: (String, String) = ("사진", "콘텐츠를 다운로드하거나 촬영한 영상을 저장할 수 있습니다.")
    /// 오디오 녹음, 영상 촬영 중 음향을 녹음하고 저장할 수 있습니다.
    static let mic: (String, String) = ("오디오 녹음", "영상 촬영 중 음향을 녹음하고 저장할 수 있습니다.")

    /// 카메라
    static let cameraTitle = "카메라"
    /// 사진
    static let photoTitle = "사진"
    /// 마이크
    static let micTitle = "마이크"
    /// \(source) 권한에 접근을 허용해야 U+AR을 이용할 수 있습니다. 설정 > 'U+AR'에서 허용 여부를 확인해 주세요.
    static let authorization: (String) -> String = { "\($0) 권한에 접근을 허용해야 U+AR을 이용할 수 있습니다. 설정 > 'U+AR'에서 허용 여부를 확인해 주세요." }
}

extension R.String.Terms {
    /// 약관동의
    static let title = "약관동의"
    /// 5G 시대를 맞이하여 고객님을 더 알고, 마음에 쏙 드는 신 개념 새로운 콘텐츠 제공을 위해 약관동의를 받습니다. 한번 동의 후 즐겁게 이용해 주세요.
    static let mainMsg = "5G 시대를 맞이하여 고객님을 더 알고, 마음에 쏙 드는 신 개념 새로운 콘텐츠 제공을 위해 약관동의를 받습니다. 한번 동의 후 즐겁게 이용해 주세요."
    /// ※ 고객님께서는 위 사항에 대해 거부하실 권리가 있습니 다. 단, 미 동의 시 서비스 이용에 제한이 있을 수 있는 점 양해 부탁 드립니다.
    static let bottomMsg = "※ 고객님께서는 위 사항에 대해 거부하실 권리가 있습니 다. 단, 미 동의 시 서비스 이용에 제한이 있을 수 있는 점 양해 부탁 드립니다."
    /// 동의하지 않습니다
    static let notAgree = "동의하지 않습니다"
    /// 동의합니다
    static let agree = "동의합니다"
    /// 필수 약관에 모두 동의하지 않으면 서비스 이용이 불가능합니다.
    static let needCheckMandatoryTerms = "필수 약관에 모두 동의하지 않으면 서비스 이용이 불가능합니다."
    /// 이용약관동의
    static let useAgreement = "이용약관동의"
    /// 정보 수집 및 이용에 대한 동의
    static let personalInfoCollection = "정보 수집 및 이용에 대한 동의"
    /// 개인 정보 처리 위탁 동의
    static let personalInfoProcessing = "개인 정보 처리 위탁 동의"
    /// 오픈소스라이선스
    static let openSourceLicense = "오픈소스라이선스"
    /// 개인정보처리방침
    static let privacyPolicy = "개인정보처리방침"

    /// 이용약관동의(필수)
    static let necessaryUseAgreement = "이용약관동의(필수)"
    /// 개인정보수집 및 이용동의(필수)
    static let necessaryPersonalInfoCollection = "개인정보수집 및 이용동의(필수)"
    /// 개인정보 위탁 동의(필수)
    static let necessaryPersonalInfoProcessing = "개인정보 위탁 동의(필수)"
    /// 마케팅 수신동의(선택)
    static let marketingAgreement = "마케팅 수신동의(선택)"
    /// 이벤트 프로모션 등 광고/정보를 문자, 이메일 등 으로 받아 봅니다.
    static let eventPushAgreement = "이벤트 프로모션 등 광고/정보를 문자, 이메일 등 으로 받아 봅니다."
    /// 전체동의
    static let allAgreement = "전체동의"
}

extension R.String.Intro {
    /// 0: TV속 스타, 귀여운 캐릭터와\n함께 사진이나 동영상을\n촬영해 보세요.
    /// 1: 실제로 내 눈앞에 있는 것처럼\n함께 사진이나 동영상을\n촬영해 보세요.
    /// 2: 촬영한 사진과 동영상을\nSNS에 올려 친구, 가족들과\n즐거움을 나누세요.
    static var guide: (Int) -> String = {
        switch $0 {
        case 0: return "TV속 스타, 귀여운 캐릭터와\n함께 사진이나 동영상을\n촬영해 보세요."
        case 1: return "실제로 내 눈앞에 있는 것처럼\n함께 사진이나 동영상을\n촬영해 보세요."
        case 2: return "촬영한 사진과 동영상을\nSNS에 올려 친구, 가족들과\n즐거움을 나누세요."
        default: return ""//.empty
        }
    }
}

extension R.String.Popup {
    /// 데이터 네트워크를 이용 중입니다.\n가입한 요금제에 따라\n데이터 이용 요금이 발생합니다.
    static let currentWWANNetwork = "데이터 네트워크를 이용 중입니다.\n가입한 요금제에 따라\n데이터 이용 요금이 발생합니다."
    /// 이용 중 주변 사물에 부딪치거나 넘어지는\n사고가 발생하지 않도록 주의해 주세요
    static let warningTitle = "이용 중 주변 사물에 부딪치거나 넘어지는\n사고가 발생하지 않도록 주의해 주세요"
    /// 특히 유아, 어린이는 안전을 위해\n꼭 보호자의 지도하에 사용해 주세요.s
    static let warningSubTitle = "특히 유아, 어린이는 안전을 위해\n꼭 보호자의 지도하에 사용해 주세요."
    /// 해당 콘텐츠는 다운로드 후 이용해 주세요.
    static let downloadInduce = "해당 콘텐츠는 다운로드 후 이용해 주세요."
    /// 신고하기
    static let replyReportTitle = "신고하기"
    /// 부적절한 홍보 게시글
    static let replyReportReason1 = "부적절한 홍보 게시글"
    /// 음란성 또는 청소년에게 부적합한 내용
    static let replyReportReason2 = "음란성 또는 청소년에게 부적합한 내용"
    /// 명예훼손 / 사생활 침해 및 저작권 침해 등
    static let replyReportReason3 = "명예훼손 / 사생활 침해 및 저작권 침해 등"
    /// 기타
    static let replyReportReason4 = "기타"
    /// major: 서비스 이용에 꼭 필요한 업데이트가 있습니다.\n앱을 계속 이용하시려면 지금 업데이트 하세요.
    /// minor: 최신 업데이트가 있습니다.\n업데이트 하시겠습니까?
//    static var updateMsg: (FDVersion.VersionType) -> String = {
//        switch $0 {
//        case .major: return "서비스 이용에 꼭 필요한 업데이트가 있습니다.\n앱을 계속 이용하시려면 지금 업데이트 하세요."
//        case .minor: return "최신 업데이트가 있습니다.\n업데이트 하시겠습니까?"
//        }
//    }
    /// 게임을 실행합니다.
    static let startARGame = "게임을 실행합니다."
    /// 게임을 실행하려면 앱을 설치해야 합니다. 앱은 무료이며 다운로드 시 요금제에 따라 데이터 이용요금이 발생할 수 있습니다.
    static let installGame = "게임을 실행하려면 앱을 설치해야 합니다. 앱은 무료이며 다운로드 시 요금제에 따라 데이터 이용요금이 발생할 수 있습니다."
    /// 네트워크 연결이 끊어졌습니다. 기기에 저장된 콘텐츠만 재생 할 수 있습니다. '다운로드'로 이동하시겠습니까?
    static let introNetworkCheck = "네트워크 연결이 끊어졌습니다. 기기에 저장된 콘텐츠만 재생 할 수 있습니다. '다운로드'로 이동하시겠습니까?"
    /// 저장 공간이 부족합니다.\n저장 공간 확보 후 다시 다운로드해 주세요.
    static let hasNoStorageSpace = "저장 공간이 부족합니다.\n저장 공간 확보 후 다시 다운로드해 주세요."
    /// USIM카드가 없습니다. 앱을 종료합니다.
    static let hasNoSim = "USIM카드가 없습니다.\n앱을 종료합니다."
    /// 동시보기 외 콘텐츠 선택 시 동시보기된 콘텐츠가 초기화 됩니다.
    static let exitMultiContentNoti = "동시보기 외 콘텐츠 선택 시 동시보기된 콘텐츠가 초기화 됩니다."
    /// 해당 콘텐츠는 다운로드 재생만 지원합니다. 다운로드 하시겠습니까?
    static let downloadContentNoti = "해당 콘텐츠는 다운로드 재생만 지원합니다. 다운로드 하시겠습니까?"
    /// LTE 네트워크 이용 중에는 콘텐츠를\n다운로드 후 재생할 수 있습니다.\n다운로드 하시겠습니까?
    static let downloadContentInCaseOfLTENetworkNoti = "LTE 네트워크 이용 중에는 콘텐츠를\n다운로드 후 재생할 수 있습니다.\n다운로드 하시겠습니까?"
    /// 오늘 하루 보지 않기
    static let notShowingTodayTitle = "오늘 하루 보지 않기"
    /// 오일주일 동안 보지 않기
    static let notShowingWeekTitle = "일주일 동안 보지 않기"
}

extension R.String.LockSetting {
    /// 19+ 잠금 설정
    static let lockSettingTitle = "19+ 잠금 설정"
    /// 청소년 보호를 위해 19+ 콘텐츠는 비밀번호를 입력해야 볼 수 있도록 잠금 설정되어 있습니다. 설정을 유지하시겠습니까?
    static let lockSettingMsg = "청소년 보호를 위해 19+ 콘텐츠는 비밀번호를 입력해야 볼 수 있도록 잠금 설정되어 있습니다. 설정을 유지하시겠습니까?"
    /// 잠금 해제 시 모든 19+ 콘텐츠가 앱 화면에 바로 노출됩니다.
    static let unlockTitle = "잠금 해제 시 모든 19+ 콘텐츠가 앱 화면에 바로 노출됩니다."
    /// ※ [더보기] → [기타설정]에서\n19+콘텐츠 잠금을 설정할 수 있습니다.
    static let unlockMsg = "※ [더보기] → [기타설정]에서\n19+콘텐츠 잠금을 설정할 수 있습니다."

    /// 비밀번호 설정
    static let passwordSettingTitle = "비밀번호 설정"
    /// 19+ 콘텐츠 숨김 또는 잠금 기능을 이용하려면 비밀번호를 설정해야 합니다.
    static let passwordSettingMsg = "19+ 콘텐츠 숨김 또는 잠금 기능을 이용하려면 비밀번호를 설정해야 합니다."
    /// 4자리 숫자 입력
    static let passwordTextFieldPlaceholder = "4자리 숫자 입력"
    /// 4자리 숫자 재입력
    static let passwordConfirmTextFieldPlaceholder = "4자리 숫자 재입력"

    /// 비밀번호 입력
    static let confirmLockTitle = "비밀번호 입력"
    /// 19+ 콘텐츠 숨김 또는 잠금을 해제하려면 비밀번호를 입력해야 합니다.
    static let confirmLockMsg = "19+ 콘텐츠 숨김 또는 잠금을 해제하려면 비밀번호를 입력해야 합니다."
    /// 비밀번호 4자리 숫자 입력
    static let confirmPasswordPlaceholder = "비밀번호 4자리 숫자 입력"

    /// 비밀번호 변경
    static let passwordReSettingTitle = "비밀번호 변경"
    /// 비밀번호를 다시 설정합니다.
    static let passwrodReSettingMag = "비밀번호를 다시 설정합니다."
    /// 현재 비밀번호 입력
    static let passwordReSettingCurrentPlaceholder = "현재 비밀번호 입력"
    /// 새로운 비밀번호 4자리 숫자 입력
    static let passwordReSettingTextFieldPlaceholder = "새로운 비밀번호 4자리 숫자 입력"
    /// 새로운 비밀번호 4자리 숫자 재입력
    static let passwordReSettingConfirmTextFieldPlaceholder = "새로운 비밀번호 4자리 숫자 재입력"

    /// 두 비밀번호를 동일하게 입력해 주세요.
    static let guideNotSame = "두 비밀번호를 동일하게 입력해 주세요."
    /// 사용하실 비밀번호를 다시 설정해주세요.
    static let guideInit = "사용하실 비밀번호를 다시 설정해주세요."
    /// 설정하실 비밀번호를 다시 한번 확인해주세요.
    static let guideReCheck = "설정하실 비밀번호를 다시 한번 확인해주세요."
    /// 잘못된 비밀번호 입니다. 다시 입력해 주세요.
    static let guideWrongPassword = "잘못된 비밀번호 입니다. 다시 입력해 주세요."
    /// 현재 설정된 비밀번호 4자리를 작성해주세요.
    static let guideCurrentEmptyPassword = "현재 설정된 비밀번호 4자리를 작성해주세요."
    /// 현재 설정된 비밀번호를 확인해주세요.
    static let guideCurrentWorongPassword = "현재 설정된 비밀번호를 확인해주세요."
    /// 시청권한이 없는 콘텐츠 입니다.
    static let guideNoAuthContent = "시청권한이 없는 콘텐츠 입니다."
    /// 19+콘텐츠 잠금 설정이 되어 있습니다.
    static let guideLock19Content = "19+콘텐츠 잠금 설정이 되어 있습니다."

    /// 비밀번호를 설정했습니다.
    static let toastPasswordSettingMsg = "비밀번호를 설정했습니다."
    /// 비밀번호를 재설정 했습니다.
    static let toastReSettingMsg = "비밀번호를 재설정 했습니다."
    /// 19+콘텐츠 잠금을 해제했습니다.
    static let toastLockSettingMsg = "19+콘텐츠 잠금을 설정했습니다."
    /// 19+콘텐츠 잠금을 해제했습니다.
    static let toastUnLockSettingMsg = "19+콘텐츠 잠금을 해제했습니다."
    /// 19+콘텐츠 숨김을 설정했습니다.
    static let toastBlockSettingMsg = "19+콘텐츠 숨김을 설정했습니다."
    /// 19+콘텐츠 숨김을 해제했습니다.
    static let toastUnBlockSettingMsg = "19+콘텐츠 숨김을 해제했습니다."
    /// 닉네임이 변경되었습니다.
    static let toastNicknameSettingMsg = "닉네임이 변경되었습니다."
}

extension R.String.AugmentedImage {
    /// 이미지 인식
    static let title = "이미지 인식"
    /// 인식할 이미지를 사각테두리 안에 놓아주세요.
    static let welcomeMessage = "인식할 이미지를 사각테두리 안에 놓아주세요."
    /// 이미지를 인식하지 못했습니다.\n다시 시도해 주세요.
    static let failedMessage = "이미지를 인식하지 못했습니다.\n다시 시도해 주세요."
    /// firebase storage directory name "event_arimages/"
    static let firebaseStorageDirectory = "event_arimages/"
    /// google ios app scheme "google://"
    static let iOSGoogleAppScheme = "google://"
    /// google ios appStore URL String "itms-apps://itunes.apple.com/app/id284815942"
    static let iOSGoogleAppURL = "itms-apps://itunes.apple.com/app/id284815942"
}

extension R.String.Reply {
    /// 댓글 내용을 입력하지 않았습니다.
    static let emptyReply = "댓글 내용을 입력하지 않았습니다."
    /// 해당 댓글을 삭제하시겠습니까?
    static let deleteReply = "해당 댓글을 삭제하시겠습니까?"
    /// 삭제가 완료되었습니다.
    static let deletedReply = "삭제가 완료되었습니다."
    /// 댓글은 \($0)자 까지 작성됩니다.
    static let maximumLimit: (String) -> String  = { "댓글은 \($0)자 까지 작성됩니다." }
    /// 비속어가 포함된 댓글은 등록할 수 없습니다.
    static let noSlang = "비속어가 포함된 댓글은 등록할 수 없습니다."
    /// 신고가 완료되었습니다.
    static let replyReportCompleted = "신고가 완료되었습니다."
    /// 상세 내용을 작성해 주세요.
    static let fillDetail = "상세 내용을 작성해 주세요."
    /// 작성자
    static let writer = "작성자"
    /// 내용
    static let contents = "내용"
    /// 사유선택
    static let reasonSelect = "사유선택"
    /// 댓글
    static let reply = "댓글 "
    /// 댓글 \($0)
    static let replyCount: (String) -> String = { "댓글 \($0)" }
}

extension R.String.Popover {
    /// 카메라 사용
    static let offCameraTitle = "카메라 사용"
    /// 카메라를 끄면 배경 없이 콘텐츠를\n감상합니다.
    static let offCameraSubtitle = "카메라를 끄면 배경 없이 콘텐츠를\n감상합니다."
    /// 카메라를 끄면 배경 없이 콘텐츠를 감상합니다.
    static let offCameraSubtitleOneLine = "카메라를 끄면 배경 없이 콘텐츠를 감상합니다."
    /// 배경 고정
    static let fixBackgroundTitle = "배경 고정"
    /// 현재 카메라 배경으로 콘텐츠를\n감상합니다.
    static let fixBackgroundSubtitle = "현재 카메라 배경으로 콘텐츠를\n감상합니다."
    /// 현재 카메라 배경으로 콘텐츠를 감상합니다.
    static let fixBackgroundSubtitleOneLine = "현재 카메라 배경으로 콘텐츠를 감상합니다."
    /// 콘텐츠 효과
    static let screenEffectTitle = "콘텐츠 효과"
    /// 콘텐츠에 적용 된 효과와 함께\n감상합니다.
    static let screenEffectSubtitle = "콘텐츠에 적용 된 효과와 함께\n감상합니다."
    /// 콘텐츠에 적용 된 효과와 함께 감상합니다.
    static let screenEffectSubtitleOneLine = "콘텐츠에 적용 된 효과와 함께 감상합니다."
    /// 외부 음성 차단
    static let exMicTitle = "외부 음성 차단"
    /// 비디오 녹화 시 콘텐츠와 소리만\n녹음됩니다.
    static let exMicSubTitle = "비디오 녹화 시 콘텐츠와 소리만\n녹음됩니다."
    /// 비디오 녹화 시 콘텐츠와 소리만 녹음됩니다.
    static let exMicSubTitleOneLine = "비디오 녹화 시 콘텐츠와 소리만 녹음됩니다."
    /// 지원되지 않는 기능입니다.
    static let noSupport = "지원되지 않는 기능입니다."
    /// 최근
    static let recent = "최근"
    /// HOT
    static let hot = "HOT"
    /// NEW
    static let new = "NEW"
    /// 추천
    static let recomment = "추천"
    /// 묶음 콘텐츠
    static let sticker = "묶음 콘텐츠"
    /// 동시보기
    static let multiContent = "동시보기"

    /// UnitryDecoPage
    /// 효과 없음
    static let DecoPageNoEffect = "효과 없음"
}

extension R.String.Login {
    /// 5G 요금제 가입자는 본인인증시 더 많은\n콘텐츠를 즐길 수 있습니다.
    static let loginGuideLabel = "5G 요금제 가입자는 본인인증시 더 많은\n콘텐츠를 즐길 수 있습니다."
    /// 휴대폰 본인인증
    static let verifyCTN = "휴대폰 본인인증"
    /// 본인인증 없이 감상하기
    static let notLogin = "본인인증 없이 감상하기"
    /// 법인 고객이라면, U+ID 로그인을 이용해주세요.
    static let informationLogin = "법인 고객이라면, U+ID 로그인을 이용해주세요."
    /// 5G 요금제 가입자이신가요?\n본인인증하고 더 많은 콘텐츠를 즐기세요!
    static let tooltipMessage = "5G 요금제 가입자이신가요?\n본인인증하고 더 많은 콘텐츠를 즐기세요!"
    /// 휴대폰 본인인증을 완료했습니다.
    static let verifyCTNCompleted = "휴대폰 본인인증을 완료했습니다."
    /// 5G 요금제 미가입 고객입니다.\n5G 요금제에 가입하시면 더 많은 콘텐츠를 즐기실 수 있습니다.
    static let not5GfeeUser = "5G 요금제 미가입 고객입니다.\n5G 요금제에 가입하시면 더 많은 콘텐츠를 즐기실 수 있습니다."
}

extension R.Color {
    static let base = #colorLiteral(red: 0.9098039216, green: 0.2352941176, blue: 0.3529411765, alpha: 1)
    static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let background = #colorLiteral(red: 0.1137254902, green: 0.1098039216, blue: 0.1294117647, alpha: 1)
    static let `default` = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let sub = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    static let alphaColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
    static let placeholderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)
}

extension R.Image {
    static let RightMore = UIImage(named: "ic_right_more")
}
