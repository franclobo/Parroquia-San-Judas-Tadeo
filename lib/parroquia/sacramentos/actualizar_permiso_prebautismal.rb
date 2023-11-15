# frozen_string_literal: true

require 'fox16'
require 'date'
include Fox

class ActualizarPermisoBautismo < FXMainWindow
  def initialize(app, registro)
    super(app, 'Editando Registro', width: 1050, height: 430)
    self.backColor = FXRGB(3, 187, 133)
    @registro = registro
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
    @lbl_fecha = FXLabel.new(self, 'Fecha de bautismo (AAAA/MM/DD): ', opts: LAYOUT_EXPLICIT, width: 250,
                                                                       height: 20, x: 10, y: 150)
    @lbl_fecha.backColor = FXRGB(3, 187, 133)
    @input_fecha = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                             y: 150)
    @input_fecha.text = registro[2]
    @lbl_sacramento = FXLabel.new(self, 'Sacramento: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                        x: 680, y: 150)
    @lbl_sacramento.backColor = FXRGB(3, 187, 133)
    @input_sacramento = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                                  y: 150)
    @input_sacramento.text = registro[1]
    @input_sacramento.disable
    @lbl_parroquia = FXLabel.new(self, 'Iglesia parroquial: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                               x: 10, y: 180)
    @lbl_parroquia.backColor = FXRGB(3, 187, 133)
    @input_parroquia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                 y: 180)
    @input_parroquia.text = registro[29]
    @lbl_sector = FXLabel.new(self, 'Sector: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                                y: 180)
    @lbl_sector.backColor = FXRGB(3, 187, 133)
    @input_sector = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                              y: 180)
    @input_sector.text = registro[30]
    @lbl_parroco = FXLabel.new(self, 'Parroco: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 680,
                                                  y: 180)
    @lbl_parroco.backColor = FXRGB(3, 187, 133)
    @input_parroco = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                               y: 180)
    @input_parroco.text = registro[31]
    @lbl_name = FXLabel.new(self, 'Nombres: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                               y: 210)
    @lbl_name.backColor = FXRGB(3, 187, 133)
    @input_name = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170, y: 210)
    @input_name.text = registro[23]
    @lbl_apellidos = FXLabel.new(self, 'Apellidos: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                      x: 340, y: 210)
    @lbl_apellidos.backColor = FXRGB(3, 187, 133)
    @input_apellidos = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                 y: 210)
    @input_apellidos.text = registro[24]
    @lbl_cedula = FXLabel.new(self, 'Cédula: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 680,
                                                y: 210)
    @lbl_cedula.backColor = FXRGB(3, 187, 133)
    @input_cedula = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                              y: 210)
    @input_cedula.text = registro[27]
    @lbl_padre = FXLabel.new(self, 'Padre: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                              y: 240)
    @lbl_padre.backColor = FXRGB(3, 187, 133)
    @input_padre = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                             y: 240)
    @input_padre.text = registro[9]
    @lbl_cedula_padre = FXLabel.new(self, 'Cédula del padre: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                                      y: 240)
    @lbl_cedula_padre.backColor = FXRGB(3, 187, 133)
    @input_cedula_padre = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                  y: 240)
    @input_cedula_padre.text = registro[16]
    @lbl_madre = FXLabel.new(self, 'Madre: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                              y: 270)
    @lbl_madre.backColor = FXRGB(3, 187, 133)
    @input_madre = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                             y: 270)
    @input_madre.text = registro[10]
    @lbl_cedula_madre = FXLabel.new(self, 'Cédula de la madre: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                                      y: 270)
    @lbl_cedula_madre.backColor = FXRGB(3, 187, 133)
    @input_cedula_madre = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                  y: 270)
    @input_cedula_madre.text = registro[17]
    @lbl_padrino = FXLabel.new(self, 'Padrino: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                  y: 300)
    @lbl_padrino.backColor = FXRGB(3, 187, 133)
    @input_padrino = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                               y: 300)
    @input_padrino.text = registro[5]
    @lbl_cedula_padrino = FXLabel.new(self, 'Cédula del padrino: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                                      y: 300)
    @lbl_cedula_padrino.backColor = FXRGB(3, 187, 133)
    @input_cedula_padrino = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                  y: 300)
    @input_cedula_padrino.text = registro[14]
    @lbl_madrina = FXLabel.new(self, 'Madrina: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                  y: 330)
    @lbl_madrina.backColor = FXRGB(3, 187, 133)
    @input_madrina = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                               y: 330)
    @input_madrina.text = registro[6]
    @lbl_cedula_madrina = FXLabel.new(self, 'Cédula de la madrina: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                                      y: 330)
    @lbl_cedula_madrina.backColor = FXRGB(3, 187, 133)
    @input_cedula_madrina = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                  y: 330)
    @input_cedula_madrina.text = registro[15]
    @lbl_certifica = FXLabel.new(self, 'Autoriza: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                      y: 360)
    @lbl_certifica.backColor = FXRGB(3, 187, 133)
    @input_certifica = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                 y: 360)
    @input_certifica.text = registro[4]

    # create buttons
    @btnupdate = FXButton.new(self, 'Actualizar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                  x: 790, y: 390)
    @btncancel = FXButton.new(self, 'Cancelar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                x: 900, y: 390)

    # connect buttons
    @btnupdate.connect(SEL_COMMAND) do
      fecha = @input_fecha.text.empty? ? nil : @input_fecha.text
      sacramento = @input_sacramento.text.empty? ? nil : @input_sacramento.text
      parroquia = @input_parroquia.text.empty? ? nil : @input_parroquia.text
      sector = @input_sector.text.empty? ? nil : @input_sector.text
      parroco = @input_parroco.text.empty? ? nil : @input_parroco.text
      name = @input_name.text.empty? ? nil : @input_name.text
      apellidos = @input_apellidos.text.empty? ? nil : @input_apellidos.text
      cedula = @input_cedula.text.empty? ? nil : @input_cedula.text
      padrino = @input_padrino.text.empty? ? nil : @input_padrino.text
      madrina = @input_madrina.text.empty? ? nil : @input_madrina.text
      padre = @input_padre.text.empty? ? nil : @input_padre.text
      madre = @input_madre.text.empty? ? nil : @input_madre.text
      cedula_padre = @input_cedula_padre.text.empty? ? nil : @input_cedula_padre.text
      cedula_madre = @input_cedula_madre.text.empty? ? nil : @input_cedula_madre.text
      cedula_padrino = @input_cedula_padrino.text.empty? ? nil : @input_cedula_padrino.text
      cedula_madrina = @input_cedula_madrina.text.empty? ? nil : @input_cedula_madrina.text
      certifica = @input_certifica.text.empty? ? nil : @input_certifica.text


      # tables
      # tabla libros (id, tomo, pagina, numero)
      # tabla creyentes (id, nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula)
      # tabla parroquias (id, nombre, sector, parroco)
      # tabla sacramentos (id, nombre, fecha, celebrante, certifica, padrino, madrina, testigo_novio, testigo_novia, padre, madre, nombres_novia, apellidos_novia, cedula_novia, fk_creyentes, fk_parroquias, fk_registros_civiles, fk_libros)
      # tabla registros_civiles (id, provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc)
      # Iniciar una transacción

      def validar_formato_fecha(fecha)
        begin
          Date.strptime(fecha, '%Y/%m/%d' || '%Y-%m-%d')
          return true
        rescue ArgumentError
          return false
        end
      end

      if validar_formato_fecha(fecha)
        $conn.transaction do
          $conn.exec(
            'UPDATE sacramentos SET fecha = $1, sacramento = $2, certifica = $3, padrino = $4, madrina = $5, padre = $6, madre = $7, cedula_padrino = $8, cedula_madrina = $9, cedula_padre = $10, cedula_madre = $11 WHERE id = $12',
              fecha, sacramento, certifica, padrino, madrina, padre, madre, cedula_padrino, cedula_madrina, cedula_padre, cedula_madre, registro[0])
          $conn.exec('UPDATE creyentes SET nombres = $1, apellidos = $2, cedula = $3 WHERE id = $6',
                    [name, apellidos, cedula, registro[22]])
          $conn.exec('UPDATE parroquias SET parroquia = $1, sector = $2, parroco = $3 WHERE id = $4',
                    [parroquia, sector, parroco, registro[28]])

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
      else
        FXMessageBox.warning(self, MBOX_OK, 'Advertencia', 'Formato de fecha incorrecto. Ingrese una fecha válida en formato YYYY/MM/DD.')
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
