//
//  IconCreator.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

/// Reads parameters from the user and creates icons based on the specified platform.
struct IconCreator {
    private var args: [String]
    
    
    /// Initializes the struct with the launch arguments.
    /// - Parameter args: The arguments passed when executing the code.
    init(args: [String]) {
        self.args = args
    }
    
    /// Initializes the application, considers the arguments, and creates the icons.
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

        if (args.count > 3 && args[3] == "scaled") {
            await createScaled(platform: args[1].platform)
        } else {
            await create(platform: args[1].platform)
        }
    }

    private func create(platform: Platform) async {
        Traits.shared.theme = await ThemeFetcher(platform: platform).fetch()
        let iconBackground = IconBackground()
        let iconForeground = IconForeground()
        let androidIconsCreator = AndroidIconsCreator(iconBackground: iconBackground, iconForeground: iconForeground)
        var iosIconsCreator = iOSIconsCreator(iconBackground: iconBackground, iconForeground: iconForeground)
        shell("mkdir -p \(MainTraits.shared.outputFolder)")
        switch(platform) {
            case .android: androidIconsCreator.createAllIcons()
            case .iOS: iosIconsCreator.createAllIcons()
        }
    }

    private func createScaled(platform: Platform) async {
        Traits.shared.theme = await ThemeFetcher(platform: platform).fetch()
        let iconBackground = IconBackground()
        let iconForeground = IconForeground()
        let androidIconsCreator = AndroidIconsCreator(iconBackground: iconBackground, iconForeground: iconForeground)
        var iosIconsCreator = iOSIconsCreator(iconBackground: iconBackground, iconForeground: iconForeground)
        shell("mkdir -p \(MainTraits.shared.outputFolder)")
        switch(platform) {
            case .android: androidIconsCreator.createAllIconsScaled()
            case .iOS: iosIconsCreator.createAllIcons()
        }
    }
}
