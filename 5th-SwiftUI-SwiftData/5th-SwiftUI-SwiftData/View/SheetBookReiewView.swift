//
//  SheetBookReiewView.swift
//  5th-SwiftUI-SwiftData
//
//  Created by 이유현 on 3/2/25.
//

import SwiftUI

struct SheetBookReiewView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var book: BookReivewModel? = nil
    
    var isNewBook: Bool {
        self.book == nil ? true : false
    }
    
    @Binding var showSheet: Bool
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var review: String = ""
    
    var body: some View {
        VStack(spacing : 0){
            Text(isNewBook ? "독서 기록장 추가하기" : "독서 기록장 수정하기")
                .font(.title2).bold()
                .padding(.top, 20)
            
            TextField("책 제목을 입력해주세요", text: $title)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            TextField("책 저자를 입력해주세요", text: $author)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            TextField("책 리뷰를 입력해주세요", text: $review)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button(action:{
                
                if isNewBook {
                    //Add
                    let newBook = BookReivewModel(title: title, author: author, review: review)
                    //추가해
                } else {
                    //Update
                    book?.title = title
                    book?.author = author
                    book?.review = review
                }
                
                dismiss()
                
            }){
                Text("확인")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Spacer()
                
        } // : VStack
        .task {
            if let book {
                title = book.title
                author = book.author
                review = book.review
            }
        }
    }
}

#Preview {
    SheetBookReiewView(showSheet: .constant(false))
        .modelContainer(BookReivewModel.previewData)
}
