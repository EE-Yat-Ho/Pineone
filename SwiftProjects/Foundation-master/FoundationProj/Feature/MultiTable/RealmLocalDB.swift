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
    
    /// 처음에 디비 데이터 세팅하기!
    mutating func setDBData(dataAmount: Int) {
        for i in 0..<dataAmount {
            DownloadFiles.append(RealmMyDownloadFile(key: String(i), name: "다운"+String(i), desc: "test", type: .iosInstallGame, image_url: "test", artist: "test", replyCnt: i, type_badge_url: "test", event_badge_url: "test", start_dt: Double(i), end_dt: 200000000000000000 - Double(i), view_cnt: i * 2, like_cnt: i * 3, reply_cnt: i * 4, detail_desc: "test", my_image_url: "test", still_image_url: ["test"], like_yn: i % 2 == 0 ? .y : .n, guest_permit_yn: i % 2 == 0 ? .Y : .N, adult_yn: i % 2 == 0 ? .N : .Y, play_time: "test", allDownloadFilesByte: Int64(1000000 - i * 2000), currentDownloadFilesByte: Int64(i * 2000), downloadSize: Float(i * 3000), downloadStatus: i % 2 == 0 ? .ready : .downloading, createDate: Date(timeIntervalSince1970: TimeInterval(i * 1000)), assetBundle: "test", wavePath: "test", hvrPath: "test", vimage_url: "test", simage_url: "test", downloadable: i % 2 == 0 ? .Y : .N))
        }
    }
    
    /// 현재 디비가 가진 데이터를 반환
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
    
    /// 현재 DB가 가진 데이터
    private var DownloadFiles: [RealmMyDownloadFile] = [
//        RealmMyDownloadFile(key: "0", name: "다운0", desc: "test0", type: .iosInstallGame, image_url: "test0", artist: "test0", replyCnt: 1, type_badge_url: "test0", event_badge_url: "test0", start_dt: 0, end_dt: 200000000000000000, view_cnt: 2, like_cnt: 3, reply_cnt: 4, detail_desc: "test0", my_image_url: "test0", still_image_url: ["test0"], like_yn: .y, guest_permit_yn: .Y, adult_yn: .N, play_time: "test0", allDownloadFilesByte: 1000000, currentDownloadFilesByte: 0, downloadSize: 200, downloadStatus: .ready, createDate: Date(timeIntervalSince1970: 0), assetBundle: "test0", wavePath: "test", hvrPath: "test0", vimage_url: "test0", simage_url: "test0", downloadable: .Y),
//        RealmMyDownloadFile(key: "1", name: "다운1", desc: "test1", type: .iosInstallGame, image_url: "test1", artist: "test1", replyCnt: 1, type_badge_url: "test1", event_badge_url: "test1", start_dt: 0, end_dt: 200000000000000000, view_cnt: 2, like_cnt: 3, reply_cnt: 4, detail_desc: "test1", my_image_url: "test1", still_image_url: ["test1"], like_yn: .y, guest_permit_yn: .Y, adult_yn: .Y, play_time: "test1", allDownloadFilesByte: 900000, currentDownloadFilesByte: 1, downloadSize: 200, downloadStatus: .ready, createDate: Date(timeIntervalSince1970: 1), assetBundle: "test1", wavePath: "test1", hvrPath: "test1", vimage_url: "test1", simage_url: "test1", downloadable: .Y),
//        RealmMyDownloadFile(key: "2", name: "다운2", desc: "test2", type: .iosInstallGame, image_url: "test2", artist: "test2", replyCnt: 1, type_badge_url: "test2", event_badge_url: "test2", start_dt: 0, end_dt: 200000000000000000, view_cnt: 2, like_cnt: 3, reply_cnt: 4, detail_desc: "test2", my_image_url: "test2", still_image_url: ["test2"], like_yn: .y, guest_permit_yn: .Y, adult_yn: .N, play_time: "test2", allDownloadFilesByte: 800000, currentDownloadFilesByte: 2, downloadSize: 200, downloadStatus: .ready, createDate: Date(timeIntervalSince1970: 2), assetBundle: "test2", wavePath: "test2", hvrPath: "test2", vimage_url: "test2", simage_url: "test2", downloadable: .Y)
    ]
}
