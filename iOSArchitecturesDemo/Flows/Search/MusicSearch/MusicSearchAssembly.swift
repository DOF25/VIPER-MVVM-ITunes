//
//  MusicSearchAssembly.swift
//  iOSArchitecturesDemo
//
//  Created by Крылов Данила  on 02.12.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class MusicSearchAssembly {

    static func make() -> MusicSearchController {

        let viewController = MusicSearchController()
        let interactor = MusicSearchInteractor()
        let presenter = MusicSearchPresenter()

        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        interactor.output = presenter

        return viewController
    }
}
