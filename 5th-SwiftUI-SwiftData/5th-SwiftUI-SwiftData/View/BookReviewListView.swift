//
//  BookReviewListView.swift
//  5th-SwiftUI-SwiftData
//
//  Created by 이유현 on 3/2/25.
//

import SwiftUI
import SwiftData

struct BookReviewListView: View {
    @Environment(\.modelContext) private var modelContext
    // @Query 를 통해 View <-> Context 직접 연결
    @Query private var bookReviewList : [BookReivewModel]
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing:0){
                List{
                    ForEach(bookReviewList){ book in
                        ZStack(alignment: .leading){
                            RowView(book: book)
                            NavigationLink {
                                SheetBookReiewView(
                                    book: book,
                                    showSheet: $showSheet)
                            } label: {
                                EmptyView()
                            } // : NavigationLink
                            .opacity(0.0)
                        } // ZStack
                    } // : ForEach
                } // : List
            } // : VStack
            .navigationTitle("독서 기록장")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: addBookReivewButton)
            .sheet(isPresented: $showSheet) {
                SheetBookReiewView(showSheet: $showSheet)
            }
        } // : NavigationStack
    }
    
    private var addBookReivewButton: some View {
        Button(action:{
            showSheet = true
        }){
            Text("추가")
        }
    }
}

struct RowView : View {
    @Environment(\.modelContext) private var modelContext
    
    let book: BookReivewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(spacing: 10){
                Text(book.title)
                    .font(.title2).bold()
                
                Text(book.author)
                    .font(.body)
                
            } // : HStack
            
            Text(book.review)
                .font(.callout)
            
        } // :VStack
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
                // delete 구현
                //추가해
            } label: {
                Text("삭제")
            }
            .tint(.red)
        } // : swipeActions
    }
}

#Preview {
    BookReviewListView()
        .modelContainer(BookReivewModel.previewData)
}
