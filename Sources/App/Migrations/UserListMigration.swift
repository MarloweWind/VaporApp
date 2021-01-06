//
//  File.swift
//  
//
//  Created by Алексей Мальков on 05.01.2021.
//

import Fluent

extension UserList: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("userList")
            .id()
            .field("username", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("userList").delete()
    }
}
