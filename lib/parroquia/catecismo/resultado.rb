# frozen_string_literal: true

require 'pg'
require 'prawn'
require 'fox16'
include Fox

class ResultadosConsulta < FXMainWindow
  def initialize(app, result_data)
    super(app, 'Resultados de la Consulta', width: 800, height: 480)
    @app = app

    @result_data = result_data # Los datos de resultados que se pasan a esta clase

    # Crea una tabla para mostrar los resultados
    @tabla = FXTable.new(self, opts: LAYOUT_EXPLICIT | TABLE_COL_SIZABLE | TABLE_ROW_SIZABLE, width: 800,
                               height: 400, x: 0, y: 0)
    @tabla.visibleRows = 10
    @tabla.visibleColumns = 10
    # El tamaño de la tabla depende del número de columnas nombrada en poner nombre a las columnas y las filas al numero de registros encontrados
    @tabla.setTableSize(@result_data.length, 14)


    # Llena la tabla con los datos de resultados
    @result_data.each_with_index do |row, i|
      row.each_with_index do |col, j|
        @tabla.setItemText(i, j, col.to_s)
      end
    end

    # Poner nombre a las columnas
    @tabla.setColumnText(0, 'ID Alumnos')
    @tabla.setColumnText(1, 'Nombres')
    @tabla.setColumnText(2, 'Apellidos')
    @tabla.setColumnText(3, 'Lugar_nacimiento')
    @tabla.setColumnText(4, 'Fecha_nacimiento')
    @tabla.setColumnText(5, 'Cédula')
    @tabla.setColumnText(6, 'ID Niveles')
    @tabla.setColumnText(7, 'Nivel')
    @tabla.setColumnText(8, 'Sector')
    @tabla.setColumnText(9, 'Año lectivo')
    @tabla.setColumnText(10, 'Párroco')
    @tabla.setColumnText(11, 'ID Catequistas')
    @tabla.setColumnText(12, 'Nombres')
    @tabla.setColumnText(13, 'Apellidos')


    # Al hacer clic en una fila, se selecciona la fila completa para imprimir los datos
    def seleccionar_fila
      @tabla.each_row do |i|
        @tabla.selectRow(i.index) if @tabla.isRowSelected(i.index)
      end
    end

    def registros_seleccionados
      registros = []
      (0...@tabla.numRows).each do |i|
        registros << @result_data[i] if @tabla.isRowSelected(i)
      end
      registros
    end

    def seleccionar_columna
      selected_columns = []

      (0...@tabla.numColumns).each do |i|
        selected_columns << i if @tabla.isColumnSelected(i)
      end

      selected_columns
    end

    # Cambiar el formato de la fecha de YYYY-MM-DD a DD de nombre_mes de YYYY
    def cambiar_formato_fecha(fecha)
      # split "-" or "/"
      fecha = fecha.split(%r{-|/})
      # si el formato de fecha es YYYY-MM-DD o YYYY/MM/DD, sino si es DD-MM-YYYY o DD/MM/YYYY
      if fecha[0].length == 4
        "#{fecha[2]} de #{nombre_mes(fecha[1])} de #{fecha[0]}"
      else
        "#{fecha[0]} de #{nombre_mes(fecha[1])} de #{fecha[2]}"
      end
    end

    # Nombre del mes
    def nombre_mes(mes)
      meses = {
        '01' => 'enero',
        '02' => 'febrero',
        '03' => 'marzo',
        '04' => 'abril',
        '05' => 'mayo',
        '06' => 'junio',
        '07' => 'julio',
        '08' => 'agosto',
        '09' => 'septiembre',
        '10' => 'octubre',
        '11' => 'noviembre',
        '12' => 'diciembre'
      }
      meses[mes]
    end

    # Nombre de las filas
    @result_data.each_with_index do |_row, i|
      @tabla.setRowText(i, "Registro #{i + 1}")
    end

    # create buttons
    @btnlists = FXButton.new(self, 'Listar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                             x: 350, y: 430)
    @btnprint = FXButton.new(self, 'Exportar PDF', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100,
                                                   height: 30, x: 460, y: 430)
    @btnedit = FXButton.new(self, 'Editar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                            x: 570, y: 430)
    @btndelete = FXButton.new(self, 'Eliminar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                x: 680, y: 430)

    # connect buttons
    @btnprint.connect(SEL_COMMAND) do
      seleccionar_directorio
      imprimir_pdf
    end

    @btnlists.connect(SEL_COMMAND) do
      seleccionar_directorio
      listar_pdf
    end

    def registros_seleccionados
      registros = []
      (0...@tabla.numRows).each do |i|
        registros << @result_data[i] if @tabla.isRowSelected(i)
      end
      registros
    end

    def listar_pdf
      selected_columns = seleccionar_columna
      registros_seleccionados = registros_seleccionados() # Obtén los registros seleccionados

      if selected_columns.empty? || registros_seleccionados.empty?
        FXMessageBox.warning(self, MBOX_OK, 'Advertencia', 'Debe seleccionar al menos una columna y registros')
      else
        # Genera el archivo PDF
        Prawn::Document.generate(@archivo_pdf, margin: [150, 100, 100, 100]) do |pdf|
          pdf.font 'Helvetica'
          pdf.font_size 12
          pdf.image File.join(File.dirname(__FILE__), '../assets/images/arquidiocesisquito.png'), height: 100,
                                                                                                  position: :absolute, at: [-60, 680]
          pdf.text_box 'Arquidiócesis de Quito', align: :center, size: 16, style: :bold, at: [10, 670],
                                                 width: pdf.bounds.width
          pdf.text_box 'Parroquia Eclesiástica "San Judas Tadeo"', align: :center, size: 14, style: :bold,
                                                                   at: [10, 650], width: pdf.bounds.width
          pdf.text_box "Jaime Roldós Aguilera, calle Oe13A y N82\nEl Condado, Quito - Ecuador\nTeléfono: 02496446",
                       align: :center, size: 10, at: [10, 630], width: pdf.bounds.width
          pdf.image File.join(File.dirname(__FILE__), '../assets/images/sanjudastadeo.png'), height: 100,
                                                                                             position: :absolute, at: [430, 680]
          # Título del certificado en color rojo
          pdf.text 'Lista de alumnos', align: :center, size: 20, style: :bold, color: 'FF0000'
          pdf.move_down 20

          # Recorre todos los registros seleccionados y agrega sus horarios de misas
          pdf.text "Año Lectivo #{registros_seleccionados[0][9]}"
          pdf.move_down 10
          pdf.text "Catequista #{registros_seleccionados[0][11]} #{registros_seleccionados[0][12]}"
          pdf.move_down 10
          pdf.text 'Número | Apellidos | Nombres | Nivel | Sector'
          pdf.move_down 10
          contador = 1
          registros_seleccionados.each do |registro|
            # Listar con numeros
            pdf.text "#{contador} | #{registro[selected_columns[2]]} #{registro[selected_columns[1]]} | #{registro[selected_columns[7]]} | #{registro[selected_columns[8]]}"
            pdf.move_down 10
            contador += 1
          end
        end
        # Abre el archivo PDF con el visor de PDF predeterminado del sistema
        system("xdg-open '#{@archivo_pdf}'")
      end
      # Mensaje de confirmación
      FXMessageBox.information(self, MBOX_OK, 'Información', 'El archivo PDF se ha generado correctamente')
    end

    def seleccionar_directorio
      dialog = FXDirDialog.new(self, 'Seleccionar directorio para guardar PDF')
      return unless dialog.execute != 0

      directorio = dialog.getDirectory

      if registros_seleccionados.nil? || registros_seleccionados.empty?
        FXMessageBox.warning(self, MBOX_OK, 'Advertencia', 'No hay registros seleccionados')
      else
        @archivo_pdf = "#{directorio}/#{registros_seleccionados[0][19]} #{registros_seleccionados[0][20]} - #{registros_seleccionados[0][1]}.pdf"
      end
    end

    def imprimir_pdf
      if registros_seleccionados.empty?
        FXMessageBox.warning(self, MBOX_OK, 'Advertencia', 'Debe seleccionar al menos un registro')
      else
        # Genera el archivo PDF
        Prawn::Document.generate(@archivo_pdf, margin: [100, 100, 100, 100]) do |pdf|
          pdf.font 'Helvetica'
          pdf.font_size 12
          # Definir tres casos en los que se puede imprimir el certificado y los distintos formatos para bautismo, confirmación y matrimonio
          # Bautismo
          # Encabezado
          pdf.image File.join(File.dirname(__FILE__), '../assets/images/arquidiocesisquito.png'), height: 80,
                                                                                                  position: :absolute, at: [-60, 680]
          pdf.text_box 'Arquidiócesis de Quito', align: :center, size: 16, style: :bold, at: [10, 670],
                                                 width: pdf.bounds.width
          pdf.text_box 'Parroquia Eclesiástica "San Judas Tadeo"', align: :center, size: 14, style: :bold,
                                                                   at: [10, 650], width: pdf.bounds.width
          pdf.text_box "Jaime Roldós Aguilera, calle Oe13A y N82\nEl Condado, Quito - Ecuador\nTeléfono: 02496446",
                       align: :center, size: 10, at: [10, 630], width: pdf.bounds.width
          pdf.image File.join(File.dirname(__FILE__), '../assets/images/sanjudastadeo.png'), height: 80,
                                                                                             position: :absolute, at: [430, 680]
          # Título del certificado en color rojo
          pdf.move_down 20
          pdf.text 'CERTIFICADO', align: :center, size: 20, style: :bold, color: 'FF0000'
          pdf.move_down 20
          registros_seleccionados.each do |registro|
              # Añadir márgenes izquierdo y derecho
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime('%d/%m/%Y'))}", align: :right
              pdf.move_down 20
              # Cuerpo
              pdf.text "A quien interese por la presente CERTIFICO, que #{registro[1]} #{registro[2]}, participó en esta parroquia en el nivel de #{registro[7]} durante el periodo lectivo #{registro[9]}.", align: :justify
              pdf.move_down 20
              # Despedida
              pdf.text 'Es todo cuanto puedo certificar en honor a la verdad', align: :justify
              pdf.move_down 40
              # Firma del párroco
              pdf.text '_______________________________', align: :center
              # Nombre del párroco
              pdf.text (registro[10]).to_s, align: :center
              # Parroco
              pdf.text 'Párroco', align: :center
          end
        end
        # Abre el archivo PDF con el visor de PDF predeterminado del sistema
        system("xdg-open '#{@archivo_pdf}'")
        # Mensaje de confirmación
        FXMessageBox.information(self, MBOX_OK, 'Información', 'El archivo PDF se ha generado correctamente')
      end
    end

    @btnedit.connect(SEL_COMMAND) do
      # Editar registros seleccionados y actualizar la basee de datos
      registros_seleccionados.each do |registro|
        sql = "SELECT * FROM alumnos INNER JOIN catequistas ON alumnos.id = catequistas.id INNER JOIN niveles ON alumnos.id = niveles.id WHERE alumnos.id = #{registro[0]}"
        $conn.exec(sql) do |result|
          @registros = result.values[0]
          require_relative 'actualizar_alumno'
          vtnactualizar_alumno = ActualizarAlumno.new(@app, @registros)
          vtnactualizar_alumno.create
          vtnactualizar_alumno.show(PLACEMENT_SCREEN)
        end
      end
    end

    @btndelete.connect(SEL_COMMAND) do
      # eliminar registros seleccionados
      if registros_seleccionados.empty?
        FXMessageBox.warning(self, MBOX_OK, 'Advertencia', 'Debe seleccionar al menos un registro')
      elsif FXMessageBox.question(self, MBOX_YES_NO, 'Confirmación',
                                  '¿Está seguro de eliminar los registros seleccionados?') == MBOX_CLICKED_YES
        # Mensaje de confirmación
        registros_seleccionados.each do |registro|
          # Eliminar registros de todas las tablas
          sql = 'DELETE FROM alumnos WHERE id = $1'
          $conn.exec_params(sql, [registro[0]])
          sql = 'DELETE FROM catequistas WHERE id = $1'
          $conn.exec_params(sql, [registro[11]])
          sql = 'DELETE FROM niveles WHERE id = $1'
          $conn.exec_params(sql, [registro[6]])
          # Mensaje de confirmación
          FXMessageBox.information(self, MBOX_OK, 'Información',
                                   'Los registros seleccionados se han eliminado correctamente')
        end
      end
    end
    Prawn::Fonts::AFM.hide_m17n_warning = true
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
