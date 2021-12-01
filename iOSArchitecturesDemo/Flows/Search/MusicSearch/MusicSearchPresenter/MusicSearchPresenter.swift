//
//  MusicSearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Крылов Данила  on 02.12.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

final class MusicSearchPresenter {

    var interactor: SearchInteractorInput!
    weak var view: MusicSearchViewInput!

    var songs: [ITunesSong] = []

}

//MARK: - MusicSearchViewOutput

extension MusicSearchPresenter: MusicSearchViewOutput {

    func viewDidSearch(with query: String) {
        self.view.throbber(show: true)
        self.interactor.requestSongs(with: query)
    }

}

extension MusicSearchPresenter: SearchInteractorOutput {

    func receivedSongs(_ songs: [ITunesSong]) {
        self.view.throbber(show: false)

        self.songs = songs

        if songs.isEmpty {
            self.view.showNoResults()
        } else {
            self.view.hideNoResults()
        }

        let models = songs.map { SongCellModelFactory.createSongModel(song: $0) }
        self.view.setModels(models)
    }

    func receivedError(_ error: Error) {
        self.view.throbber(show: false)
        self.view.showNoResults()
    }
}
