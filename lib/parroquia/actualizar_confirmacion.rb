require 'pg'
require 'fox16'
include Fox

class ActualizarConfirmacion < FXMainWindow
  def initialize(app, registro)
    @registro = registro
    super(app, "Parroquia San Judas Tadeo", :width => 1050, :height => 450)
    self.backColor = FXRGB(3,187,133)
    # Title
    @lbltitle = FXLabel.new(self, "Bienvenido a la Parroquia San Judas Tadeo", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 1050, :height => 20, :x => 0, :y => 20)
    @lbltitle.font = FXFont.new(app, "Geneva", 16, FONTWEIGHT_BOLD)
    @lbltitle.backColor = FXRGB(3,187,133)
    # Subtitle
    @lblsubtitle = FXLabel.new(self, "ARQUIDIOSESIS DE QUITO - SERVICIO PARROQUIAL DE SAN JUDAS TADEO", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 1050, :height => 20, :x => 0, :y => 40)
    @lblsubtitle.font = FXFont.new(app, "Geneva", 10, FONTWEIGHT_BOLD)
    @lblsubtitle.backColor = FXRGB(3,187,133)
    # Date
    @date = Time.now.strftime("%d/%m/%Y")
    @lbldate = FXLabel.new(self, "Fecha: #{cambiar_formato_fecha(@date)}", :opts => LAYOUT_EXPLICIT|JUSTIFY_RIGHT, :width => 1050, :height => 20, :x => 0, :y => 60, :padRight => 20)
    @lbldate.font = FXFont.new(app, "Geneva", 12, FONTWEIGHT_BOLD)
    @lbldate.backColor = FXRGB(3,187,133)
    # section libros
    @lbl_tomo = FXLabel.new(self, "Tomo", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 50, :y => 100)
    @lbl_tomo.backColor = FXRGB(3,187,133)
    # EL input tomoo debe tener el valor del campo "tomo" del registro
    @input_tomo = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 110, :y => 100)
    @input_tomo.text = registro[15]

    @lbl_page = FXLabel.new(self, "Pagina", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 170, :y => 100)
    @lbl_page.backColor = FXRGB(3,187,133)
    @input_page = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 230, :y => 100)
    @input_page.text = registro[16]
    @lbl_number = FXLabel.new(self, "Numero", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 290, :y => 100)
    @lbl_number.backColor = FXRGB(3,187,133)
    @input_number = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 350, :y => 100)
    @input_number.text = registro[17]
    #section datos
    @lbl_fecha = FXLabel.new(self, "Fecha de confirmación (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 250, :height => 20, :x => 10, :y => 150)
    @lbl_fecha.backColor = FXRGB(3,187,133)
    @input_fecha = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 340, :y => 150)
    @input_fecha.text = @registro[2]
    @lbl_sacramento = FXLabel.new(self, "Sacramento: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 150)
    @lbl_sacramento.backColor = FXRGB(3,187,133)
    @input_sacramento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 150)
    @input_sacramento.text = @registro[1]
    @input_sacramento.disable
    @lbl_parroquia = FXLabel.new(self, "Iglesia parroquial: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 180)
    @lbl_parroquia.backColor = FXRGB(3,187,133)
    @input_parroquia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 180)
    @input_parroquia.text = @registro[25]
    @lbl_sector = FXLabel.new(self, "Sector: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 180)
    @lbl_sector.backColor = FXRGB(3,187,133)
    @input_sector = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 180)
    @input_sector.text = @registro[26]
    @lbl_parroco = FXLabel.new(self, "Parroco: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 180)
    @lbl_parroco.backColor = FXRGB(3,187,133)
    @input_parroco = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 180)
    @input_parroco.text = @registro[27]
    @lbl_celebrante = FXLabel.new(self, "Celebrante: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 210)
    @lbl_celebrante.backColor = FXRGB(3,187,133)
    @input_celebrante = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 210)
    @input_celebrante.text = @registro[3]
    @lbl_name = FXLabel.new(self, "Nombres: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 240)
    @lbl_name.backColor = FXRGB(3,187,133)
    @input_name = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 240)
    @input_name.text = @registro[19]
    @lbl_apellidos = FXLabel.new(self, "Apellidos: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 270)
    @lbl_apellidos.backColor = FXRGB(3,187,133)
    @input_apellidos = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 270)
    @input_apellidos.text = @registro[20]
    @lbl_lugar_nacimiento = FXLabel.new(self, "Lugar de nacimiento: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 300)
    @lbl_lugar_nacimiento.backColor = FXRGB(3,187,133)
    @input_lugar_nacimiento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 300)
    @input_lugar_nacimiento.text = @registro[21]
    @lbl_fecha_nacimiento = FXLabel.new(self, "Fecha de nacimiento (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 250, :height => 20, :x => 340, :y => 300)
    @lbl_fecha_nacimiento.backColor = FXRGB(3,187,133)
    @input_fecha_nacimiento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 590, :y => 300)
    @input_fecha_nacimiento.text = @registro[22]
    @lbl_cedula = FXLabel.new(self, "Cédula: ", :opts => LAYOUT_EXPLICIT, :width => 80, :height => 20, :x => 750, :y => 300)
    @lbl_cedula.backColor = FXRGB(3,187,133)
    @input_cedula = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x =>850, :y => 300)
    @input_cedula.text = @registro[23]
    @lbl_padrino = FXLabel.new(self, "Padrino: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 330)
    @lbl_padrino.backColor = FXRGB(3,187,133)
    @input_padrino = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 330)
    @input_padrino.text = @registro[5]
    @lbl_certifica = FXLabel.new(self, "Certifica: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 360)
    @lbl_certifica.backColor = FXRGB(3,187,133)
    @input_certifica = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 360)
    @input_certifica.text = @registro[4]
    # create buttons
    @btnupdate = FXButton.new(self, "Actualizar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 790, :y => 400)
    @btncancel = FXButton.new(self, "Cancelar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 900, :y => 400)

    # connect buttons
    @btnupdate.connect(SEL_COMMAND) do
      tomo = @input_tomo.text
      page = @input_page.text
      number = @input_number.text
      fecha = @input_fecha.text
      sacramento = @input_sacramento.text
      parroquia = @input_parroquia.text
      sector = @input_sector.text
      parroco = @input_parroco.text
      celebrante = @input_celebrante.text
      name = @input_name.text
      apellidos = @input_apellidos.text
      lugar_nacimiento = @input_lugar_nacimiento.text
      fecha_nacimiento = @input_fecha_nacimiento.text
      cedula = @input_cedula.text.empty? ? nil : @input_cedula.text
      padrino = @input_padrino.text.empty? ? nil : @input_padrino.text
      certifica = @input_certifica.text

      # tables
        # tabla libros (id, tomo, pagina, numero)
        # tabla creyentes (id, nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula)
        # tabla parroquias (id, nombre, sector, parroco)
        # tabla sacramentos (id, nombre, fecha, celebrante, certifica, padrino, madrina, testigo_novio, testigo_novia, padre, madre, nombres_novia, apellidos_novia, cedula_novia, fk_creyentes, fk_parroquias, fk_registros_civiles, fk_libros)
        # tabla registros_civiles (id, provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc)
      # Iniciar una transacción
      $conn.transaction do
        # Actualizar la tabla libros
        $conn.exec('UPDATE libros SET tomo = $1, pagina = $2, numero = $3 WHERE id = $4', [tomo, page, number, registro[14]])

        # Actualizar la tabla creyentes
        $conn.exec('UPDATE creyentes SET nombres = $1, apellidos = $2, lugar_nacimiento = $3, fecha_nacimiento = $4, cedula = $5 WHERE id = $6', [name, apellidos, lugar_nacimiento, fecha_nacimiento, cedula, registro[18]])

        # Actualizar la tabla parroquias
        $conn.exec('UPDATE parroquias SET parroquia = $1, sector = $2, parroco = $3 WHERE id = $4', [parroquia, sector, parroco, registro[24]])

        # Actualizar la tabla registros civiles, si no existen datos se crea un registro nuevo con id que corresponda y se llena los demaás datos con nil
        $conn.exec('UPDATE registros_civiles SET provincia_rc = $1, canton_rc = $2, parroquia_rc = $3, anio_rc = $4, tomo_rc = $5, pagina_rc = $6, acta_rc = $7, fecha_rc = $8 WHERE id = $9', [nil, nil, nil, nil, nil, nil, nil, nil, registro[28]])

        # Actualizar la tabla sacramentos
        $conn.exec('UPDATE sacramentos SET sacramento = $1, fecha = $2, celebrante = $3, certifica = $4, padrino = $5 WHERE id = $6', [sacramento, fecha, celebrante, certifica, padrino, registro[0]])


        # ¿Desea guardar los cambios? SI: commit msg: datos actualizados correctamente, NO: rollback, close
        if FXMessageBox.question(self, MBOX_YES_NO, "Pregunta", "¿Desea guardar los cambios?") == MBOX_CLICKED_YES
          # Confirmar la transacción
          $conn.exec("COMMIT")
          FXMessageBox.information(self, MBOX_OK, "Información", "Datos actualizados correctamente")
          close
        else
          $conn.exec("ROLLBACK")
          close
        end
      end
    end

    @btncancel.connect(SEL_COMMAND) do
      FXMessageBox.warning(self, MBOX_OK, "Advertencia", "No se guardarán los cambios")
      close
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


  # Cambiar el formato de la fecha de YYYY-MM-DD a DD de nombre_mes de YYYY
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

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
