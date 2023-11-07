require 'pg'
require 'fox16'
include Fox

class Alumno < FXMainWindow
  def initialize(app)
    @app = app
    super(app, 'Parroquia San Judas Tadeo', width: 1050, height: 450)
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
    @lbl_anio_lectivo = FXLabel.new(self, 'Año lectivo: ', opts: LAYOUT_EXPLICIT, width: 250,
                                                           height: 20, x: 10, y: 150)
    @lbl_anio_lectivo.backColor = FXRGB(3, 187, 133)
    @input_anio_lectivo = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                                    y: 150)
    @lbl_nivel = FXLabel.new(self, 'Nivel: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                              x: 680, y: 150)
    @lbl_nivel.backColor = FXRGB(3, 187, 133)
    @input_nivel = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                             y: 150)
    @lbl_sector = FXLabel.new(self, 'Sector: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                                y: 180)
    @lbl_sector.backColor = FXRGB(3, 187, 133)
    @input_sector = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                              y: 180)
    @lbl_name = FXLabel.new(self, 'Nombres: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                               y: 240)
    @lbl_name.backColor = FXRGB(3, 187, 133)
    @input_name = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                            y: 240)
    @lbl_apellidos = FXLabel.new(self, 'Apellidos: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                      y: 270)
    @lbl_apellidos.backColor = FXRGB(3, 187, 133)
    @input_apellidos = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                 y: 270)
    @lbl_lugar_nacimiento = FXLabel.new(self, 'Lugar de nacimiento: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                       height: 20, x: 10, y: 300)
    @lbl_lugar_nacimiento.backColor = FXRGB(3, 187, 133)
    @input_lugar_nacimiento = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                        x: 170, y: 300)
    @lbl_fecha_nacimiento = FXLabel.new(self, 'Fecha de nacimiento (AAAA/MM/DD): ', opts: LAYOUT_EXPLICIT,
                                                                                    width: 250, height: 20, x: 340, y: 300)
    @lbl_fecha_nacimiento.backColor = FXRGB(3, 187, 133)
    @input_fecha_nacimiento = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                        x: 590, y: 300)
    @lbl_cedula = FXLabel.new(self, 'Cédula: ', opts: LAYOUT_EXPLICIT, width: 80, height: 20, x: 750,
                                                y: 300)
    @lbl_cedula.backColor = FXRGB(3, 187, 133)
    @input_cedula = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 850,
                                              y: 300)
    @lbl_nombre_catequista = FXLabel.new(self, 'Nombre del catequista: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                          height: 20, x: 10, y: 330)
    @lbl_nombre_catequista.backColor = FXRGB(3, 187, 133)
    @input_nombre_catequista = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                         x: 170, y: 330)
    @lbl_apellidos_catequista = FXLabel.new(self, 'Apellidos del catequista: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                                height: 20, x: 340, y: 330)
    @lbl_apellidos_catequista.backColor = FXRGB(3, 187, 133)
    @input_apellidos_catequista = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                            x: 510, y: 330)
    # create buttons
    @btnsave = FXButton.new(self, 'Guardar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                             x: 790, y: 400)
    @btncancel = FXButton.new(self, 'Cancelar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                x: 900, y: 400)

    # connect buttons
    @btnsave.connect(SEL_COMMAND) do
      anio_lectivo = @input_anio_lectivo.text.empty? ? nil : @input_anio_lectivo.text
      nivel = @input_nivel.text.empty? ? nil : @input_nivel.text
      sector = @input_sector.text.empty? ? nil : @input_sector.text
      name = @input_name.text.empty? ? nil : @input_name.text
      apellidos = @input_apellidos.text.empty? ? nil : @input_apellidos.text
      lugar_nacimiento = @input_lugar_nacimiento.text.empty? ? nil : @input_lugar_nacimiento.text
      fecha_nacimiento = @input_fecha_nacimiento.text.empty? ? nil : @input_fecha_nacimiento.text
      cedula = @input_cedula.text.empty? ? nil : @input_cedula.text
      nombres_catequista = @input_nombre_catequista.text.empty? ? nil : @input_nombre_catequista.text
      apellidos_catequista = @input_apellidos_catequista.text.empty? ? nil : @input_apellidos_catequista.text


      # tables
      # tabla catequistas (id, nombres, apellidos, fecha de nacimiento, lugar de nacimiento, cedula)
      # tabla alumnos (id, nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula, fk_catequistas, fk_niveles)
      # tabla niveles (id, nivel, sector, anio_lectivo)
      $conn.transaction do
        # Insertar en la tabla catequistas
        @registro_catequistas = $conn.exec('INSERT INTO catequistas (nombres, apellidos) VALUES ($1, $2)',
                                           [nombres_catequista, apellidos_catequista])
        # Insertar en la tabla niveles
        @registro_parroquias = $conn.exec('INSERT INTO niveles (anio_lectivo, nivel, sector) VALUES ($1, $2, $3)',
                                          [anio_lectivo, nivel, sector])
        # Insertar en la tabla alumnos
        @registro_creyentes = $conn.exec(
          'INSERT INTO alumnos (nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula) VALUES ($1, $2, $3, $4, $5)', [
            name, apellidos, lugar_nacimiento, fecha_nacimiento, cedula
          ]
        )
        puts @registro_creyentes
        puts @registro_parroquias
        puts @registro_catequistas

        # Confirmar la transacción
        $conn.exec('COMMIT')
        FXMessageBox.information(self, MBOX_OK, 'Información', 'Datos guardados correctamente')
        clear_input_fields
      end
    end

    @btncancel.connect(SEL_COMMAND) do
      clear_input_fields
    end

    def clear_input_fields
      @input_anio_lectivo.text = ''
      @input_nivel.text = ''
      @input_sector.text = ''
      @input_name.text = ''
      @input_apellidos.text = ''
      @input_lugar_nacimiento.text = ''
      @input_fecha_nacimiento.text = ''
      @input_cedula.text = ''
      @input_nombre_catequista.text = ''
      @input_apellidos_catequista.text = ''
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
