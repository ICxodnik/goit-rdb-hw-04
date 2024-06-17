use library_management;

create table authors
(
    author_id   int auto_increment,
    author_name nvarchar(100) not null,
    constraint authors_pk
    primary key (author_id)
);

create table genres
(
    genre_id int auto_increment,
    genre_name nvarchar(50) not null,
    constraint genres_pk
    primary key (genre_id)
);

create table books
(
    book_id int auto_increment,
    title nvarchar(50) not null,
    publication_year YEAR not null,
    #bible without author
    author_id int,
    genre_id int,
    constraint books_pk
    primary key (book_id),
    constraint books_author_id_authors_author_id_fk
    foreign key (author_id) references authors (author_id),
    constraint books_genre_id_genres_genre_id_fk
    foreign key (genre_id) references genres (genre_id)
);

create table users
(
    user_id int auto_increment,
    username nvarchar(100) not null,
    email nvarchar(100) not null,
    constraint users_pk
    primary key (user_id)
);

create table borrowed_books
(
    borrow_id int auto_increment,
    book_id int not null,
    user_id int not null,
    borrow_date date not null,
    return_date date,
    constraint borrowed_books_pk
    primary key (borrow_id),
    constraint borrowed_books_book_id_books_book_id_fk
    foreign key (book_id) references books (book_id),
    constraint borrowed_books_user_id_users_user_id_fk
    foreign key (user_id) references users (user_id)
)