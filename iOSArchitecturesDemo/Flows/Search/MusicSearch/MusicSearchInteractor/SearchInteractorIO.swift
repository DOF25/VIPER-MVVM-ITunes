//
//  SearchInteractorIO.swift
//  iOSArchitecturesDemo
//
//  Created by Крылов Данила  on 02.12.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

protocol SearchInteractorInput: AnyObject {

    func requestSongs(with query: String)
}

protocol SearchInteractorOutput: AnyObject {

    func receivedSongs(_ songs: [ITunesSong])
    func receivedError(_ error: Error)
}
