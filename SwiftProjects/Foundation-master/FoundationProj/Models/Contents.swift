import BonMot
import Foundation
import RxCocoa
import RxSwift
import UIKit
import Unrealm

struct ContentFiles: Decodable {
    var contents_key: Int? // multicontent에서 이용되는 콘텐츠 ID
    let item_key: Int?
    let item_name: String?
    let item_type: ContentItemFileType?
    let item_playtime: String?
    var maker: Int? // item_type이 4(애니메이션 퍼포먼스), 5(애니메이션 스티커)일때만 내려옴
    ///패키지 파일
    //let package_file: DownloadFile?
    ///LTE 파일 다운로드
    let hvr_dn_file: DownloadFile?
    ///중화질 파일 다운로드
    let hvr_m_file: DownloadFile?
    ///고화질 파일 다운로드
    let hvr_h_file: DownloadFile?
    ///초고화질 파일 다운로드
    let hvr_uh_file: DownloadFile?
    ///8i manifest
    let manifest_file: DownloadFile?
    ///wav file
    let sound_file: DownloadFile?
    ///gif file
    let gif_file: DownloadFile?

    ///iOS package file
    let ios_package_file: DownloadFile?

    ///자막 파일
    let subtitle_file: DownloadFile?

    /// main thumbnail
    let vimage_url: String?
    /// Mylist thumbnail
    let simage_url: String?
}

struct DownloadFile: Decodable {
    let url: String?
    let filesize: String?
}
