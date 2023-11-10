# frozen_string_literal: true

require 'fox16'
include Fox

class ActualizarMatrimonio < FXMainWindow
  def initialize(app, registro)
    @registro = registro
    super(app, 'Parroquia San Judas Tadeo', width: 1050, height: 530)
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
    # section libros
    @lbl_tomo = FXLabel.new(self, 'Tomo', opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 50, y: 100)
    @lbl_tomo.backColor = FXRGB(3, 187, 133)
    # EL input tomoo debe tener el valor del campo "tomo" del registro
    @input_tomo = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 110, y: 100)
    @input_tomo.text = registro[19]

    @lbl_page = FXLabel.new(self, 'Pagina', opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 170, y: 100)
    @lbl_page.backColor = FXRGB(3, 187, 133)
    @input_page = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 230, y: 100)
    @input_page.text = registro[20]
    @lbl_number = FXLabel.new(self, 'Numero', opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 290,
                                              y: 100)
    @lbl_number.backColor = FXRGB(3, 187, 133)
    @input_number = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 350,
                                              y: 100)
    @input_number.text = registro[21]
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
    @lbl_celebrante = FXLabel.new(self, 'Celebrante: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                        x: 10, y: 210)
    @lbl_celebrante.backColor = FXRGB(3, 187, 133)
    @input_celebrante = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                  y: 210)
    @input_celebrante.text = @registro[3]
    @lbl_name_novio = FXLabel.new(self, 'Nombres del novio: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                               x: 10, y: 240)
    @lbl_name_novio.backColor = FXRGB(3, 187, 133)
    @input_name_novio = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                  y: 240)
    @input_name_novio.text = @registro[23]
    @lbl_apellido_novio = FXLabel.new(self, 'Apellidos del novio: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                     height: 20, x: 340, y: 240)
    @lbl_apellido_novio.backColor = FXRGB(3, 187, 133)
    @input_apellido_novio = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                      y: 240)
    @input_apellido_novio.text = @registro[24]
    @lbl_cedula_novio = FXLabel.new(self, 'Cédula del novio: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                                x: 680, y: 240)
    @lbl_cedula_novio.backColor = FXRGB(3, 187, 133)
    @input_cedula_novio = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                                    y: 240)
    @input_cedula_novio.text = @registro[27]
    @lbl_name_novia = FXLabel.new(self, 'Nombres de la novia: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                 height: 20, x: 10, y: 270)
    @lbl_name_novia.backColor = FXRGB(3, 187, 133)
    @input_name_novia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                  y: 270)
    @input_name_novia.text = @registro[11]
    @lbl_apellido_novia = FXLabel.new(self, 'Apellidos de la novia: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                       height: 20, x: 340, y: 270)
    @lbl_apellido_novia.backColor = FXRGB(3, 187, 133)
    @input_apellido_novia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                      y: 270)
    @input_apellido_novia.text = @registro[12]
    @lbl_cedula_novia = FXLabel.new(self, 'Cédula de la novia: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                  height: 20, x: 680, y: 270)
    @lbl_cedula_novia.backColor = FXRGB(3, 187, 133)
    @input_cedula_novia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                                    y: 270)
    @input_cedula_novia.text = @registro[13]
    @lbl_testigo_novio = FXLabel.new(self, 'Testigo del novio: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                  height: 20, x: 10, y: 300)
    @lbl_testigo_novio.backColor = FXRGB(3, 187, 133)
    @input_nombres_testigo_novio = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                             x: 170, y: 300)
    @input_nombres_testigo_novio.text = @registro[7]
    @lbl_testigo_novia = FXLabel.new(self, 'Testigo novia: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                              x: 340, y: 300)
    @lbl_testigo_novia.backColor = FXRGB(3, 187, 133)
    @input_nombres_testigo_novia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                             x: 510, y: 300)
    @input_nombres_testigo_novia.text = @registro[8]
    @lbl_certifica = FXLabel.new(self, 'Certifica: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                      x: 680, y: 300)
    @lbl_certifica.backColor = FXRGB(3, 187, 133)
    @input_certifica = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                                 y: 300)
    @input_certifica.text = @registro[4]
    # section registro civil
    @lbl_reg_civ = FXLabel.new(self,
                               '------------------------------------ REGISTRO CIVIL ------------------------------------', opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 1050, height: 20, x: 10, y: 330)
    @lbl_reg_civ.backColor = FXRGB(3, 187, 133)
    @lbl_provincia_rc = FXLabel.new(self, 'Provincia: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                         x: 10, y: 360)
    @lbl_provincia_rc.backColor = FXRGB(3, 187, 133)
    @input_provincia_rc = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                    y: 360)
    @input_provincia_rc.text = @registro[33]
    @lbl_canton_rc = FXLabel.new(self, 'Cantón: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                                   y: 360)
    @lbl_canton_rc.backColor = FXRGB(3, 187, 133)
    @input_canton_rc = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                 y: 360)
    @input_canton_rc.text = @registro[34]
    @lbl_parroquia_rc = FXLabel.new(self, 'Parroquia: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                         x: 680, y: 360)
    @lbl_parroquia_rc.backColor = FXRGB(3, 187, 133)
    @input_parroquia_rc = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                                    y: 360)
    @input_parroquia_rc.text = @registro[35]
    @lbl_anio_rc = FXLabel.new(self, 'Año: ', opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 50,
                                              y: 390)
    @lbl_anio_rc.backColor = FXRGB(3, 187, 133)
    @input_anio_rc = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 110,
                                               y: 390)
    @input_anio_rc.text = @registro[36]
    @lbl_tomo_rc = FXLabel.new(self, 'Tomo: ', opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 170,
                                               y: 390)
    @lbl_tomo_rc.backColor = FXRGB(3, 187, 133)
    @input_tomo_rc = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 230,
                                               y: 390)
    @input_tomo_rc.text = @registro[37]
    @lbl_pag_rc = FXLabel.new(self, 'Página: ', opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 290,
                                                y: 390)
    @lbl_pag_rc.backColor = FXRGB(3, 187, 133)
    @input_pag_rc = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 350,
                                              y: 390)
    @input_pag_rc.text = @registro[38]
    @lbl_acta_rc = FXLabel.new(self, 'Acta: ', opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 410,
                                               y: 390)
    @lbl_acta_rc.backColor = FXRGB(3, 187, 133)
    @input_acta_rc = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 470,
                                               y: 390)
    @input_acta_rc.text = @registro[39]
    @lbl_date_rc = FXLabel.new(self, 'Fecha (AAAA/MM/DD): ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                             x: 10, y: 420)
    @lbl_date_rc.backColor = FXRGB(3, 187, 133)
    @input_date_rc = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                               y: 420)
    @input_date_rc.text = @registro[40]

    # create buttons
    @btnupdate = FXButton.new(self, 'Actualizar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                  x: 790, y: 480)
    @btncancel = FXButton.new(self, 'Cancelar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                x: 900, y: 480)

    # connect buttons
    @btnupdate.connect(SEL_COMMAND) do
      tomo = @input_tomo.text.empty? ? nil : @input_tomo.text
      page = @input_page.text.empty? ? nil : @input_page.text
      number = @input_number.text.empty? ? nil : @input_number.text
      fecha = @input_fecha.text.empty? ? nil : @input_fecha.text
      sacramento = @input_sacramento.text.empty? ? nil : @input_sacramento.text
      parroquia = @input_parroquia.text.empty? ? nil : @input_parroquia.text
      sector = @input_sector.text.empty? ? nil : @input_sector.text
      parroco = @input_parroco.text.empty? ? nil : @input_parroco.text
      celebrante = @input_celebrante.text.empty? ? nil : @input_celebrante.text
      name_novio = @input_name_novio.text.empty? ? nil : @input_name_novio.text
      apellido_novio = @input_apellido_novio.text.empty? ? nil : @input_apellido_novio.text
      cedula_novio = @input_cedula_novio.text.empty? ? nil : @input_cedula_novio.text
      nombres_novia = @input_name_novia.text.empty? ? nil : @input_name_novia.text
      apellidos_novia = @input_apellido_novia.text.empty? ? nil : @input_apellido_novia.text
      cedula_novia = @input_cedula_novia.text.empty? ? nil : @input_cedula_novia.text
      testigo_novio = @input_nombres_testigo_novio.text.empty? ? nil : @input_nombres_testigo_novio.text
      testigo_novia = @input_nombres_testigo_novia.text.empty? ? nil : @input_nombres_testigo_novia.text
      certifica = @input_certifica.text.empty? ? nil : @input_certifica.text
      provincia_rc = @input_provincia_rc.text.empty? ? nil : @input_provincia_rc.text
      canton_rc = @input_canton_rc.text.empty? ? nil : @input_canton_rc.text
      parroquia_rc = @input_parroquia_rc.text.empty? ? nil : @input_parroquia_rc.text
      anio_rc = @input_anio_rc.text.empty? ? nil : @input_anio_rc.text
      tomo_rc = @input_tomo_rc.text.empty? ? nil : @input_tomo_rc.text
      pagina_rc = @input_pag_rc.text.empty? ? nil : @input_pag_rc.text
      acta_rc = @input_acta_rc.text.empty? ? nil : @input_acta_rc.text
      fecha_rc = @input_date_rc.text.empty? ? nil : @input_date_rc.text

      # tables
      # tabla libros (id, tomo, pagina, numero)
      # tabla creyentes (id, nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula)
      # tabla parroquias (id, nombre, sector, parroco)
      # tabla sacramentos (id, nombre, fecha, celebrante, certifica, padrino, madrina, testigo_novio, testigo_novia, padre, madre, nombres_novia, apellidos_novia, cedula_novia, fk_creyentes, fk_parroquias, fk_registros_civiles, fk_libros)
      # tabla registros_civiles (id, provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc)
      $conn.transaction do
        $conn.exec('UPDATE libros SET tomo = $1, pagina = $2, numero = $3 WHERE id = $4',
                   [tomo, page, number, registro[18]])
        $conn.exec(
          'UPDATE sacramentos SET sacramento = $1, fecha = $2, celebrante = $3, certifica = $4, testigo_novio = $5, testigo_novia = $6, nombres_novia = $7, apellidos_novia = $8, cedula_novia = $9 WHERE id = $10', [
            sacramento, fecha, celebrante, certifica, testigo_novio, testigo_novia, nombres_novia, apellidos_novia, cedula_novia, registro[0]
          ]
        )
        $conn.exec('UPDATE creyentes SET nombres = $1, apellidos = $2, cedula = $3 WHERE id = $4',
                   [name_novio, apellido_novio, cedula_novio, registro[22]])
        $conn.exec('UPDATE parroquias SET parroquia = $1, sector = $2, parroco = $3 WHERE id = $4',
                   [parroquia, sector, parroco, registro[28]])
        $conn.exec(
          'UPDATE registros_civiles SET provincia_rc = $1, canton_rc = $2, parroquia_rc = $3, anio_rc = $4, tomo_rc = $5, pagina_rc = $6, acta_rc = $7, fecha_rc = $8 WHERE id = $9', [
            provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc, registro[32]
          ]
        )

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
