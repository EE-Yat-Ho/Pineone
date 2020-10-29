//
//  Server.swift
//  FoundationProj
//
//  Created by 박영호 on 2020/10/19.
//  Copyright © 2020 baedy. All rights reserved.
//

import UIKit
import RxSwift

struct RealmLocalDB {
    static var shared = RealmLocalDB()
    
    /// 현재 DB가 가진 데이터
    private var DownloadFiles = [
        RealmMyDownloadFile(key: "0", name: "test", desc: "test", type: .iosInstallGame, image_url: "test", artist: "test", replyCnt: 1, type_badge_url: "test", event_badge_url: "test", start_dt: 0, end_dt: 200000000000000000, view_cnt: 2, like_cnt: 3, reply_cnt: 4, detail_desc: "test", my_image_url: "test", still_image_url: ["test"], like_yn: .y, guest_permit_yn: .Y, adult_yn: .Y, play_time: "test", allDownloadFilesByte: 100, currentDownloadFilesByte: 50, downloadSize: 200, downloadStatus: .ready, createDate: nil, assetBundle: "test", wavePath: "test", hvrPath: "test", vimage_url: "test", simage_url: "test", downloadable: .Y),
        RealmMyDownloadFile(key: "1", name: "test", desc: "test", type: .iosInstallGame, image_url: "test", artist: "test", replyCnt: 1, type_badge_url: "test", event_badge_url: "test", start_dt: 0, end_dt: 200000000000000000, view_cnt: 2, like_cnt: 3, reply_cnt: 4, detail_desc: "test", my_image_url: "test", still_image_url: ["test"], like_yn: .y, guest_permit_yn: .Y, adult_yn: .Y, play_time: "test", allDownloadFilesByte: 100, currentDownloadFilesByte: 50, downloadSize: 200, downloadStatus: .ready, createDate: nil, assetBundle: "test", wavePath: "test", hvrPath: "test", vimage_url: "test", simage_url: "test", downloadable: .Y),
        RealmMyDownloadFile(key: "2", name: "test", desc: "test", type: .iosInstallGame, image_url: "test", artist: "test", replyCnt: 1, type_badge_url: "test", event_badge_url: "test", start_dt: 0, end_dt: 200000000000000000, view_cnt: 2, like_cnt: 3, reply_cnt: 4, detail_desc: "test", my_image_url: "test", still_image_url: ["test"], like_yn: .y, guest_permit_yn: .Y, adult_yn: .Y, play_time: "test", allDownloadFilesByte: 100, currentDownloadFilesByte: 50, downloadSize: 200, downloadStatus: .ready, createDate: nil, assetBundle: "test", wavePath: "test", hvrPath: "test", vimage_url: "test", simage_url: "test", downloadable: .Y)
    ]
    /// 현재 서버가 가진 데이터를 반환
    func getUserDownloadContents() -> [RealmMyDownloadFile] {
        return DownloadFiles 
    }
    
    /// 원하는 데이터를 삭제
    mutating func deleteDownloadContents(indexPathString: String) {
        let splitedIndexPathString = indexPathString.split(separator: ",").map(String.init) // "1", "2"
        let keys = splitedIndexPathString.map({
            (string:String) -> String in
                if let index = Int(string) {
                    return DownloadFiles[index].key
                }
                return ""
            })
        DownloadFiles = DownloadFiles.filter{!keys.contains($0.key)}
    }
    
}
