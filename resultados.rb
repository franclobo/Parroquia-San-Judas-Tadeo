require 'pg'
require 'prawn'
require 'fox16'
include Fox

class ResultadosConsulta < FXMainWindow
  def initialize(app, result_data)
    super(app, "Resultados de la Consulta", :width => 800, :height => 600)
    @app = app

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

    # Al hacer clic en una fila, se selecciona la fila completa para imprimir los datos
    def seleccionar_fila
      @tabla.each_row do |i|
        if @tabla.isRowSelected(i.index)
          @tabla.selectRow(i.index)
        end
      end
    end

    def registros_seleccionados
      registros = []
      (0...@tabla.numRows).each do |i|
        if @tabla.isRowSelected(i)
          registros << @result_data[i]
        end
      end
      registros
    end

    # Cambiar el formato de la fecga de YYYY-MM-DD a DD de nombre_mes de YYYY
    def cambiar_formato_fecha(fecha)
      # split "-" or "/"
      fecha = fecha.split(/-|\//)
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
        "01" => "enero",
        "02" => "febrero",
        "03" => "marzo",
        "04" => "abril",
        "05" => "mayo",
        "06" => "junio",
        "07" => "julio",
        "08" => "agosto",
        "09" => "septiembre",
        "10" => "octubre",
        "11" => "noviembre",
        "12" => "diciembre"
      }
      meses[mes]
    end

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
      seleccionar_directorio
      imprimir_pdf
    end

    def seleccionar_directorio
      dialog = FXDirDialog.new(self, "Seleccionar directorio para guardar PDF")
      if dialog.execute != 0
        directorio = dialog.getDirectory
        #El nombre del directorio son los apellidos y nombres del creyente seguido del sacramento
        @archivo_pdf = "#{directorio}/#{registros_seleccionados[0][19]} #{registros_seleccionados[0][20]} - #{registros_seleccionados[0][1]}.pdf"
      end
    end

    def imprimir_pdf
      if registros_seleccionados.empty?
        FXMessageBox.warning(self, MBOX_OK, "Advertencia", "Debe seleccionar al menos un registro")
      else
        # Genera el archivo PDF
        Prawn::Document.generate(@archivo_pdf, :margin => [150, 100, 100, 100]) do |pdf|
          pdf.font "Helvetica"
          pdf.font_size 12
          # Definir tres casos en los que se puede imprimir el certificado y los distintos formatos para bautismo, confirmación y matrimonio
          # Bautismo

          case registros_seleccionados[0][1]
          when "Bautismo"
            # Título del certificado en color rojo
            pdf.text "CERTIFICADO DE BAUTISMO", :align => :center, :size => 20, :style => :bold, :color => "FF0000"
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Añadir márgenes izquierdo y derecho
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime("%d/%m/%Y"))}", :align => :right
              pdf.move_down 20
              # Tomo, página y número justificado
              pdf.text "Yo, el infrascrito, certifico en legal forma a petición de la parte interesada que en el libro de bautismos de esta parroquia: Tomo #{registro[15]} - Página #{registro[16]} - Número #{registro[17]}, se halla inscrita la siguiente partida:", :align => :justify
              pdf.move_down 10
              # Fecha de bautismo
              pdf.text "El día #{cambiar_formato_fecha(registro[2])}. En la parroquia de #{registro[25]} en el sector de #{registro[26]}.", :align => :justify
              pdf.move_down 10
              # Celebrante
              pdf.text "El #{registro[3]} bautizó solemnemente a #{registro[19]} #{registro[20]}.", :align => :justify
              pdf.move_down 10
              # Fecha de nacimiento
              pdf.text "Nacido/da en #{registro[21]} el #{cambiar_formato_fecha(registro[22])}.", :align => :justify
              pdf.move_down 10
              # Padres
              pdf.text "Hijo/ja de #{registro[9]} y de #{registro[10]}.", :align => :justify
              pdf.move_down 10
              # Padrinos
              pdf.text "Fueron sus padrinos: #{registro[5]} y #{registro[6]} a quienes se advirtió de sus obligaciones y parentezco espiritual.", :align => :justify
              pdf.move_down 10
              # Certifica
              pdf.text "Lo certifica: #{registro[4]}.", :align => :justify
              pdf.move_down 10
              # Registro civil
              pdf.text "REGISTRO CIVIL", :align => :center, :size => 16
              pdf.move_down 10
              pdf.text "Provincia: #{registro[29]}, Cantón: #{registro[30]}, Parroquia: #{registro[31]}", :align => :justify
              pdf.text "Año: #{registro[32]}, Tomo: #{registro[33]}, Página: #{registro[34]}, Acta: #{registro[35]}", :align => :justify
              pdf.text "Fecha: #{cambiar_formato_fecha(registro[36])}", :align => :justify
              pdf.move_down 10
              # Datos tomados fielmente de original
              pdf.text "Datos tomados fielmente del original", :align => :center
              pdf.move_down 40
              # Firma del párroco
              pdf.text "_______________________________", :align => :center
              pdf.move_down 10
              # Nombre del párroco
              pdf.text "#{registro[27]}", :align => :center
              pdf.move_down 10
              # Parroco
              pdf.text "Párroco", :align => :center
              pdf.move_down 10
            end
          when "Confirmación"
            pdf.text "CERTIFICADO DE CONFIRMACIÓN", :align => :center, :size => 20, :style => :bold, :color => "FF0000"
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime("%d/%m/%Y"))}", :align => :right
              pdf.move_down 20
              # Tomo, página y número justificado
              pdf.text "Yo, el infrascrito, certifico en legal forma a petición de la parte interesada que en el libro de confirmaciones de esta parroquia: Tomo #{registro[15]} - Página #{registro[16]} - Número #{registro[17]}, se halla inscrita la siguiente partida:", :align => :justify
              pdf.move_down 10
              # Fecha de confirmación
              pdf.text "El día #{cambiar_formato_fecha(registro[2])}. En la parroquia de #{registro[25]} en el sector de #{registro[26]}.", :align => :justify
              pdf.move_down 10
              # Celebrante
              pdf.text "El #{registro[3]} confirmó en la fe critiana católica apostólica romana a #{registro[19]} #{registro[20]}.", :align => :justify
              pdf.move_down 10
              # Fecha de nacimiento
              pdf.text "Nacido/da el #{registro[22]} en #{registro[21]}.", :align => :justify
              pdf.move_down 10
              # Padrinos
              pdf.text "Fueron sus padrinos: #{registro[5]} y #{registro[6]} a quienes se advirtió de sus obligaciones y parentezco espiritual.", :align => :justify
              pdf.move_down 10
              # Certifica
              pdf.text "Lo certifica: #{registro[4]}.", :align => :justify
              pdf.move_down 10
              # Datos tomados fielmente de original
              pdf.text "Datos tomados fielmente del original", :align => :center
              pdf.move_down 10
               # Firma del párroco
              pdf.text "_______________________________", :align => :center
              pdf.move_down 10
              # Nombre del párroco
              pdf.text "#{registro[27]}", :align => :center
              pdf.move_down 10
              # Parroco
              pdf.text "Párroco", :align => :center
              pdf.move_down 10
            end
          when "Matrimonio"
            pdf.text "CERTIFICADO DE MATRIMONIO", :align => :center, :size => 20, :style => :bold, :color => "FF0000"
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime("%d/%m/%Y"))}", :align => :right
              pdf.move_down 20
              # Tomo, página y número justificado
              pdf.text "Yo, el infrascrito, certifico en legal forma a petición de la parte interesada que en el libro de matrimonios de esta parroquia: Tomo #{registro[15]} - Página #{registro[16]} - Número #{registro[17]}, se halla inscrita la siguiente partida:", :align => :justify
              pdf.move_down 10
              # Fecha de matrimonio
              pdf.text "El día #{cambiar_formato_fecha(registro[2])} contrajeron matrimonio #{registro[19]} #{registro[20]} y #{registro[11]} #{registro[12]} en la parroquia de #{registro[25]} en el sector de #{registro[26]}.", :align => :justify
              pdf.move_down 10
              # Celebrante
              pdf.text "Presenció y bendijo el matrimonio el #{registro[3]}.", :align => :justify
              # Feligreses de la parroquia
              pdf.text "Feligreses de la parroquia: #{registro[25]}.", :align => :justify
              pdf.move_down 10
              # Testigos
              pdf.text "Fueron sus testigos: #{registro[7]} y #{registro[8]}.", :align => :justify
              pdf.move_down 10
              # Cerifica
              pdf.text "Lo certifica: #{registro[4]}.", :align => :justify
              pdf.move_down 10
              # Registro civil
              pdf.text "REGISTRO CIVIL", :align => :center, :size => 16
              pdf.move_down 10
              pdf.text "Provincia: #{registro[29]}, Cantón: #{registro[30]}, Parroquia: #{registro[31]}", :align => :justify
              pdf.text "Año: #{registro[32]}, Tomo: #{registro[33]}, Página: #{registro[34]}, Acta: #{registro[35]}", :align => :justify
              pdf.text "Fecha: #{cambiar_formato_fecha(registro[36])}", :align => :justify
              pdf.move_down 10
              # Datos tomados fielmente de original
              pdf.text "Datos tomados fielmente del original", :align => :center
              pdf.move_down 40
              # Firma del párroco
              pdf.text "_______________________________", :align => :center
              pdf.move_down 10
              # Nombre del párroco
              pdf.text "#{registro[27]}", :align => :center
              pdf.move_down 10
              # Parroco
              pdf.text "Párroco", :align => :center
              pdf.move_down 10
            end
          end
        end
        # Abre el archivo PDF con el visor de PDF predeterminado del sistema
        system("xdg-open '#{@archivo_pdf}'")
      end
      # Mensaje de confirmación
        FXMessageBox.information(self, MBOX_OK, "Información", "El archivo PDF se ha generado correctamente")
    end

    @btnedit.connect(SEL_COMMAND) do
      # Editar registros seleccionados y actualizar la basee de datos
      registros_seleccionados.each do |registro|
        case registros_seleccionados[0][1]
        when "Bautismo"
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_bautismo'
            vtnactualizar_bautismo = ActualizarBautismo.new(@app, @registros)
            vtnactualizar_bautismo.create
            vtnactualizar_bautismo.show(PLACEMENT_SCREEN)
          end
        when "Confirmación"
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_confirmacion'
            vtnactualizar_confirmacion = ActualizarConfirmacion.new(@app, @registros)
            vtnactualizar_confirmacion.create
            vtnactualizar_confirmacion.show(PLACEMENT_SCREEN)
          end
        when "Matrimonio"
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_matrimonio'
            vtnactualizar_matrimonio = ActualizarMatrimonio.new(@app, @registros)
            vtnactualizar_matrimonio.create
            vtnactualizar_matrimonio.show(PLACEMENT_SCREEN)
          end
        end
      end
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
