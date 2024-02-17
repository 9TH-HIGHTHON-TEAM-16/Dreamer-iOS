import ProjectDescriptionHelpers
import ProjectDescription

let project = Project.excutable(
    name: "App",
    platform: .iOS,
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    dependencies: []
)
