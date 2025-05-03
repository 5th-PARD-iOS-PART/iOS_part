//
//  _th_SwiftUI_SwiftDataApp.swift
//  5th-SwiftUI-SwiftData
//
//  Created by 이유현 on 3/2/25.
//

import SwiftUI
import SwiftData

@main
struct _th_SwiftUI_SwiftDataApp: App {
    
    var modelContainer: ModelContainer = {
        
        // 1. Schema 생성
        let schema = Schema([BookReivewModel.self])
        
        // 2. Model 관리 규칙을 위한 ModelConfiguration 생성
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        // 3. ModelContainer 생성
        do {
            let container = try ModelContainer(for: schema, configurations: [configuration])
            return container
        } catch {
            fatalError("ModelContainer 생성 실패!!!: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            BookReviewListView()
        }
        // 전역적으로 사용할 영구 데이터이기 때문에, WindowGroup에 주입!
        .modelContainer(modelContainer)
    }
}
