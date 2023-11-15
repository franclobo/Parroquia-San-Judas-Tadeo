# frozen_string_literal: true

require 'pg'
require 'fox16'
require 'date'
include Fox

class Misa < FXMainWindow
  def initialize(app)
    @app = app
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
    @input_sacramento.text = 'Misa'
    @input_sacramento.disable
    @lbl_parroquia = FXLabel.new(self, 'Capilla: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                    y: 180)
    @lbl_parroquia.backColor = FXRGB(3, 187, 133)
    @input_parroquia = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                 y: 180)
    @lbl_sector = FXLabel.new(self, 'Sector: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 330,
                                                y: 180)
    @lbl_sector.backColor = FXRGB(3, 187, 133)
    @input_sector = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 490,
                                              y: 180)
    @lbl_parroco = FXLabel.new(self, 'Celebrante: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                     y: 210)
    @lbl_parroco.backColor = FXRGB(3, 187, 133)
    @input_parroco = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                               y: 210)
    @lbl_intencion = FXLabel.new(self, 'Intención: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                      y: 240)
    @lbl_intencion.backColor = FXRGB(3, 187, 133)
    @input_intencion = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                 y: 240)
    @lbl_fecha = FXLabel.new(self, 'Fecha de la misa (AAAA/MM/DD): ', opts: LAYOUT_EXPLICIT, width: 250,
                                                                      height: 20, x: 10, y: 270)
    @lbl_fecha.backColor = FXRGB(3, 187, 133)
    @input_fecha = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 280,
                                             y: 270)
    @lbl_hora = FXLabel.new(self, 'Hora (HH:MM): ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                    y: 300)
    @lbl_hora.backColor = FXRGB(3, 187, 133)
    @input_hora = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                            y: 300)
    # create buttons
    @btnsave = FXButton.new(self, 'Guardar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                             x: 480, y: 330)
    @btncancel = FXButton.new(self, 'Cancelar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                x: 590, y: 330)

    # connect buttons
    @btnsave.connect(SEL_COMMAND) do
      sacramento = @input_sacramento.text
      capilla = @input_parroquia.text
      sector = @input_sector.text
      celebrante = @input_parroco.text
      intencion = @input_intencion.text
      fecha_misa = @input_fecha.text
      hora = @input_hora.text


      # tables
      # tabla libros (id, tomo, pagina, numero)
      # tabla creyentes (id, nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula)
      # tabla parroquias (id, nombre, sector, parroco)
      # tabla sacramentos (id, nombre, fecha, celebrante, certifica, padrino, madrina, testigo_novio, testigo_novia, padre, madre, nombres_novia, apellidos_novia, cedula_novia, fk_creyentes, fk_parroquias, fk_registros_civiles, fk_libros)
      # tabla registros_civiles (id, provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc)
      # Iniciar una transacción

      def validar_formato_fecha(fecha)
        begin
          Date.strptime(fecha, '%Y/%m/%d') || Date.strptime(fecha, '%Y-%m-%d')
          return true
        rescue ArgumentError
          return false
        end
      end

      if validar_formato_fecha(fecha_misa)
        $conn.transaction do
          # Insertar en la tabla libros
          @registro_libros = $conn.exec('INSERT INTO libros (tomo, pagina, numero) VALUES ($1, $2, $3)', [nil, nil, nil])

          # Insertar en la tabla creyentes
          @registro_creyentes = $conn.exec(
            'INSERT INTO creyentes (nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula) VALUES ($1, $2, $3, $4, $5)', [
              nil, nil, nil, nil, nil
            ]
          )

          # Insertar en la tabla registros civiles, si no existen datos se crea un registro nuevo con id que corresponda y se llena los demaás datos con nil
          @registro_registros_civiles = $conn.exec(
            'INSERT INTO registros_civiles (provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)', [
              nil, nil, nil, nil, nil, nil, nil, nil
            ]
          )

          # Insertar en la tabla parroquias
          @registro_parroquias = $conn.exec('INSERT INTO parroquias (parroquia, sector, parroco) VALUES ($1, $2, $3)',
                                            [capilla, sector, celebrante])
          # Insertar en la tabla misas
          @registro_misas = $conn.exec('INSERT INTO misas (intencion, fecha, hora) VALUES ($1, $2, $3)',
                                      [intencion, fecha_misa, hora])
          # Insetar en la tabla sacramentos y actualizar el id de las claves foraneas
          @registro_sacramentos = $conn.exec('INSERT INTO sacramentos (sacramento) VALUES ($1)', [sacramento])
          # Confirmar la transacción
          $conn.exec('COMMIT')
          FXMessageBox.information(self, MBOX_OK, 'Información', 'Datos guardados correctamente')
          clear_input_fields
        end
      else
        FXMessageBox.warning(self, MBOX_OK, 'Advertencia', 'Formato de fecha incorrecto. Ingrese una fecha válida en formato YYYY/MM/DD.')
      end
    end

    @btncancel.connect(SEL_COMMAND) do
      clear_input_fields
    end

    def clear_input_fields
      @input_parroquia.text = ''
      @input_sector.text = ''
      @input_parroco.text = ''
      @input_intencion.text = ''
      @input_fecha.text = ''
      @input_hora.text = ''
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
