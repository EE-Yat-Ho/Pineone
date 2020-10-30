//
//  ContentFile.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/05/11.
//Copyright © 2020 최성욱. All rights reserved.
//

import Foundation
import Unrealm

struct RealmContentFile: Realmable {
    var item_key: Int?
    var item_name: String?
    var item_type: ContentItemFileType = .performance
    var item_playtime: String?
    var maker: Int?
    ///패키지 파일
    var ios_package_file: RealmDownloadFile?
    ///LTE 파일 다운로드 8i 콘텐츠
    var hvr_dn_file: RealmDownloadFile?
    ///중화질 파일 다운로드
    var hvr_m_file: RealmDownloadFile?
    ///고화질 파일 다운로드
    var hvr_h_file: RealmDownloadFile?
    ///초고화질 파일 다운로드
    var hvr_uh_file: RealmDownloadFile?
    ///8i manifest
    var manifest_file: RealmDownloadFile?
    ///wav file
    var sound_file: RealmDownloadFile?
    ///gif file
    var gif_file: RealmDownloadFile?

    var subtitle_file: RealmDownloadFile?

    /// main thumbnail
    var vimage_url: String?
    /// Mylist thumbnail
    var simage_url: String?

    static func primaryKey() -> String? {
        return "item_key"
    }

    func existFile() -> RealmDownloadFile? {
        if let ios_package_file = ios_package_file {
            return ios_package_file
        } else if let hvr_dn_file = hvr_dn_file {
            return hvr_dn_file
        } else if let hvr_m_file = hvr_m_file {
            return hvr_m_file
        } else if let hvr_h_file = hvr_h_file {
            return hvr_h_file
        } else if let hvr_uh_file = hvr_uh_file {
            return hvr_uh_file
        } else if let manifest_file = manifest_file {
            return manifest_file
        } else if let sound_file = sound_file {
            return sound_file
        } else if let subtitle_file = subtitle_file {
            return subtitle_file
        } else {
            return nil
        }
    }
}

extension RealmContentFile {
    init(_ item: ContentFiles) {
        self.item_key = item.item_key
        self.item_name = item.item_name
        self.item_type = item.item_type ?? .performance
        self.item_playtime = item.item_playtime
        self.maker = item.maker
        if let file = item.ios_package_file {
            self.ios_package_file = RealmDownloadFile(file)
        }
        if let file = item.hvr_dn_file {
            self.hvr_dn_file = RealmDownloadFile(file)
        }

        if let file = item.hvr_m_file {
            self.hvr_m_file = RealmDownloadFile(file)
        }

        if let file = item.hvr_h_file {
            self.hvr_h_file = RealmDownloadFile(file)
        }

        if let file = item.hvr_uh_file {
            self.hvr_uh_file = RealmDownloadFile(file)
        }

        if let file = item.manifest_file {
            self.manifest_file = RealmDownloadFile(file)
        }

        if let file = item.sound_file {
            self.sound_file = RealmDownloadFile(file)
        }

        if let file = item.gif_file {
            self.gif_file = RealmDownloadFile(file)
        }

        if let file = item.subtitle_file {
            self.subtitle_file = RealmDownloadFile(file)
        }

        self.vimage_url = item.vimage_url
        self.simage_url = item.simage_url
    }
}

struct RealmDownloadFile: Realmable {
    var url: String?
    var filesize: String?
    var resumeData: Data?
    var status: DownloadItemStatus = .ready
    var realPath: String?

    static func primaryKey() -> String? {
        return "url"
    }
}
extension RealmDownloadFile {
    init(_ item: DownloadFile?) {
        self.url = item?.url
        self.filesize = item?.filesize
    }
}
