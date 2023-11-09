require 'pg'
require 'fox16'
include Fox

class ActualizarMisa < FXMainWindow
  def initialize(app, registro)
    @registro = registro
    super(app, 'Parroquia San Judas Tadeo', width: 700, height: 370)
    self.backColor = FXRGB(3, 187, 133)
    # Title
    @lbltitle = FXLabel.new(self, 'Bienvenido a la Parroquia San Judas Tadeo',
                            opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700, height: 20, x: 0, y: 20)
    @lbltitle.font = FXFont.new(app, 'Geneva', 16, FONTWEIGHT_BOLD)
    @lbltitle.backColor = FXRGB(3, 187, 133)
    # Subtitle
    @lblsubtitle = FXLabel.new(self, 'ARQUIDIOSESIS DE QUITO - SERVICIO PARROQUIAL DE SAN JUDAS TADEO',
                               opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700, height: 20, x: 0, y: 40)
    @lblsubtitle.font = FXFont.new(app, 'Geneva', 10, FONTWEIGHT_BOLD)
    @lblsubtitle.backColor = FXRGB(3, 187, 133)
    # Date
    @date = Time.now.strftime('%d/%m/%Y')
    @lbldate = FXLabel.new(self, "Fecha: #{cambiar_formato_fecha(@date)}", opts: LAYOUT_EXPLICIT | JUSTIFY_RIGHT,
                                                                           width: 700, height: 20, x: 0, y: 60, padRight: 20)
    @lbldate.font = FXFont.new(app, 'Geneva', 12, FONTWEIGHT_BOLD)
    @lbldate.backColor = FXRGB(3, 187, 133)
    # section datos
    @lbl_sacramento = FXLabel.new(self, 'Sacramento: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                        x: 10, y: 150)
    @lbl_sacramento.backColor = FXRGB(3, 187, 133)
    @input_sacramento = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                  y: 150)
    @input_sacramento.text = @registro[1]
    @input_sacramento.disable
    @lbl_parroquia = FXLabel.new(self, 'Capilla: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                    y: 180)
    @lbl_parroquia.backColor = FXRGB(3, 187, 133)
    @input_parroquia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                 y: 180)
    @input_parroquia.text = @registro[25]
    @lbl_sector = FXLabel.new(self, 'Sector: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 330,
                                                y: 180)
    @lbl_sector.backColor = FXRGB(3, 187, 133)
    @input_sector = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 490,
                                              y: 180)
    @input_sector.text = @registro[26]
    @lbl_parroco = FXLabel.new(self, 'Celebranteo: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                      x: 10, y: 210)
    @lbl_parroco.backColor = FXRGB(3, 187, 133)
    @input_parroco = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                               y: 210)
    @input_parroco.text = @registro[27]
    @lbl_intencion = FXLabel.new(self, 'Intención: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                      y: 240)
    @lbl_intencion.backColor = FXRGB(3, 187, 133)
    @input_intencion = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                 y: 240)
    @input_intencion.text = @registro[38]
    @lbl_fecha = FXLabel.new(self, 'Fecha de la misa (AAAA/MM/DD): ', opts: LAYOUT_EXPLICIT, width: 250,
                                                                      height: 20, x: 10, y: 270)
    @lbl_fecha.backColor = FXRGB(3, 187, 133)
    @input_fecha = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 280,
                                             y: 270)
    @input_fecha.text = @registro[39]
    @lbl_hora = FXLabel.new(self, 'Hora (HH:MM): ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                    y: 300)
    @lbl_hora.backColor = FXRGB(3, 187, 133)
    @input_hora = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                            y: 300)
    @input_hora.text = @registro[40]

    # create buttons
    @btnupdate = FXButton.new(self, 'Actualizar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                  x: 480, y: 330)
    @btncancel = FXButton.new(self, 'Cancelar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                x: 590, y: 330)

    # connect buttons
    @btnupdate.connect(SEL_COMMAND) do
      sacramento = @input_sacramento.text.empty? ? nil : @input_sacramento.text
      capilla = @input_parroquia.text.empty? ? nil : @input_parroquia.text
      sector = @input_sector.text.empty? ? nil : @input_sector.text
      celebrante = @input_parroco.text.empty? ? nil : @input_parroco.text
      fecha_misa = @input_fecha.text.empty? ? nil : @input_fecha.text
      hora = @input_hora.text.empty? ? nil : @input_hora.text
      intencion = @input_intencion.text.empty? ? nil : @input_intencion.text

      # tables
      # tabla libros (id, tomo, pagina, numero)
      # tabla creyentes (id, nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula)
      # tabla parroquias (id, nombre, sector, parroco)
      # tabla sacramentos (id, nombre, fecha, celebrante, certifica, padrino, madrina, testigo_novio, testigo_novia, padre, madre, nombres_novia, apellidos_novia, cedula_novia, fk_creyentes, fk_parroquias, fk_registros_civiles, fk_libros)
      # tabla registros_civiles (id, provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc)
      # Iniciar una transacción
      $conn.transaction do
        # Actualizar la tabla misas
        $conn.exec('UPDATE misas SET intencion = $1, fecha = $2, hora = $3 WHERE id = $4',
                   [intencion, fecha_misa, hora, registro[37]])
        # Actualizar la tabla parroquias
        $conn.exec('UPDATE parroquias SET parroquia = $1, sector = $2, parroco = $3 WHERE id = $4',
                   [capilla, sector, celebrante, registro[24]])

        # Actualizar la tabla registros civiles, si no existen datos se crea un registro nuevo con id que corresponda y se llena los demaás datos con nil
        $conn.exec(
          'UPDATE registros_civiles SET provincia_rc = $1, canton_rc = $2, parroquia_rc = $3, anio_rc = $4, tomo_rc = $5, pagina_rc = $6, acta_rc = $7, fecha_rc = $8 WHERE id = $9', [
            nil, nil, nil, nil, nil, nil, nil, nil, registro[28]
          ]
        )

        # Actualizar la tabla sacramentos
        $conn.exec(
          'UPDATE sacramentos SET sacramento = $1, fecha = $2, celebrante = $3, certifica = $4, padrino = $5 WHERE id = $6', [
            sacramento, nil, nil, nil, nil, registro[0]
          ]
        )


        # ¿Desea guardar los cambios? SI: commit msg: datos actualizados correctamente, NO: rollback, close
        if FXMessageBox.question(self, MBOX_YES_NO, 'Pregunta', '¿Desea guardar los cambios?') == MBOX_CLICKED_YES
          # Confirmar la transacción
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
