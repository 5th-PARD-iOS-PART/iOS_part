//
//  BookReivewModel.swift
//  5th-SwiftUI-SwiftData
//
//  Created by 이유현 on 3/2/25.
//

import Foundation
import SwiftData

@Model
class BookReivewModel {
    var title : String
    var author : String
    var review : String
    
    init(title: String, author: String, review: String) {
        self.title = title
        self.author = author
        self.review = review
    }
}

// preivew에 보여줄 데이터 설정
extension BookReivewModel {
    // 1. ModelContainer 생성
    @MainActor
    static var previewData: ModelContainer {
        let container : ModelContainer
        
        do{
            container =  try ModelContainer(for: BookReivewModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            //isStoredInMemoryOnly 경우는 preview에서만 사용될것이기 때문에 mock data를 영구데이터가 아니라 memory 상에서만 임시 저장
        }
        catch {
            fatalError("failed to create container : \(error)")
        }
        
        //2. data 생성
        let titles = ["위대한 개츠비", "오만과 편견", "멋진 신세계", "1984"]
        let authors = ["스콧", "제인 오스틴","올더스 헉슬리", "조지 오웰"]
        let reviews = ["개츠비는 위대하다", "오만이랑 편견이 사귐", "신세계는 멋지다", "심도깊은 내용이다"]
        
        //5개의 random mockdata 반복문으로 생성
        for i in 0..<3 {
            let newBookReview = BookReivewModel(title: titles[i], author: authors[i], review: reviews[i])
    
            // 3. data를 container에 저장 (집어넣기)
            container.mainContext.insert(newBookReview)
            
            
        }
        
        return container
    }
}
