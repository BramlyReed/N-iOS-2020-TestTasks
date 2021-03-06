import Foundation

/**
 - No database or any other storage is required, just store data in memory
 - No any smart search, use String method contains (case sensitive/insensitive - does not matter)
 –   Performance optimizations are optional
 */

struct Book {
    let id: String; // unique identifier
    let name: String;
    let author: String;
}

class Library {
    
    var books : [Book] = []
    
    /**
     Adds a new book object to the Library.
     - Parameter book: book to add to the Library
     - Returns: false if the book with same id already exists in the Library, true – otherwise.
     */
    func addNewBook(book: Book) -> Bool {
        if !(books.isEmpty){
            for count in books{
                if count.id == book.id{
                    return false
                }
            }
        }
        books.append(book)
        return true
    }
    
    /**
     Deletes the book with the specified id from the Library.
     - Returns: true if the book with same id existed in the Library, false – otherwise.
     */
    func deleteBook(id: String) -> Bool {
        var index = 0
        if !(books.isEmpty){
            for count in books{
                if count.id == id{
                    books.remove(at:index)
                    return true
                }
                index = index + 1
            }
        }
        return false
    }
    
    /**
     - Returns: 10 book names containing the specified string. If there are several books with the same name, author's name is appended to book's name (e.g. Author - Book).
     */
    func listBooksByName(searchString: String) -> [String] {
        var arrwithname: [String] = []  //массив с названиями книг
        var arrwithsamename: [String] = []  //массив с названиями книг, который нужен для проверки одинаковых названий
        var authors : [String] = [] //массив с авторами книг
        var k = false
        for s in books {
            if s.name.contains(searchString){ //если подстрока была найдена
                if arrwithsamename.count == 0{
                    arrwithname.append(s.name)
                    arrwithsamename.append(s.name)
                    authors.append(s.author)
                }
                else{
                    if arrwithname.count <= 9 {  //если не набрано 10 названий
                        for i in 0 ..< arrwithsamename.count{
                            if s.name == arrwithsamename[i]{
                                k = true  //добавление имени автора к встреченному названию ранее
                                arrwithname[i] = authors[i] +  " - " + arrwithsamename[i]
                            }
                        }
                        if k == true {
                            arrwithname.append(s.author + " - "  + s.name)
                        }
                        else{
                            arrwithname.append(s.name)
                        }
                        k = false
                        arrwithsamename.append(s.name)
                        authors.append(s.author)
                    }
                }
            }
        }
        return arrwithname
    }
    
    /**
     - Returns: 10 book names whose author contains the specified string, ordered by authors.
     */
    
    func listBooksByAuthor(searchString: String) -> [String] {
        var arr: [Book] = []
        var arrwithname: [String] = []
        for s in books {
            if s.author.contains(searchString){ //если подстрока была найдена
                if arr.count <= 9 {  //если не набрано 10 названий
                    arr.append(s)
                }
            }
        }
        arr.sort(by:{$0.author < $1.author})
        for tmp in arr{
            arrwithname.append(tmp.name)
        }
        return arrwithname
    }
    
}

// MARK: - Test
func test(lib: Library) {
    assert(!lib.deleteBook(id: "1"))
    assert(lib.addNewBook(book: Book(id: "1", name: "1", author: "Lex")))
    assert(!lib.addNewBook(book: Book(id: "1", name: "any name because we check id only", author: "any author")))
    assert(lib.deleteBook(id: "1"))
    assert(lib.addNewBook(book: Book(id: "3", name: "Some Book3", author: "Some Author2")))
    assert(lib.addNewBook(book: Book(id: "4", name: "Some Book1", author: "Some Author3")))
    assert(lib.addNewBook(book: Book(id: "2", name: "Some Book2", author: "Some Author2")))
    assert(lib.addNewBook(book: Book(id: "1", name: "Some Book1", author: "Some Author1")))
    assert(lib.addNewBook(book: Book(id: "5", name: "Other Book5", author: "Other Author4")))
    assert(lib.addNewBook(book: Book(id: "6", name: "Other Book6", author: "Other Author4")))
    assert(lib.addNewBook(book: Book(id: "7", name: "Other Book7", author: "Other Author4")))
    assert(lib.addNewBook(book: Book(id: "8", name: "Other Book8", author: "Other Author4")))
    assert(lib.addNewBook(book: Book(id: "9", name: "Other Book9", author: "Other Author4")))
    assert(lib.addNewBook(book: Book(id: "10", name: "Other Book10", author: "Other Author4")))
    assert(lib.addNewBook(book: Book(id: "11", name: "Other Book11", author: "Other Author4")))
    
    var byNames: [String] = lib.listBooksByName(searchString: "Book")
    assert(byNames.count == 10)
    
    byNames = lib.listBooksByName(searchString: "Some Book")
    assert(byNames.count == 4)
    assert(byNames.contains("Some Author3 - Some Book1"))
    assert(byNames.contains("Some Book2"))
    assert(byNames.contains("Some Book3"))
    assert(!byNames.contains("Some Book1"))
    assert(byNames.contains("Some Author1 - Some Book1"))
    
    var byAuthor: [String] = lib.listBooksByAuthor(searchString: "Author")
    assert(byAuthor.count == 10)
    
    byAuthor = lib.listBooksByAuthor(searchString: "Some Author")
    assert(byAuthor.count == 4)
    assert(byAuthor[0] == "Some Book1")
    assert(byAuthor[1] == "Some Book2" || byAuthor[1] == "Some Book3")
    assert(byAuthor[2] == "Some Book2" || byAuthor[2] == "Some Book3")
    assert(byAuthor[3] == "Some Book1")
    
    print("Test successfully passed")
}

var l: Library = Library()
test(lib: l)
