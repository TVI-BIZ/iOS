//
//  GitResponse.swift
//  Gist_View
//
//  Created by Vlad Tagunkov on 29/07/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import Foundation


struct GitResponse: Decodable {
    let items: [GistFile]?
}

struct GistFile: Decodable {
      let url: String?
      let forks_url: String?
      let commits_url: String?
    let id: String?
    let node_id: String?
    let git_pull_url: String?
    let git_push_url: String?
    let html_url: String?
    let created_at: String? //"created_at"
    let comments: Int?        //"comments"
    let description: String?

   
}


