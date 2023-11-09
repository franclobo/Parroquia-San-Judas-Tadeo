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
    @tabla.setTableSize(@result_data.length, 41)


    # Llena la tabla con los datos de resultados
    @result_data.each_with_index do |row, i|
      row.each_with_index do |col, j|
        @tabla.setItemText(i, j, col.to_s)
      end
    end

    # Poner nombre a las columnas
    @tabla.setColumnText(0, 'ID Sacramentos')
    @tabla.setColumnText(1, 'Sacramento')
    @tabla.setColumnText(2, 'Fecha')
    @tabla.setColumnText(3, 'Celebrante')
    @tabla.setColumnText(4, 'Certifica')
    @tabla.setColumnText(5, 'Pdrino')
    @tabla.setColumnText(6, 'Madrina')
    @tabla.setColumnText(7, 'Testigo novio')
    @tabla.setColumnText(8, 'Testigo novia')
    @tabla.setColumnText(9, 'Padre')
    @tabla.setColumnText(10, 'Madre')
    @tabla.setColumnText(11, 'Nombres de la novia')
    @tabla.setColumnText(12, 'Apellidos de la novia')
    @tabla.setColumnText(13, 'Cédula de la novia')
    @tabla.setColumnText(14, 'ID Libros')
    @tabla.setColumnText(15, 'Tomo')
    @tabla.setColumnText(16, 'Página')
    @tabla.setColumnText(17, 'Número')
    @tabla.setColumnText(18, 'ID Creyentes')
    @tabla.setColumnText(19, 'Nombres')
    @tabla.setColumnText(20, 'Apellidos')
    @tabla.setColumnText(21, 'Lugar de nacimiento')
    @tabla.setColumnText(22, 'Fecha de nacimiento')
    @tabla.setColumnText(23, 'Cédula')
    @tabla.setColumnText(24, 'ID Parroquias')
    @tabla.setColumnText(25, 'Parroquia')
    @tabla.setColumnText(26, 'Sector')
    @tabla.setColumnText(27, 'Parroco')
    @tabla.setColumnText(28, 'ID Registros Civiles')
    @tabla.setColumnText(29, 'Provincia')
    @tabla.setColumnText(30, 'Cantón')
    @tabla.setColumnText(31, 'Parroquia')
    @tabla.setColumnText(32, 'Año')
    @tabla.setColumnText(33, 'Tomo')
    @tabla.setColumnText(34, 'Página')
    @tabla.setColumnText(35, 'Acta')
    @tabla.setColumnText(36, 'Fecha')
    @tabla.setColumnText(37, 'ID Misas')
    @tabla.setColumnText(38, 'Intención')
    @tabla.setColumnText(39, 'Fecha')
    @tabla.setColumnText(40, 'Hora')


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
      if fecha.nil?
        return ''
      end
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
          pdf.text 'HORARIO DE MISAS', align: :center, size: 20, style: :bold, color: 'FF0000'
          pdf.move_down 20

          # Recorre todos los registros seleccionados y agrega sus horarios de misas
          pdf.text 'Hora | Capilla | Sector | Intención'
            pdf.move_down 10
          registros_seleccionados.each do |registro|
            pdf.text "#{registro[selected_columns[40]]} | #{registro[selected_columns[25]]} | #{registro[selected_columns[26]]} | #{registro[selected_columns[38]]}"
            pdf.move_down 10
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

          case registros_seleccionados[0][1]
          when 'Bautismo'
            # Título del certificado en color rojo
            pdf.move_down 20
            pdf.text 'CERTIFICADO DE BAUTISMO', align: :center, size: 20, style: :bold, color: 'FF0000'
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Añadir márgenes izquierdo y derecho
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime('%d/%m/%Y'))}", align: :right
              pdf.move_down 20
              # Tomo, página y número justificado
              pdf.text "Yo, el infrascrito, certifico en legal forma a petición de la parte interesada que en el libro de bautismos de esta parroquia: Tomo #{registro[15]} - Página #{registro[16]} - Número #{registro[17]}, se halla inscrita la siguiente partida:",
                       align: :justify
              pdf.move_down 10
              # Fecha de bautismo
              pdf.text "FECHA DE BAUTISMO: #{cambiar_formato_fecha(registro[2])}.", align: :justify
              pdf.move_down 10
              # Lugar de bautismo
              pdf.text "PARROQUIA: #{registro[25]}", align: :justify
              pdf.move_down 10
              # Sector
              pdf.text "SECTOR: #{registro[26]}.", align: :justify
              pdf.move_down 10
              # Celebrante
              pdf.text "MINISTRO: #{registro[3]}.", align: :justify
              pdf.move_down 10
              # Nombres
              pdf.text "NOMBRES: #{registro[19]}.", align: :justify
              pdf.move_down 10
              # Apellidos
              pdf.text "APELLIDOS: #{registro[20]}.", align: :justify
              pdf.move_down 10
              # Fecha de nacimiento
              pdf.text "LUGAR DE NACIMIENTO #{registro[21]}. FECHA DE NACIMIENTO: #{cambiar_formato_fecha(registro[22])}.",
                       align: :justify
              pdf.move_down 10
              # Padres
              pdf.text "Hijo/ja de #{registro[9]} y de #{registro[10]}.", align: :justify
              pdf.move_down 10
              # Padrinos
              pdf.text "Fueron sus padrinos: #{registro[5]} y #{registro[6]} a quienes se advirtió de sus obligaciones y parentezco espiritual.",
                       align: :justify
              pdf.move_down 10
              # Certifica
              pdf.text "CERTIFICA: #{registro[4]}.", align: :justify
              pdf.move_down 10
              # Registro civil
              pdf.text 'REGISTRO CIVIL', align: :center, size: 14, style: :bold
              pdf.move_down 10
              pdf.text "Provincia: #{registro[29]}, Cantón: #{registro[30]}, Parroquia: #{registro[31]}",
                       align: :justify
              pdf.text "Año: #{registro[32]}, Tomo: #{registro[33]}, Página: #{registro[34]}, Acta: #{registro[35]}",
                       align: :justify
              pdf.text "Fecha: #{cambiar_formato_fecha(registro[36])}", align: :justify
              pdf.move_down 10
              # Datos tomados fielmente de original
              pdf.text 'Datos tomados fielmente del original', align: :center
              pdf.move_down 30
              # Firma del párroco
              pdf.text '_______________________________', align: :center
              # Nombre del párroco
              pdf.text (registro[27]).to_s, align: :center
              # Parroco
              pdf.text 'Párroco', align: :center
            end
          when 'Comunión'
            pdf.move_down 20
            pdf.text 'CERTIFICADO DE PRIMERA COMUNIÓN', align: :center, size: 20, style: :bold,
                                                        color: 'FF0000'
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime('%d/%m/%Y'))}", align: :right
              pdf.move_down 20
              # Tomo, página y número justificado
              pdf.text "Yo, el infrascrito, certifico en legal forma a petición de la parte interesada que en el libro de comuniones de esta parroquia: Tomo #{registro[15]} - Página #{registro[16]} - Número #{registro[17]}, se halla inscrita la siguiente partida:",
                       align: :justify
              pdf.move_down 10
              # Fecha de comunión
              pdf.text "FECHA DE COMUNIÓN: #{cambiar_formato_fecha(registro[2])}.", align: :justify
              pdf.move_down 10
              # Lugar de comunión
              pdf.text "PARROQUIA: #{registro[25]}", align: :justify
              pdf.move_down 10
              # Sector
              pdf.text "SECTOR: #{registro[26]}.", align: :justify
              pdf.move_down 10
              # Celebrante
              pdf.text "CELEBRANTE: #{registro[3]}.", align: :justify
              pdf.move_down 10
              # Nombres
              pdf.text "NOMBRES: #{registro[19]}.", align: :justify
              pdf.move_down 10
              # Apellidos
              pdf.text "APELLIDOS: #{registro[20]}.", align: :justify
              pdf.move_down 10
              # Cerifica
              pdf.text "CERTIFICA: #{registro[4]}.", align: :justify
              pdf.move_down 10
              # Datos tomados fielmente de original
              pdf.text 'Datos tomados fielmente del original', align: :center
              pdf.move_down 40
              # Firma del párroco
              pdf.text '_______________________________', align: :center
              pdf.move_down 10
              # Nombre del párroco
              pdf.text (registro[27]).to_s, align: :center
              # Parroco
              pdf.text 'Párroco', align: :center
            end
          when 'Confirmación'
            pdf.move_down 20
            pdf.text 'CERTIFICADO DE CONFIRMACIÓN', align: :center, size: 20, style: :bold, color: 'FF0000'
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime('%d/%m/%Y'))}", align: :right
              pdf.move_down 20
              # Tomo, página y número justificado
              pdf.text "Yo, el infrascrito, certifico en legal forma a petición de la parte interesada que en el libro de confirmaciones de esta parroquia: Tomo #{registro[15]} - Página #{registro[16]} - Número #{registro[17]}, se halla inscrita la siguiente partida:",
                       align: :justify
              pdf.move_down 10
              # Fecha de confirmación
              pdf.text "FECHA DE CONFIRMACIÓN: #{cambiar_formato_fecha(registro[2])}.", align: :justify
              pdf.move_down 10
              # Celebrante
              pdf.text "CELEBRANTE: #{registro[3]}.", align: :justify
              pdf.move_down 10
              # Padrinos
              pdf.text "Fue su padrino: #{registro[5]} a quien se advirtió de sus obligaciones y parentezco espiritual.",
                       align: :justify
              pdf.move_down 10
              # Certifica
              pdf.text "CERTIFICA: #{registro[4]}.", align: :justify
              pdf.move_down 10
              # Datos tomados fielmente de original
              pdf.text 'Datos tomados fielmente del original', align: :center
              pdf.move_down 40
              # Firma del párroco
              pdf.text '_______________________________', align: :center
              pdf.move_down 10
              # Nombre del párroco
              pdf.text (registro[27]).to_s, align: :center
              # Parroco
              pdf.text 'Párroco', align: :center
            end
          when 'Matrimonio'
            pdf.move_down 20
            pdf.text 'CERTIFICADO DE MATRIMONIO', align: :center, size: 20, style: :bold, color: 'FF0000'
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime('%d/%m/%Y'))}", align: :right
              pdf.move_down 20
              # Tomo, página y número justificado
              pdf.text "Yo, el infrascrito, certifico en legal forma a petición de la parte interesada que en el libro de matrimonios de esta parroquia: Tomo #{registro[15]} - Página #{registro[16]} - Número #{registro[17]}, se halla inscrita la siguiente partida:",
                       align: :justify
              pdf.move_down 10
              # Fecha de matrimonio
              pdf.text "FECHA DE MATRIMONIO: #{cambiar_formato_fecha(registro[2])}.", align: :justify
              pdf.move_down 10
              # Datos del novio
              pdf.text "NOMBRES DEL NOVIO: #{registro[19]}.", align: :justify
              pdf.move_down 10
              pdf.text "APELLIDOS DEL NOVIO: #{registro[20]}.", align: :justify
              pdf.move_down 10
              # Datos de la novia
              pdf.text "NOMBRES DE LA NOVIA: #{registro[11]}.", align: :justify
              pdf.move_down 10
              pdf.text "APELLIDOS DE LA NOVIA: #{registro[12]}.", align: :justify
              pdf.move_down 10
              # Parroquia
              pdf.text "PARROQUIA: #{registro[25]}", align: :justify
              pdf.move_down 10
              # Sector
              pdf.text "SECTOR: #{registro[26]}.", align: :justify
              pdf.move_down 10
              # Celebrante
              pdf.text "CELEBRANTE: #{registro[3]}.", align: :justify
              # Feligreses de la parroquia
              pdf.text "Feligreses de la parroquia: #{registro[25]}.", align: :justify
              pdf.move_down 10
              # Testigos
              pdf.text "TESTIGOS: #{registro[7]} y #{registro[8]}.", align: :justify
              pdf.move_down 10
              # Cerifica
              pdf.text "CERTIFICA: #{registro[4]}.", align: :justify
              pdf.move_down 10
              # Registro civil
              pdf.text 'REGISTRO CIVIL', align: :center, size: 14, style: :bold
              pdf.move_down 10
              pdf.text "Provincia: #{registro[29]}, Cantón: #{registro[30]}, Parroquia: #{registro[31]}",
                       align: :justify
              pdf.text "Año: #{registro[32]}, Tomo: #{registro[33]}, Página: #{registro[34]}, Acta: #{registro[35]}",
                       align: :justify
              pdf.text "Fecha: #{cambiar_formato_fecha(registro[36])}", align: :justify
              pdf.move_down 10
              # Datos tomados fielmente de original
              pdf.text 'Datos tomados fielmente del original', align: :center
              pdf.move_down 30
              # Firma del párroco
              pdf.text '_______________________________', align: :center
              pdf.move_down 10
              # Nombre del párroco
              pdf.text (registro[27]).to_s, align: :center
              # Parroco
              pdf.text 'Párroco', align: :center
            end
          when 'Partida Supletoria del Bautismo'
            pdf.move_down 20
            pdf.text 'PARTIDA SUPLETORIA DEL BAUTISMO', align: :center, size: 20, style: :bold,
                                                                       color: 'FF0000'
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime('%d/%m/%Y'))}", align: :right
              pdf.move_down 20
              # Fecha de bautismo
              pdf.text "FECHA DE BAUTISMO: #{cambiar_formato_fecha(registro[2])}.", align: :justify
              pdf.move_down 10
              # Nombres
              pdf.text "NOMBRES: #{registro[19]}.", align: :justify
              pdf.move_down 10
              # Apellidos
              pdf.text "APELLIDOS: #{registro[20]}.", align: :justify
              pdf.move_down 10
              # Fecha de nacimiento
              pdf.text "LUGAR DE NACIMIENTO #{registro[21]}. FECHA DE NACIMIENTO: #{cambiar_formato_fecha(registro[22])}.",
                       align: :justify
              pdf.move_down 10
              # Padres
              pdf.text "Hijo/ja de #{registro[9]} y de #{registro[10]}.", align: :justify
              pdf.move_down 10
              # Padrinos
              pdf.text "Fueron sus padrinos: #{registro[5]} y #{registro[6]}.", align: :justify
              pdf.move_down 10
              # Registro civil
              pdf.text 'REGISTRO CIVIL', align: :center, size: 14, style: :bold
              pdf.move_down 10
              pdf.text "Provincia: #{registro[29]}, Cantón: #{registro[30]}, Parroquia: #{registro[31]}",
                       align: :justify
              pdf.text "Año: #{registro[32]}, Tomo: #{registro[33]}, Página: #{registro[34]}, Acta: #{registro[35]}",
                       align: :justify
              pdf.text "Fecha: #{cambiar_formato_fecha(registro[36])}", align: :justify
              pdf.move_down 10
              # Datos tomados fielmente de original
              pdf.text 'Datos tomados fielmente del original', align: :center
              pdf.move_down 40
              # Firmas padres y testigos
              pdf.text "PADRE: #{registro[9]} FIRMA: __________________", align: :center
              pdf.move_down 10
              pdf.text "MADRE: #{registro[10]} FIRMA: __________________", align: :center
              pdf.move_down 10
              pdf.text "TESTIGO 1): #{registro[7]} FIRMA: __________________", align: :center
              pdf.move_down 10
              pdf.text "TESTIGO 2): #{registro[8]} FIRMA: __________________", align: :center
              pdf.move_down 30
              # Firma del párroco
              pdf.text '_______________________________', align: :center
              pdf.move_down 10
              # Nombre del párroco
              pdf.text (registro[27]).to_s, align: :center
              # Parroco
              pdf.text 'Párroco', align: :center
            end
          when 'Curso Prebautismal'
            pdf.move_down 20
            pdf.text 'CERTIFICADO DEL CURSO PREBAUTISMAL', align: :center, size: 20, style: :bold,
                                                           color: 'FF0000'
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime('%d/%m/%Y'))}", align: :right
              pdf.move_down 20
              # Título
              pdf.text 'Rvdo. Padre', align: :justify
              pdf.move_down 10
              # Nombre del párroco
              pdf.text (registro[27]).to_s, align: :justify
              pdf.move_down 10
              # Parroquia
              pdf.text "Párroco de la Parroquia Eclesiástica \"#{registro[25]}\"", align: :justify
              pdf.move_down 10
              # Saludo
              pdf.text 'De mis consideraciones:', align: :justify
              pdf.move_down 10
              # Cuerpo
              pdf.text "Quien suscribe Padre #{registro[4]}, Párroco de la Parroquia Eclesiástica \"San Judas Tadeo\", CERTIFICA que #{registro[19]} #{registro[20]}, CI #{registro[23]} realizó la charla Pre - Bautismal en esta parroquia, para acompañar como padrino/madrina ............................. de ......................................................., bautizo que se realizará el #{cambiar_formato_fecha(registro[2])} en la parroquia antes mencionada.",
                       align: :justify
              pdf.move_down 10
              # Despedida
              pdf.text 'Es todo cuanto puedo certificar en honor a la verdad, pudiendo el peticionario hacer uso del presente certificado como ha bien tuviere',
                       align: :justify
              pdf.move_down 10
              pdf.text 'En Dios y María Santísima.', align: :justify
              pdf.move_down 30
              # Firma del párroco
              pdf.text '_______________________________', align: :center
              pdf.move_down 10
              # Nombre del párroco
              pdf.text (registro[4]).to_s, align: :center
              # Parroco
              pdf.text 'Párroco', align: :center
            end
          when 'Permiso de Bautismo'
            pdf.move_down 20
            pdf.text 'PERMISO DE BAUTISMO', align: :center, size: 20, style: :bold, color: 'FF0000'
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime('%d/%m/%Y'))}", align: :right
              pdf.move_down 20
              # Título
              pdf.text 'Rvdo. Padre', align: :justify
              pdf.move_down 10
              # Nombre del párroco
              pdf.text (registro[27]).to_s, align: :justify
              pdf.move_down 10
              # Parroquia
              pdf.text "Párroco de la Parroquia Eclesiástica \"#{registro[25]}\"", align: :justify
              pdf.move_down 10
              pdf.text 'Presente.', align: :justify
              pdf.move_down 10
              # Saludo
              pdf.text 'Reciba un afectuoso saludo.', align: :justify
              pdf.move_down 10
              # Cuerpo
              pdf.text "Por medio de la presente. Quien suscribe Padre #{registro[4]}, Párroco de la Parroquia Eclesiástica \"San Judas Tadeo\", AUTORIZO a #{registro[9]} CI .................. y a #{registro[10]} CI ...................., para que bauticen a su hijo/a #{registro[19]} #{registro[20]} CI #{registro[23]} y también a los padrinos #{registro[5]} y #{registro[6]}, bautizo que se realizará el #{cambiar_formato_fecha(registro[2])} en la parroquia antes mencionada.",
                       align: :justify
              pdf.move_down 10
              # Despedida
              pdf.text 'En Dios y María Santísima.', align: :justify
              pdf.move_down 30
              # Firma del párroco
              pdf.text '_______________________________', align: :center
              pdf.move_down 10
              # Nombre del párroco
              pdf.text (registro[4]).to_s, align: :center
              # Parroco
              pdf.text 'Párroco', align: :center
            end
          when 'Permiso de Matrimonio'
            pdf.move_down 20
            pdf.text 'PERMISO DE MATRIMONIO', align: :center, size: 20, style: :bold, color: 'FF0000'
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime('%d/%m/%Y'))}", align: :right
              pdf.move_down 20
              # Título
              pdf.text 'Rvdo. Padre', align: :justify
              pdf.move_down 10
              # Nombre del párroco
              pdf.text (registro[27]).to_s, align: :justify
              pdf.move_down 10
              # Parroquia
              pdf.text "Párroco de la Parroquia Eclesiástica \"#{registro[25]}\"", align: :justify
              pdf.move_down 10
              pdf.text 'Presente.', align: :justify
              pdf.move_down 10
              # Saludo
              pdf.text 'Reciba un afectuoso saludo.', align: :justify
              pdf.move_down 10
              # Cuerpo
              pdf.text "Por medio de la presente. Quien suscribe Padre #{registro[4]}, Párroco de la Parroquia Eclesiástica \"San Judas Tadeo\", AUTORIZO y habiéndose realizado los trámites canónicos para celebrar ante la Iglesia Católica el matrimonio de #{registro[19]} #{registro[20]} CI #{registro[23]} y de #{registro[11]} #{registro[12]} CI #{registro[14]} y también los testigos #{registro[7]} y #{registro[8]} para que contraigan matrimonio el #{cambiar_formato_fecha(registro[2])} en la parroquia antes mencionada.",
                       align: :justify
              pdf.move_down 10
              # Despedida
              pdf.text 'Es todo cuanto puedo certificar en honor a la verdad.', align: :justify
              pdf.move_down 10
              pdf.text 'En Dios y María Santísima.', align: :justify
              pdf.move_down 30
              # Firma del párroco
              pdf.text '_______________________________', align: :center
              pdf.move_down 10
              # Nombre del párroco
              pdf.text (registro[4]).to_s, align: :center
              # Parroco
              pdf.text 'Párroco', align: :center
            end
          when 'Licencia de Matrimonio'
            pdf.move_down 20
            pdf.text 'LICENCIA DE MATRIMONIO', align: :center, size: 20, style: :bold, color: 'FF0000'
            pdf.move_down 20
            registros_seleccionados.each do |registro|
              # Fecha actual alineada a la derecha
              pdf.text "Quito, #{cambiar_formato_fecha(Time.now.strftime('%d/%m/%Y'))}", align: :right
              pdf.move_down 20
              # Título
              pdf.text 'Zona Pastoral Norte', align: :justify
              pdf.move_down 10
              pdf.text "Ministerio Parroquial \"San Judas Tadeo\"", align: :justify
              pdf.move_down 10
              pdf.text 'Rvdo. Padre', align: :justify
              # Nombre del párroco
              pdf.text (registro[27]).to_s, align: :justify
              pdf.move_down 10
              # Parroquia
              pdf.text "Párroco de \"#{registro[25]}\" #{registro[26]}", align: :justify
              pdf.move_down 10
              pdf.text 'Presente.', align: :justify
              pdf.move_down 40
              # Cuerpo
              pdf.text "Habiendose realizado en este despacho parroquial las informaciones previas al matrimonio del Sr. #{registro[19]} #{registro[20]} C.I. #{registro[23]} con la Sra. #{registro[11]} #{registro[12]} C.I. #{registro[13]}. Feligreses de esta parroquia, San Judas Tadeo, sin que de lo actudo haya aparecido impedimento alguno, habiéndose así mismo realizado la dispensa de las tres moniciones canónicas, concedo a V. Reverencia la licencia prescrita por el canon 1115, para que dentro de esta jurisdicción parroquial precencia lícitamente y bendiga el sobredicho matrimonio, de lo que servirá notificar a esta parroquia con la incicación de la fecha y de los testigos.",
                        align: :justify
              pdf.move_down 40
              # Despedida
              pdf.text 'Dios N. S. guarde a V. Reverencia', align: :justify
              pdf.move_down 40
              # Firma del párroco
              pdf.text '_______________________________', align: :center
              pdf.move_down 10
              # Nombre del párroco
              pdf.text (registro[4]).to_s, align: :center
              # Parroco
              pdf.text 'PÁRROCO', align: :center
          end
        end
        # Abre el archivo PDF con el visor de PDF predeterminado del sistema
        system("xdg-open '#{@archivo_pdf}'")
      end
      # Mensaje de confirmación
      FXMessageBox.information(self, MBOX_OK, 'Información', 'El archivo PDF se ha generado correctamente')
    end

    @btnedit.connect(SEL_COMMAND) do
      # Editar registros seleccionados y actualizar la basee de datos
      registros_seleccionados.each do |registro|
        case registros_seleccionados[0][1]
        when 'Bautismo'
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id INNER JOIN misas ON parroquias.id = misas.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_bautismo'
            vtnactualizar_bautismo = ActualizarBautismo.new(@app, @registros)
            vtnactualizar_bautismo.create
            vtnactualizar_bautismo.show(PLACEMENT_SCREEN)
          end
        when 'Comunión'
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id INNER JOIN misas ON parroquias.id = misas.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_comunion'
            vtnactualizar_comunion = ActualizarComunion.new(@app, @registros)
            vtnactualizar_comunion.create
            vtnactualizar_comunion.show(PLACEMENT_SCREEN)
          end
        when 'Confirmación'
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id INNER JOIN misas ON parroquias.id = misas.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_confirmacion'
            vtnactualizar_confirmacion = ActualizarConfirmacion.new(@app, @registros)
            vtnactualizar_confirmacion.create
            vtnactualizar_confirmacion.show(PLACEMENT_SCREEN)
          end
        when 'Matrimonio'
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id INNER JOIN misas ON parroquias.id = misas.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_matrimonio'
            vtnactualizar_matrimonio = ActualizarMatrimonio.new(@app, @registros)
            vtnactualizar_matrimonio.create
            vtnactualizar_matrimonio.show(PLACEMENT_SCREEN)
          end
        when 'Partida Supletoria del Bautismo'
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id INNER JOIN misas ON parroquias.id = misas.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_supletoria'
            vtnactualizar_partida_supletoria_bautismo = ActualizarSupletoria.new(@app, @registros)
            vtnactualizar_partida_supletoria_bautismo.create
            vtnactualizar_partida_supletoria_bautismo.show(PLACEMENT_SCREEN)
          end
        when 'Curso Prebautismal'
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id INNER JOIN misas ON parroquias.id = misas.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_certificado_prebautismal'
            vtnactualizar_prebautismal = ActualizarPreBautismal.new(@app, @registros)
            vtnactualizar_prebautismal.create
            vtnactualizar_prebautismal.show(PLACEMENT_SCREEN)
          end
        when 'Permiso de Bautismo'
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id INNER JOIN misas ON parroquias.id = misas.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_permiso_prebautismal'
            vtnactualizar_permiso_bautismo = ActualizarPermisoBautismo.new(@app, @registros)
            vtnactualizar_permiso_bautismo.create
            vtnactualizar_permiso_bautismo.show(PLACEMENT_SCREEN)
          end
        when 'Permiso de Matrimonio'
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id INNER JOIN misas ON parroquias.id = misas.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_permiso_prematrimonial'
            vtnactualizar_permiso_matrimonio = ActualizarPreMatrimonial.new(@app, @registros)
            vtnactualizar_permiso_matrimonio.create
            vtnactualizar_permiso_matrimonio.show(PLACEMENT_SCREEN)
          end
        when 'Misa'
          # Obtenemos el registro de la base de datos
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id INNER JOIN misas ON parroquias.id = misas.id WHERE sacramentos.id = #{registro[0]}"
          $conn.exec(sql) do |result|
            @registros = result.values[0]
            # Abrimos la ventana de edición
            require_relative 'actualizar_misa'
            vtnactualizar_misa = ActualizarMisa.new(@app, @registros)
            vtnactualizar_misa.create
            vtnactualizar_misa.show(PLACEMENT_SCREEN)
          end
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
          # Eliminar registros de la base de datos
          case registros_seleccionados[0][1]
          when 'Bautismo'
            # Eliminar registros de la tabla sacramentos
            sql = "DELETE FROM sacramentos WHERE id = #{registro[0]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla libros
            sql = "DELETE FROM libros WHERE id = #{registro[14]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla creyentes
            sql = "DELETE FROM creyentes WHERE id = #{registro[18]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla parroquias
            sql = "DELETE FROM parroquias WHERE id = #{registro[24]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla registros_civiles
            sql = "DELETE FROM registros_civiles WHERE id = #{registro[28]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla misas
            sql = "DELETE FROM misas WHERE id = #{registro[37]}"
            $conn.exec(sql)
          when 'Comunión'
            # Eliminar registros de la tabla sacramentos
            sql = "DELETE FROM sacramentos WHERE id = #{registro[0]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla libros
            sql = "DELETE FROM libros WHERE id = #{registro[14]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla creyentes
            sql = "DELETE FROM creyentes WHERE id = #{registro[18]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla parroquias
            sql = "DELETE FROM parroquias WHERE id = #{registro[24]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla registros_civiles
            sql = "DELETE FROM registros_civiles WHERE id = #{registro[28]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla misas
            sql = "DELETE FROM misas WHERE id = #{registro[37]}"
            $conn.exec(sql)
          when 'Confirmación'
            # Eliminar registros de la tabla sacramentos
            sql = "DELETE FROM sacramentos WHERE id = #{registro[0]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla libros
            sql = "DELETE FROM libros WHERE id = #{registro[14]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla creyentes
            sql = "DELETE FROM creyentes WHERE id = #{registro[18]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla parroquias
            sql = "DELETE FROM parroquias WHERE id = #{registro[24]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla registros_civiles
            sql = "DELETE FROM registros_civiles WHERE id = #{registro[28]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla misas
            sql = "DELETE FROM misas WHERE id = #{registro[37]}"
            $conn.exec(sql)
          when 'Matrimonio'
            # Eliminar registros de la tabla sacramentos
            sql = "DELETE FROM sacramentos WHERE id = #{registro[0]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla libros
            sql = "DELETE FROM libros WHERE id = #{registro[14]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla creyentes
            sql = "DELETE FROM creyentes WHERE id = #{registro[18]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla parroquias
            sql = "DELETE FROM parroquias WHERE id = #{registro[24]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla registros_civiles
            sql = "DELETE FROM registros_civiles WHERE id = #{registro[28]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla misas
            sql = "DELETE FROM misas WHERE id = #{registro[37]}"
            $conn.exec(sql)
          when 'Partida Supletoria del Bautismo'
            # Eliminar registros de la tabla sacramentos
            sql = "DELETE FROM sacramentos WHERE id = #{registro[0]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla libros
            sql = "DELETE FROM libros WHERE id = #{registro[14]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla creyentes
            sql = "DELETE FROM creyentes WHERE id = #{registro[18]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla parroquias
            sql = "DELETE FROM parroquias WHERE id = #{registro[24]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla registros_civiles
            sql = "DELETE FROM registros_civiles WHERE id = #{registro[28]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla misas
            sql = "DELETE FROM misas WHERE id = #{registro[37]}"
            $conn.exec(sql)
          when 'Curso Prebautismal'
            # Eliminar registros de la tabla sacramentos
            sql = "DELETE FROM sacramentos WHERE id = #{registro[0]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla libros
            sql = "DELETE FROM libros WHERE id = #{registro[14]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla creyentes
            sql = "DELETE FROM creyentes WHERE id = #{registro[18]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla parroquias
            sql = "DELETE FROM parroquias WHERE id = #{registro[24]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla registros_civiles
            sql = "DELETE FROM registros_civiles WHERE id = #{registro[28]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla misas
            sql = "DELETE FROM misas WHERE id = #{registro[37]}"
            $conn.exec(sql)
          when 'Permiso de Bautismo'
            # Eliminar registros de la tabla sacramentos
            sql = "DELETE FROM sacramentos WHERE id = #{registro[0]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla libros
            sql = "DELETE FROM libros WHERE id = #{registro[14]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla creyentes
            sql = "DELETE FROM creyentes WHERE id = #{registro[18]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla parroquias
            sql = "DELETE FROM parroquias WHERE id = #{registro[24]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla registros_civiles
            sql = "DELETE FROM registros_civiles WHERE id = #{registro[28]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla misas
            sql = "DELETE FROM misas WHERE id = #{registro[37]}"
            $conn.exec(sql)
          when 'Permiso de Matrimonio'
            # Eliminar registros de la tabla sacramentos
            sql = "DELETE FROM sacramentos WHERE id = #{registro[0]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla libros
            sql = "DELETE FROM libros WHERE id = #{registro[14]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla creyentes
            sql = "DELETE FROM creyentes WHERE id = #{registro[18]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla parroquias
            sql = "DELETE FROM parroquias WHERE id = #{registro[24]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla registros_civiles
            sql = "DELETE FROM registros_civiles WHERE id = #{registro[28]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla misas
            sql = "DELETE FROM misas WHERE id = #{registro[37]}"
            $conn.exec(sql)
          when 'Misa'
            # Eliminar registros de la tabla sacramentos
            sql = "DELETE FROM sacramentos WHERE id = #{registro[0]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla libros
            sql = "DELETE FROM libros WHERE id = #{registro[14]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla creyentes
            sql = "DELETE FROM creyentes WHERE id = #{registro[18]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla parroquias
            sql = "DELETE FROM parroquias WHERE id = #{registro[24]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla registros_civiles
            sql = "DELETE FROM registros_civiles WHERE id = #{registro[28]}"
            $conn.exec(sql)
            # Eliminar registros de la tabla misas
            sql = "DELETE FROM misas WHERE id = #{registro[37]}"
            $conn.exec(sql)
          end
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
