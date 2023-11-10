# frozen_string_literal: true

require 'fox16'
include Fox

class ActualizarPreMatrimonial < FXMainWindow
  def initialize(app, registro)
    @registro = registro
    super(app, 'Parroquia San Judas Tadeo', width: 1050, height: 360)
    self.backColor = FXRGB(3, 187, 133)
    # Title
    @lbltitle = FXLabel.new(self, 'Bienvenido a la Parroquia San Judas Tadeo',
                            opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 1050, height: 20, x: 0, y: 20)
    @lbltitle.font = FXFont.new(app, 'Geneva', 16, FONTWEIGHT_BOLD)
    @lbltitle.backColor = FXRGB(3, 187, 133)
    # Subtitle
    @lblsubtitle = FXLabel.new(self, 'ARQUIDIOSESIS DE QUITO - SERVICIO PARROQUIAL DE SAN JUDAS TADEO',
                               opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 1050, height: 20, x: 0, y: 40)
    @lblsubtitle.font = FXFont.new(app, 'Geneva', 10, FONTWEIGHT_BOLD)
    @lblsubtitle.backColor = FXRGB(3, 187, 133)
    # Date
    @date = Time.now.strftime('%d/%m/%Y')
    @lbldate = FXLabel.new(self, "Fecha: #{cambiar_formato_fecha(@date)}", opts: LAYOUT_EXPLICIT | JUSTIFY_RIGHT,
                                                                           width: 1050, height: 20, x: 0, y: 60, padRight: 20)
    @lbldate.font = FXFont.new(app, 'Geneva', 12, FONTWEIGHT_BOLD)
    @lbldate.backColor = FXRGB(3, 187, 133)

    # section datos
    @lbl_fecha = FXLabel.new(self, 'Fecha de matrimonio (AAAA/MM/DD): ', opts: LAYOUT_EXPLICIT, width: 250,
                                                                         height: 20, x: 10, y: 150)
    @lbl_fecha.backColor = FXRGB(3, 187, 133)
    @input_fecha = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                             y: 150)
    @input_fecha.text = @registro[2]
    @lbl_sacramento = FXLabel.new(self, 'Sacramento: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                        x: 680, y: 150)
    @lbl_sacramento.backColor = FXRGB(3, 187, 133)
    @input_sacramento = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                                  y: 150)
    @input_sacramento.text = @registro[1]
    @input_sacramento.disable
    @lbl_parroquia = FXLabel.new(self, 'Iglesia parroquial: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                               x: 10, y: 180)
    @lbl_parroquia.backColor = FXRGB(3, 187, 133)
    @input_parroquia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                 y: 180)
    @input_parroquia.text = @registro[29]
    @lbl_sector = FXLabel.new(self, 'Sector: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                                y: 180)
    @lbl_sector.backColor = FXRGB(3, 187, 133)
    @input_sector = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                              y: 180)
    @input_sector.text = @registro[30]
    @lbl_parroco = FXLabel.new(self, 'Parroco: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 680,
                                                  y: 180)
    @lbl_parroco.backColor = FXRGB(3, 187, 133)
    @input_parroco = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                               y: 180)
    @input_parroco.text = @registro[31]
    @lbl_name_novio = FXLabel.new(self, 'Nombres del novio: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                               x: 10, y: 210)
    @lbl_name_novio.backColor = FXRGB(3, 187, 133)
    @input_name_novio = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                  y: 210)
    @input_name_novio.text = @registro[23]
    @lbl_apellido_novio = FXLabel.new(self, 'Apellidos del novio: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                     height: 20, x: 340, y: 210)
    @lbl_apellido_novio.backColor = FXRGB(3, 187, 133)
    @input_apellido_novio = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                      y: 210)
    @input_apellido_novio.text = @registro[24]
    @lbl_cedula_novio = FXLabel.new(self, 'Cédula del novio: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                                x: 680, y: 210)
    @lbl_cedula_novio.backColor = FXRGB(3, 187, 133)
    @input_cedula_novio = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                                    y: 210)
    @input_cedula_novio.text = @registro[27]
    @lbl_name_novia = FXLabel.new(self, 'Nombres de la novia: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                 height: 20, x: 10, y: 240)
    @lbl_name_novia.backColor = FXRGB(3, 187, 133)
    @input_name_novia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                  y: 240)
    @input_name_novia.text = @registro[11]
    @lbl_apellido_novia = FXLabel.new(self, 'Apellidos de la novia: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                       height: 20, x: 340, y: 240)
    @lbl_apellido_novia.backColor = FXRGB(3, 187, 133)
    @input_apellido_novia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                      y: 240)
    @input_apellido_novia.text = @registro[12]
    @lbl_cedula_novia = FXLabel.new(self, 'Cédula de la novia: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                  height: 20, x: 680, y: 240)
    @lbl_cedula_novia.backColor = FXRGB(3, 187, 133)
    @input_cedula_novia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                                    y: 240)
    @input_cedula_novia.text = @registro[13]
    @lbl_testigo_novio = FXLabel.new(self, 'Testigo del novio: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                  height: 20, x: 10, y: 270)
    @lbl_testigo_novio.backColor = FXRGB(3, 187, 133)
    @input_nombres_testigo_novio = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                             x: 170, y: 270)
    @input_nombres_testigo_novio.text = @registro[7]
    @lbl_testigo_novia = FXLabel.new(self, 'Testigo novia: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                              x: 340, y: 270)
    @lbl_testigo_novia.backColor = FXRGB(3, 187, 133)
    @input_nombres_testigo_novia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                             x: 510, y: 270)
    @input_nombres_testigo_novia.text = @registro[8]
    @lbl_certifica = FXLabel.new(self, 'Certifica: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                      x: 680, y: 270)
    @lbl_certifica.backColor = FXRGB(3, 187, 133)
    @input_certifica = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                                 y: 270)
    @input_certifica.text = @registro[4]

    # create buttons
    @btnupdate = FXButton.new(self, 'Actualizar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                  x: 790, y: 300)
    @btncancel = FXButton.new(self, 'Cancelar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                x: 900, y: 300)

    # connect buttons
    @btnupdate.connect(SEL_COMMAND) do
      fecha = @input_fecha.text.empty? ? nil : @input_fecha.text
      sacramento = @input_sacramento.text.empty? ? nil : @input_sacramento.text
      parroquia = @input_parroquia.text.empty? ? nil : @input_parroquia.text
      sector = @input_sector.text.empty? ? nil : @input_sector.text
      parroco = @input_parroco.text.empty? ? nil : @input_parroco.text
      name_novio = @input_name_novio.text.empty? ? nil : @input_name_novio.text
      apellido_novio = @input_apellido_novio.text.empty? ? nil : @input_apellido_novio.text
      cedula_novio = @input_cedula_novio.text.empty? ? nil : @input_cedula_novio.text
      nombres_novia = @input_name_novia.text.empty? ? nil : @input_name_novia.text
      apellidos_novia = @input_apellido_novia.text.empty? ? nil : @input_apellido_novia.text
      cedula_novia = @input_cedula_novia.text.empty? ? nil : @input_cedula_novia.text
      testigo_novio = @input_nombres_testigo_novio.text.empty? ? nil : @input_nombres_testigo_novio.text
      testigo_novia = @input_nombres_testigo_novia.text.empty? ? nil : @input_nombres_testigo_novia.text
      certifica = @input_certifica.text.empty? ? nil : @input_certifica.text

      # tables
      # tabla libros (id, tomo, pagina, numero)
      # tabla creyentes (id, nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula)
      # tabla parroquias (id, nombre, sector, parroco)
      # tabla sacramentos (id, nombre, fecha, celebrante, certifica, padrino, madrina, testigo_novio, testigo_novia, padre, madre, nombres_novia, apellidos_novia, cedula_novia, fk_creyentes, fk_parroquias, fk_registros_civiles, fk_libros)
      # tabla registros_civiles (id, provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc)
      $conn.transaction do
        $conn.exec(
          'UPDATE sacramentos SET sacramento = $1, fecha = $2, certifica = $3, testigo_novio = $4, testigo_novia = $5, nombres_novia = $6, apellidos_novia = $7, cedula_novia = $8 WHERE id = $10', [
            sacramento, fecha, certifica, testigo_novio, testigo_novia, nombres_novia, apellidos_novia, cedula_novia, registro[0]
          ]
        )
        $conn.exec('UPDATE creyentes SET nombres = $1, apellidos = $2, cedula = $3 WHERE id = $4',
                   [name_novio, apellido_novio, cedula_novio, registro[18]])
        $conn.exec('UPDATE parroquias SET parroquia = $1, sector = $2, parroco = $3 WHERE id = $4',
                   [parroquia, sector, parroco, registro[24]])

        # ¿Desea guardar los cambios? SI: commit msg: datos actualizados correctamente, NO: rollback, close
        if FXMessageBox.question(self, MBOX_YES_NO, 'Pregunta', '¿Desea guardar los cambios?') == MBOX_CLICKED_YES
          $conn.exec('COMMIT')
          FXMessageBox.information(self, MBOX_OK, 'Información', 'Datos actualizados correctamente')
        else
          $conn.exec('ROLLBACK')
        end
        close
      end
    end

    @btncancel.connect(SEL_COMMAND) do
      FXMessageBox.warning(self, MBOX_OK, 'Advertencia', 'No se guardarán los cambios')
      close
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

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
