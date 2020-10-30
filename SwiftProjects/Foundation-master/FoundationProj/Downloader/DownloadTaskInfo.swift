//
//  DownloadTaskInfo.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/08/10.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Foundation
import Unrealm

enum DownloadItemStatus: String, RealmableEnumString, Decodable {
    case ready = "status_ready"
    case downloading = "status_downloading"
    case paused = "status_paused"
    case failed = "status_failed"
    case cancle = "status_cancle"
    case completed = "status_completed"
}

class DownloadTaskInfo: NSObject {
    var contentKey: Int
//    var completionBlock: DownloadManager.DownloadCompletionBlock
//    var progressBlock: DownloadManager.DownloadProgressBlock?
    var fileManager: FileManager!
    var downloadTask: URLSessionDownloadTask
    var readByte = Int64()
    var progress = CGFloat()
    var downloadSize = Float()
    var currentTaskInfoIndex: Int = 0
    var currentContentFileIndex: Int = 0
    var totalContentFileCount: Int = 0
    var allDownloadFilesByte: Int64 = 0
    var downloadItems: [Int: [DownloadItem]] = [:]
    var downloadType: DownloadType

    init(contentKey: Int,
         downloadType: DownloadType,
         downloadItems: [Int: [DownloadItem]],
         allDownloadFilesByte: Int64,
         downloadTask: URLSessionDownloadTask) {
//         progressBlock: DownloadManager.DownloadProgressBlock?,
//         completionBlock: @escaping DownloadManager.DownloadCompletionBlock) {
        self.downloadType = downloadType
        self.contentKey = contentKey
        self.downloadItems = downloadItems
        self.allDownloadFilesByte = allDownloadFilesByte
        self.downloadTask = downloadTask
//        self.completionBlock = completionBlock
//        self.progressBlock = progressBlock
        self.fileManager = FileManager.default
    }
}

struct DownloadItem {
    var url: URL
    var status: DownloadItemStatus = .ready
    var resumeData: Data?
}
