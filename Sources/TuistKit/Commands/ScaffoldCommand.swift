import Foundation
import TuistSupport
import SPMUtility

// swiftlint:disable:next type_body_length
class ScaffoldCommand: NSObject, Command {
    // MARK: - Attributes

    static let command = "scaffold"
    static let overview = "Generates new project based on template."
    let listArgument: OptionArgument<Bool>

    // MARK: - Init

    public required init(parser: ArgumentParser) {
        let subParser = parser.add(subparser: ScaffoldCommand.command, overview: ScaffoldCommand.overview)
        listArgument = subParser.add(option: "--list",
                                     shortName: "-l",
                                     kind: Bool.self,
                                     usage: "Lists available scaffold templates",
                                     completion: nil)
    }
    
//    init(parser: ArgumentParser) {
//        let subParser = parser.add(subparser: ScaffoldCommand.command, overview: ScaffoldCommand.overview)
//        listArgument = subParser.add(option: "--list",
//                                     shortName: "-l",
//                                     kind: Bool.self,
//                                     usage: "Lists available scaffold templates",
//                                     completion: nil)
//    }

    func run(with arguments: ArgumentParser.Result) throws {
        let templatesDirectory = Environment.shared.versionsDirectory.appending(component: Constants.version)
    }
}