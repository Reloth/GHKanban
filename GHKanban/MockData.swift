//
//  MockData.swift
//  GHKanban
//
//  Created by Diego on 30/10/21.
//

import Foundation

/// Mock data so the app can display something before the API calls are implemented.
var mockRepos: [Repository] = [
    Repository(repoName: "First repo", repoAuthor: "Diego", repoIssues: [
        Issue(issueTitle: "R1_01", issueInformation: "App crashes on load", issuePosition: .doing),
        Issue(issueTitle: "R1_02", issueInformation: "Ugly colors", issuePosition: .backlog),
        Issue(issueTitle: "R1_03", issueInformation: "Login is slow", issuePosition: .next),
        Issue(issueTitle: "R1_04", issueInformation: "Unable to register new user", issuePosition: .doing),
        Issue(issueTitle: "R1_05", issueInformation: "User not found error", issuePosition: .done)
    ]),
    Repository(repoName: "Second repo", repoAuthor: "Diego", repoIssues: [
        Issue(issueTitle: "R2_01", issueInformation: "App crashes on load", issuePosition: .doing),
        Issue(issueTitle: "R2_02", issueInformation: "Ugly colors", issuePosition: .backlog),
        Issue(issueTitle: "R2_03", issueInformation: "Login is slow", issuePosition: .next),
        Issue(issueTitle: "R2_04", issueInformation: "Unable to register new user", issuePosition: .doing),
        Issue(issueTitle: "R2_05", issueInformation: "User not found error", issuePosition: .done)
    ]),
    Repository(repoName: "Third repo", repoAuthor: "Inqbarna", repoIssues: [
        Issue(issueTitle: "R3_01", issueInformation: "App crashes on load", issuePosition: .doing),
        Issue(issueTitle: "R3_02", issueInformation: "Ugly colors", issuePosition: .backlog),
        Issue(issueTitle: "R3_03", issueInformation: "Login is slow", issuePosition: .next),
        Issue(issueTitle: "R3_04", issueInformation: "Unable to register new user", issuePosition: .doing),
        Issue(issueTitle: "R3_05", issueInformation: "User not found error", issuePosition: .done)
    ]),
    Repository(repoName: "Fourth repo", repoAuthor: "Inqbarna", repoIssues: [
        Issue(issueTitle: "R4_01", issueInformation: "App crashes on load", issuePosition: .doing),
        Issue(issueTitle: "R4_02", issueInformation: "Ugly colors", issuePosition: .backlog),
        Issue(issueTitle: "R4_03", issueInformation: "Login is slow", issuePosition: .next),
        Issue(issueTitle: "R4_04", issueInformation: "Unable to register new user", issuePosition: .doing),
        Issue(issueTitle: "R4_05", issueInformation: "User not found error", issuePosition: .done)
    ]),
]
