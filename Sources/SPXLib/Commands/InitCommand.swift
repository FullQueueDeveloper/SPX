import Foundation

final class InitCommand {

  let announcer: Announcer?, spxDir: String
  init(announcer: Announcer?, spxDir: String) {
    self.announcer = announcer
    self.spxDir = spxDir
  }

  func exec(arguments: Array<String>) throws {
    if arguments.count < 1 {
      throw Errors.templateNameMissing
    }

    guard let template  = Templates(rawValue: arguments[0]) else {
      throw Errors.noTemplate(named: arguments[0])
    }

    try self.exec(template: template)
  }

  func exec(template: Templates) throws {
    announcer?.scaffolding(template: template, path: ".")

    for file in template.files {
      let fullPath = try file.create(in: ".")
      announcer?.fileCreated(path: fullPath)
    }
  }

  enum Errors: Error {
    case templateNameMissing
    case noTemplate(named: String)
  }
}
