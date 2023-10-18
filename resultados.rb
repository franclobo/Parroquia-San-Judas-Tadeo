require 'pg'
require 'fox16'
include Fox

class ResultadosConsulta < FXMainWindow
  def initialize(app, result_data)
    super(app, "Resultados de la Consulta", :width => 800, :height => 600)

    @result_data = result_data  # Los datos de resultados que se pasan a esta clase

    # Crea una tabla para mostrar los resultados
    @tabla = FXTable.new(self, :opts => LAYOUT_EXPLICIT|TABLE_COL_SIZABLE|TABLE_ROW_SIZABLE, :width => 800, :height => 400, :x => 0, :y => 0)
    @tabla.visibleRows = 10
    @tabla.visibleColumns = 10
    # El tamaño de la tabla depende del número de columnas nombrada en poner nombre a las columnas y las filas al numero de registros encontrados
    @tabla.setTableSize(@result_data.length, 37)


    # Llena la tabla con los datos de resultados
    @result_data.each_with_index do |row, i|
      row.each_with_index do |col, j|
        @tabla.setItemText(i, j, col.to_s)
      end
    end

    # Poner nombre a las columnas
    @tabla.setColumnText(0, "ID Sacramentos")
    @tabla.setColumnText(1, "Sacramento")
    @tabla.setColumnText(2, "Fecha")
    @tabla.setColumnText(3, "Celebrante")
    @tabla.setColumnText(4, "Certifica")
    @tabla.setColumnText(5, "Pdrino")
    @tabla.setColumnText(6, "Madrina")
    @tabla.setColumnText(7, "Testigo novio")
    @tabla.setColumnText(8, "Testigo novia")
    @tabla.setColumnText(9, "Padre")
    @tabla.setColumnText(10, "Madre")
    @tabla.setColumnText(11, "Nombres de la novia")
    @tabla.setColumnText(12, "Apellidos de la novia")
    @tabla.setColumnText(13, "Cédula de la novia")
    @tabla.setColumnText(14, "ID Libros")
    @tabla.setColumnText(15, "Tomo")
    @tabla.setColumnText(16, "Página")
    @tabla.setColumnText(17, "Número")
    @tabla.setColumnText(18, "ID Creyentes")
    @tabla.setColumnText(19, "Nombres")
    @tabla.setColumnText(20, "Apellidos")
    @tabla.setColumnText(21, "Lugar de nacimiento")
    @tabla.setColumnText(22, "Fecha de nacimiento")
    @tabla.setColumnText(23, "Cédula")
    @tabla.setColumnText(24, "ID Parroquias")
    @tabla.setColumnText(25, "Parroquia")
    @tabla.setColumnText(26, "Sector")
    @tabla.setColumnText(27, "Parroco")
    @tabla.setColumnText(28, "ID Registros Civiles")
    @tabla.setColumnText(29, "Provincia")
    @tabla.setColumnText(30, "Cantón")
    @tabla.setColumnText(31, "Parroquia")
    @tabla.setColumnText(32, "Año")
    @tabla.setColumnText(33, "Tomo")
    @tabla.setColumnText(34, "Página")
    @tabla.setColumnText(35, "Acta")
    @tabla.setColumnText(36, "Fecha")



    # Nombre de las filas
    @result_data.each_with_index do |row, i|
      @tabla.setRowText(i, "Registro #{i+1}")
    end

    # create buttons
    @btnprint = FXButton.new(self, "Imprimir", :opts => LAYOUT_EXPLICIT | BUTTON_NORMAL, :width => 100, :height => 30, :x => 10, :y => 430)
    @btnedit = FXButton.new(self, "Editar", :opts => LAYOUT_EXPLICIT | BUTTON_NORMAL, :width => 100, :height => 30, :x => 120, :y => 430)
    @btndelete = FXButton.new(self, "Eliminar", :opts => LAYOUT_EXPLICIT | BUTTON_NORMAL, :width => 100, :height => 30, :x => 230, :y => 430)
    @btncancel = FXButton.new(self, "Cancelar", :opts => LAYOUT_EXPLICIT | BUTTON_NORMAL, :width => 100, :height => 30, :x => 340, :y => 430)

    # connect buttons
    @btnprint.connect(SEL_COMMAND) do
      # imprimir registros seleccionados
    end

    @btnedit.connect(SEL_COMMAND) do
      # editar registros seleccionados
    end

    @btndelete.connect(SEL_COMMAND) do
      # eliminar registros seleccionados
    end

    @btncancel.connect(SEL_COMMAND) do
      # cerrar ventana
      close
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end