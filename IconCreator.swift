//
//  IconCreator.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

struct IconCreator {
    var args: [String]

    func run() async {
        if (args.count < 3) {
            print("usage:")
            print("\(CommandLine.arguments[0]) android /path/to/project/directory/from/library/root/folder")
            print("\(CommandLine.arguments[0]) ios /path/to/app/directory/from/library/root/folder")
            return
        } else if (!["android", "ios"].contains(args[1])) {
            print("Arguments accepted: \'android\' or \'ios\'")
            return
        }

        await create(platform: args[1].platform)
    }

    private func create(platform: Platform) async {
        Traits.shared.theme = await ThemeFetcher(platform: platform).fetch()
        let iconBackground = IconBackground()
        let foreground = IconForeground()
        let androidIconsCreator = AndroidIconsCreator(iconBackground: iconBackground, foreground: foreground)
        var iosIconsCreator = iOSIconsCreator(iconBackground: iconBackground, foreground: foreground)
        shell("mkdir -p \(MainTraits.shared.outputFolder)")
        switch(platform) {
            case .android: androidIconsCreator.createAllIcons()
            case .iOS: iosIconsCreator.createAllIcons()
        }
    }
}
