//
//  IconCreator.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

struct IconCreator {
    var args: [String]

    func run() async {
        if (args.count < 1) {
            print("Needs an argument: \'android\' or \'ios\'")
            return
        } else if (!["android", "ios"].contains(args[1])) {
            print("Arguments accepted: \'android\' or \'ios\'")
            return
        }

        await create(platform: args[1].platform)
    }

    private func create(platform: Platform) async {
        Traits.shared.theme = await ThemeFetcher(platform: platform).fetch()
        let background = IconBackground()
        let foreground = IconForeground()
        let androidIconsCreator = AndroidIconsCreator(background: background, foreground: foreground)
        var iosIconsCreator = iOSIconsCreator(background: background, foreground: foreground)
        shell("mkdir -p \(MainTraits.shared.outputFolder)")
        switch(platform) {
            case .android: androidIconsCreator.createAllIcons()
            case .iOS: iosIconsCreator.createAllIcons()
        }
    }
}
