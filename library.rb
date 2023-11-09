# frozen_string_literal: true

require 'fox16'
include Fox

class Book
  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_s
    "#{@title} by #{@author}"
  end
end

class Library
  def initialize
    @books = ['Harry Potter', 'Lord of the Rings']
  end

  def add_book(book)
    @books << book
  end

  def list_books
    @books
  end
end

class LibraryApp
  def initialize
    @library = Library.new

    # Crear una aplicación FXRuby
    application = FXApp.new

    # Crear una ventana principal
    main_window = FXMainWindow.new(application, 'Library App', width: 400, height: 300)

    # Crear una lista para mostrar los libros
    book_list = FXList.new(main_window, opts: LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Crear un botón para agregar libros
    add_button = FXButton.new(main_window, 'Agregar Libro')

    # Controlador de evento para el botón
    add_button.connect(SEL_COMMAND) do
      title = FXInputDialog.getString('Agregar Libro', main_window, 'Título del Libro:')
      author = FXInputDialog.getString('Agregar Libro', main_window, 'Autor del Libro:')
      book = Book.new(title, author)
      @library.add_book(book)
      book_list.appendItem(book.to_s)
    end

    # Mostrar la lista inicial de libros
    @library.list_books.each { |book| book_list.appendItem(book.to_s) }

    # Mostrar la ventana
    main_window.show

    # Ejecutar la aplicación FXRuby
    application.create
    application.run
  end
end

LibraryApp.new
