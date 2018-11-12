//
//  Repository.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import Foundation
import UIKit

public struct Repository: Decodable {
    public let total_count: Int?
    public let incomplete_results: Bool?
    public let items: [RepositoryItem]?
}

public struct RepositoryItem: Decodable {
    public let id: Int?
    public let node_id: String?
    public let name: String?
    public let full_name: String?
    public let `private`: Bool?
    public let owner: RepositoryPersonal?
    public let html_url: String?
    public let description: String?
    public let fork: Bool?
    public let url: String?
    public let forks_url: String?
    public let keys_url: String?
    public let collaborators_url: String?
    public let teams_url: String?
    public let hooks_url: String?
    public let issue_events_url: String?
    public let events_url: String?
    public let assignees_url: String?
    public let branches_url: String?
    public let tags_url: String?
    public let blobs_url: String?
    public let git_tags_url: String?
    public let git_refs_url: String?
    public let trees_url: String?
    public let statuses_url: String?
    public let languages_url: String?
    public let stargazers_url: String?
    public let contributors_url: String?
    public let subscribers_url: String?
    public let subscription_url: String?
    public let commits_url: String?
    public let git_commits_url: String?
    public let comments_url: String?
    public let issue_comment_url: String?
    public let contents_url: String?
    public let compare_url: String?
    public let merges_url: String?
    public let archive_url: String?
    public let downloads_url: String?
    public let issues_url: String?
    public let pulls_url: String?
    public let milestones_url: String?
    public let notifications_url: String?
    public let labels_url: String?
    public let releases_url: String?
    public let deployments_url: String?
    public let created_at: String?
    public let updated_at: String?
    public let pushed_at: String?
    public let git_url: String?
    public let ssh_url: String?
    public let clone_url: String?
    public let svn_url: String?
    public let homepage: String?
    public let size: Int?
    public let stargazers_count: Int?
    public let watchers_count: Int?
    public let language: String?
    public let has_issues: Bool?
    public let has_projects: Bool?
    public let has_downloads: Bool?
    public let has_wiki: Bool?
    public let has_pages: Bool?
    public let forks_count: Int?
    public let mirror_url: String?
    public let archived: Bool?
    public let open_issues_count: Int?
    public let license: RepositoryLicense?
    public let forks: Int?
    public let open_issues: Int?
    public let watchers: Int?
    public let default_branch: String?
    public let score: Double?
}

public struct RepositoryPersonal: Decodable {
    public let login: String?
    public let id: Int?
    public let node_id: String?
    public let avatar_url: String?
    public let gravatar_id: String?
    public let url: String?
    public let html_url: String?
    public let followers_url: String?
    public let following_url: String?
    public let gists_url: String?
    public let starred_url: String?
    public let subscriptions_url: String?
    public let organizations_url: String?
    public let repos_url: String?
    public let events_url: String?
    public let received_events_url: String?
    public let type: String?
    public let site_admin: Bool?
}

public struct RepositoryLicense: Decodable {
    public let key: String?
    public let name: String?
    public let spdx_id: String?
    public let url: String?
    public let node_id: String?
}
