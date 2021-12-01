//
//  MusicSearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Крылов Данила  on 02.12.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation
import Alamofire

final class MusicSearchInteractor: SearchInteractorInput {

    private let searchService = ITunesSearchService()

    weak var output: SearchInteractorOutput!

//MARK: - SearchInteractorInput

    func requestSongs(with query: String) {
        self.searchService.getSongs(forQuery: query) { [ weak self ] result in
            guard let self = self else { return }
            result
                .withValue { songs in
                    self.output.receivedSongs(songs)
                }
                .withError { error in
                    self.output.receivedError(error)
                }
        }
    }


}
