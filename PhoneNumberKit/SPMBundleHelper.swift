//
//  SPMBundleHelper.swift
//  PhoneNumberKit
//
//  Created by Bain Kennedy on 7/9/21.
//  Copyright © 2021 Roy Marmelstein. All rights reserved.
//

import Foundation


private class CurrentBundleFinder {}

/// Picked this trick up from a StackOverflow Article, no longer have the link
extension Foundation.Bundle {

    static var myModule: Bundle = {

        // Need to discover a more eloquent way todo this.
        let bundleName = "PhoneNumberKit_PhoneNumberKit"
        let localBundleName = "LocalPackages_PhoneNumberKit"

        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: CurrentBundleFinder.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL,

            // Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/").
            Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
            Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }

            let localBundlePath = candidate?.appendingPathComponent(localBundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
            
            // Last ditch effort.
            return .module
        }

        fatalError("unable to find bundle")

    }()

}
