//
//  MyDownloadFile.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/05/11.
//Copyright © 2020 최성욱. All rights reserved.
//

import Foundation
import Unrealm

struct RealmMyDownloadFile: Realmable {
    // Specify properties to ignore (Realm won't persist these)
    var key: String = .empty
    var name: String?
    var desc: String?
    var type: ContentType = .performance
    var image_url: String?
    var artist: String?
    var replyCnt: Int?
    var type_badge_url: String?
    var event_badge_url: String?
    var start_dt: Double?
    var end_dt: Double?

    var view_cnt: Int?
    var like_cnt: Int?
    var reply_cnt: Int?

    var detail_desc: String?
    var my_image_url: String?
    //var files: [RealmContentFile]?
    var still_image_url: [String]?
    var like_yn: ContenLikeType = .n
    var guest_permit_yn: OtherCompaniesPermitContents = .N
    var adult_yn: AdultType = .N

    var play_time: String?

    var allDownloadFilesByte: Int64 = 0
    var currentDownloadFilesByte: Int64 = 0
    var downloadSize: Float = 0
    var downloadStatus: DownloadItemStatus = .ready
    var createDate: Date?

    var assetBundle: String?
    var wavePath: String?
    var hvrPath: String?
//    var game_info: RealmGameInfo?
//    var deco_info: RealmDecoInfo?
//    var player_option: RealmPlayerOption?
    var vimage_url: String?
    var simage_url: String?

    var downloadable: Contain3DContentType = .N

    static func primaryKey() -> String? {
        return "key"
    }

    func getDownLoadList() -> [Int: [RealmDownloadFile]] {
        
        
        let downloadList: [Int: [RealmDownloadFile]] = [
            0 : [RealmDownloadFile(url: "test", filesize: "test", resumeData: Data(), status: .ready, realPath: "test")]
        ]
        
        return downloadList
        //guard let files = self.files, files.count > 0 else { return downloadList }
//        if type == .performance {
//            var list: [RealmDownloadFile] = []
//            if let firstFile = files.first, let itemKey = firstFile.item_key {
//                if let file = firstFile.hvr_dn_file, let _ = file.url {
//                    list.append(file)
//                }
//                if let file = firstFile.ios_package_file, let _ = file.url {
//                    list.append(file)
//                }
//                if let file = firstFile.sound_file, let _ = file.url {
//                    list.append(file)
//                }
//                if let file = firstFile.subtitle_file, let _ = file.url {
//                    list.append(file)
//                }
//                downloadList[itemKey] = list
//            }
//        } else {
//            for file in files {
//                var list: [RealmDownloadFile] = []
//                if let itemKey = file.item_key {
//                    if let file = file.hvr_dn_file, let _ = file.url {
//                        list.append(file)
//                    }
//                    if let file = file.ios_package_file, let _ = file.url {
//                        list.append(file)
//                    }
//                    if let file = file.sound_file, let _ = file.url {
//                        list.append(file)
//                    }
//                    if let file = file.subtitle_file, let _ = file.url {
//                        list.append(file)
//                    }
//                    downloadList[itemKey] = list
//                }
//            }
//        }
//        return downloadList
    }
}
//
//extension RealmMyDownloadFile {
//    init(_ item: ContentItem) {
//        self.key = String(item.key ?? -1)
//        self.name = item.name
//        self.desc = item.desc
//        self.type = item.type ?? .performance
//        self.image_url = item.image_url
//        self.artist = item.artist
//        self.replyCnt = item.sb_info?.reply_cnt
//        self.type_badge_url = item.type_badge_url
//        self.event_badge_url = item.event_badge_url
//        self.start_dt = item.start_dt
//        self.end_dt = item.end_dt
//
//        self.view_cnt = item.sb_info?.view_cnt
//        self.like_cnt = item.sb_info?.like_cnt
//        self.reply_cnt = item.sb_info?.reply_cnt
//        self.detail_desc = item.detail_desc
//        self.my_image_url = item.my_image_url
//
//        self.play_time = item.play_time
//
//        self.like_yn = item.like_yn ?? .n
//        self.guest_permit_yn = item.guest_permit_yn ?? .N
//        self.allDownloadFilesByte = item.totalByte
//        self.adult_yn = item.adult_yn ?? .N
//
//        self.vimage_url = item.vimage_url
//        self.simage_url = item.simage_url
//
//        self.downloadable = item.downloadable ?? .N
//
//        var realmFiles: [RealmContentFile] = []
//        if let files = item.files {
//            for file in files {
//                realmFiles.append(RealmContentFile(file))
//            }
//        }
//
//        self.currentDownloadFilesByte = 0
//        self.files = realmFiles//RealmContentFile(item.files ?? [])
//        self.downloadStatus = .ready
//        self.createDate = Date()
//
//        self.game_info = RealmGameInfo(item)
//        self.deco_info = RealmDecoInfo(item)
//        self.player_option = RealmPlayerOption(item)
//    }
//}
//
//struct RealmGameInfo: Realmable {
//    var game_path: String?
//    var prod_date: String?
//    var filesize: String?
//    var package_name: String?
//    var app_id: String?
//    var class_name: String?
//    var scheme_name: String?
//    var version: String?
//
//    static func primaryKey() -> String? {
//        return "game_path"
//    }
//}
//
//extension RealmGameInfo {
//    init(_ item: ContentItem) {
//        self.game_path = item.game_info?.game_path
//        self.prod_date = item.game_info?.prod_date
//        self.filesize = item.game_info?.filesize
//        self.package_name = item.game_info?.package_name
//        self.app_id = item.game_info?.app_id
//        self.class_name = item.game_info?.class_name
//        self.scheme_name = item.game_info?.scheme_name
//        self.version = item.game_info?.version
//    }
//}
//
//struct RealmDecoInfo: Realmable {
//    var deco_key: Int?
//    var name: String?
//    var type: DecoFileType = .unknown
//    var thumb_url: String?
//    var file_url: String?
//
//    static func primaryKey() -> String? {
//        return "deco_key"
//    }
//}
//
//extension RealmDecoInfo {
//    init(_ item: ContentItem) {
//        self.deco_key = item.deco_info?.deco_key
//        self.name = item.deco_info?.name
//        self.type = item.deco_info?.type ?? .unknown
//        self.thumb_url = item.deco_info?.thumb_url
//        self.file_url = item.deco_info?.file_url
//    }
//}
//
//struct RealmPlayerOption: Realmable {
//    var cam_onoff: CameraOnOffType = .unknown
//    var cam_direction: CameraDirectionType = .unknown
//    var background: BackgroundType = .unknown
//    var base_fix: BaseFixType = .unknown
//
//    static func primaryKey() -> String? {
//        return "cam_onoff"
//    }
//}
//
//extension RealmPlayerOption {
//    init(_ item: ContentItem) {
//        self.cam_onoff = item.player_option?.cam_onoff ?? .unknown
//        self.cam_direction = item.player_option?.cam_direction ?? .unknown
//        self.background = item.player_option?.background ?? .unknown
//        self.base_fix = item.player_option?.base_fix ?? .unknown
//    }
//}
