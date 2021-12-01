//
//  SongCellFactory.swift
//  iOSArchitecturesDemo
//
//  Created by Крылов Данила  on 02.12.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

struct SongCellModel {
    let artistName: String?
    let songName: String?
    let albomImage: UIImage
}

final class SongCellModelFactory {

    static func createSongModel(song: ITunesSong) -> SongCellModel {

        let artistName = song.artistName
        let songName = song.trackName
        let urlForImage = URL(string: song.artwork ?? "")
        let dataImage = try? Data(contentsOf: urlForImage ?? URL(fileURLWithPath: ""))
        let albomImage = UIImage(data: dataImage ?? Data(), scale: 1.0)
        return SongCellModel(artistName: artistName,
                              songName: songName,
                              albomImage: albomImage ?? UIImage())
    }
}
