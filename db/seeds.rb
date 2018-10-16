# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# require 'database_cleaner'
# DatabaseCleaner.strategy = :truncation
# DatabaseCleaner.clean
# require_relative '../app/models/author'
# require_relative '../app/models/book_author'
# require_relative '../app/models/book'
# require_relative '../app/models/review'
# require_relative '../app/models/user'

user_1 = User.create(name: "booklover11")
user_2 = User.create(name: "John Smith")
user_3 = User.create(name: "Kyle Smithers")
user_4 = User.create(name: "Critic McGibbons")
user_5 = User.create(name: "George Cormack")
user_6 = User.create(name: "unhappy camper")
user_7 = User.create(name: "Susan McPhalen")
user_8 = User.create(name: "jenny_kramer_123")
user_9 = User.create(name: "i_love_books_98")
user_10 = User.create(name: "Amy Petrie")
user_11 = User.create(name: "Tim Fell")
user_12 = User.create(name: "Tony Malone")

book_1 = Book.create(title: "The Name of the Wind", pages: 570, year: 2000)
author_1 = book_1.authors.create(name: "Patrick Rothfuss")

review_1 = book_1.reviews.create(title: "Amazing Story", score: 5, description: "Loved it!", user_id: user_1.id)
review_2 = book_1.reviews.create(title: "Pretty good", score: 4, description: "I was entertained throughout", user_id: user_2.id)
review_3 = book_1.reviews.create(title: "Worthwhile", score: 3, description: "I enjoyed this book a lot", user_id: user_3.id)
review_4 = book_1.reviews.create(title: "Epic read!", score: 4, description: "Loved it!", user_id: user_4.id)
review_5 = book_1.reviews.create(title: "The best book ever", score: 4, description: "I was entertained throughout", user_id: user_6.id)
review_6 = book_1.reviews.create(title: "A little too long", score: 4, description: "I enjoyed this book, but it was long", user_id: user_7.id)

book_2 = Book.create(title: "Shogun", pages: 995, year: 1968)
author_2 = book_2.authors.create(name: "James Clavell")

review_23 = book_2.reviews.create(title: "Epic read!", score: 3, description: "Loved it!", user_id: user_4.id)
review_24 = book_2.reviews.create(title: "The best book ever", score: 4, description: "I was entertained throughout", user_id: user_12.id)
review_25 = book_2.reviews.create(title: "A little too long", score: 4, description: "I enjoyed this book, but it was long", user_id: user_5.id)

book_3 = Book.create(title: "How To Help Your Marraige", pages: 234, year: 2015)
author_3 = book_3.authors.create(name: "Dr. Brad Smith")
author_4 = book_3.authors.create(name: "Dr. Angelina Smith")

review_7 = book_3.reviews.create(title: "Not helpful", score: 2, description: "This book was contrite and trivial.", user_id: user_6.id)
review_8 = book_3.reviews.create(title: "Marriage ruiner!", score: 1, description: "My marriage was made worse through this book.", user_id: user_12.id)


book_4 = Book.create(title: "The Great Gatsby", pages: 301, year: 1925)
author_5 = book_4.authors.create(name: "F. Scott Fitzgerald")

review_10 = book_4.reviews.create(title: "Not my favorite", score: 3, description: "The love story was sad and had a bad ending", user_id: user_4.id)
review_11 = book_4.reviews.create(title: "Themes that last the ages", score: 4, description: "I love this book, everyone should read it.", user_id: user_7.id)
review_12 = book_4.reviews.create(title: "Rich and nostalgic", score: 5, description: "The authors appear to not know how to write.", user_id: user_5.id)

book_5 = Book.create(title: "Wuthering Heights", pages: 348, year: 1890)
author_6 = book_5.authors.create(name: "Emily Bronte")

review_13 = book_5.reviews.create(title: "Why the popularity?", score: 3, description: "Overrated tale of love and deception", user_id: user_5.id)
review_14 = book_5.reviews.create(title: "Undying love", score: 5, description: "I love this book, everyone should read it.", user_id: user_12.id)
review_14 = book_5.reviews.create(title: "Love and Betrayal", score: 5, description: "I love this book, everyone should read it.", user_id: user_8.id)

book_6 = Book.create(title: "Old Man and The Sea", pages: 396, year: 1922)
author_7 = book_6.authors.create(name: "Ernest Hemmingway")

review_15 = book_6.reviews.create(title: "Lovely Tale", score: 4, description: "It was beautifully written, but the pace was a bit slow.", user_id: user_8.id)
review_16 = book_6.reviews.create(title: "Stunning and scary", score: 4, description: "I wasnt scared and enchanted", user_id: user_1.id)
review_17 = book_6.reviews.create(title: "AWESOME!!", score: 5, description: "It was so great", user_id: user_3.id)
book_6.reviews.create(title: "glad I read it", score: 3, description: "It was so good but hard to understand", user_id: user_11.id)

book_7 = author_2.books.create(title: "Tai-Pan", pages: 1081, year: 1985)

review_18 = book_7.reviews.create(title: "Fav Clavell book!", score: 5, description: "Best of the series by far!", user_id: user_8.id)
review_19 = book_7.reviews.create(title: "Clavell doesnt disappoint!", score: 5, description: "The writing and descriptions have no match.", user_id: user_12.id)

book_8 = author_2.books.create(title: "Noble House", pages: 976, year: 1989)
review_20 = book_8.reviews.create(title: "Left me speechless", score: 5, description: "Cant wait to read again!", user_id: user_10.id)
review_21 = book_8.reviews.create(title: "Didnt enjoy that much", score: 4, description: "Way too long, should have been shorter.", user_id: user_11.id)
review_22 = book_8.reviews.create(title: "The best!!", score: 4, description: "Super great!", user_id: user_9.id)

book_9 = author_1.books.create(title: "The Wise Man's Fear", pages: 870, year: 2009)

review_1 = book_9.reviews.create(title: "Amazing Story", score: 4, description: "Loved it!", user_id: user_1.id)
review_2 = book_9.reviews.create(title: "Pretty good", score: 4, description: "I was entertained throughout", user_id: user_2.id)
review_3 = book_9.reviews.create(title: "Worthwhile", score: 3, description: "I enjoyed this book a lot", user_id: user_8.id)
review_4 = book_9.reviews.create(title: "Epic read!", score: 5, description: "Loved it!", user_id: user_11.id)
review_5 = book_9.reviews.create(title: "The best book ever", score: 4, description: "I was entertained throughout", user_id: user_6.id)
review_6 = book_9.reviews.create(title: "A little too long", score: 5, description: "I enjoyed this book, but it was long", user_id: user_10.id)

book_10 = author_2.books.create(title: "Whirlwind", pages: 765, year: 1992)

review_18 = book_10.reviews.create(title: "Fav Clavell book!", score: 3, description: "Best of the series by far!", user_id: user_2.id)
review_19 = book_10.reviews.create(title: "Clavell doesnt disappoint!", score: 3, description: "The writing and descriptions have no match.", user_id: user_9.id)

book_11 = Book.create(title: "East of Eden", pages: 411, year: 1954)

author_9 = book_11.authors.create(name: "John Steinbeck")

book_11.reviews.create(title: "Why the popularity?", score: 3, description: "Overrated tale of love and deception", user_id: user_5.id)
book_11.reviews.create(title: "Undying love", score: 4, description: "I love this book, everyone should read it.", user_id: user_12.id)
book_11.reviews.create(title: "Love and Betrayal", score: 5, description: "I love this book, everyone should read it.", user_id: user_8.id)

book_12 = author_9.books.create(title: "Of Mice and Men", pages: 201, year: 1934)

book_12.reviews.create(title: "Amazing Story", score: 3, description: "Loved it!", user_id: user_3.id)
book_12.reviews.create(title: "Pretty good", score: 4, description: "I was entertained throughout", user_id: user_8.id)
book_12.reviews.create(title: "Worthwhile", score: 3, description: "I enjoyed this book a lot", user_id: user_4.id)
book_12.reviews.create(title: "Epic read!", score: 5, description: "Loved it!", user_id: user_9.id)
book_12.reviews.create(title: "The best book ever", score: 4, description: "I was entertained throughout", user_id: user_12.id)
book_12.reviews.create(title: "A little too long", score: 4, description: "I enjoyed this book, but it was long", user_id: user_11.id)

book_13 = author_7.books.create(title: "The Sun Also Rises", pages: 191, year: 1943)

book_13.reviews.create(title: "Great Story", score: 3, description: "Loved it!", user_id: user_5.id)
book_13.reviews.create(title: "A wartime epic", score: 4, description: "I was entertained throughout", user_id: user_9.id)
book_13.reviews.create(title: "Read this book!", score: 3, description: "I enjoyed this book a lot", user_id: user_2.id)
book_13.reviews.create(title: "My favorite book", score: 4, description: "Loved it!", user_id: user_11.id)
book_13.reviews.create(title: "The best book Ive read in a while", score: 4, description: "I was entertained throughout", user_id: user_4.id)
book_13.reviews.create(title: "A little too long", score: 3, description: "I enjoyed this book, but it was long", user_id: user_10.id)

book_14 = author_7.books.create(title: "As the Bell Tolls", pages: 259, year: 1950)
