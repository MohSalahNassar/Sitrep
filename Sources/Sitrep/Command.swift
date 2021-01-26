//
//  Command.swift
//  ArgumentParser
//
//  Created by Yume on 2020/3/10.
//

import ArgumentParser
import Foundation
import SitrepCore

struct Command: ParsableCommand {
    @Option(name: .shortAndLong, help: "The report format \(Scan.ReportType.args).")
    var format: Scan.ReportType = .json
    
    @Option(name: [.short, .customLong("config")], help: "The path of `.sitrep.yml`.")
    var configurationPath: String?
    
    @Option(name: .shortAndLong, help: "The path of your project.")
    var path = FileManager.default.currentDirectoryPath
    
    func run() throws {
        let configurationPath = self.configurationPath ?? self.path + "/.sitrep.yml"
        let configuration = try Configuration.parse(configurationPath)
        print("""
            format: \(self.format.rawValue)
            path: \(path)
            configuration path: \(configurationPath)
            configuration: \(configuration)
            """)
        
        let url = URL(fileURLWithPath: path)
        let app = Scan(rootURL: url)
        app.run(reportType: self.format, configuration: configuration)
    }
}
