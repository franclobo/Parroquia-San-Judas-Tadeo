require 'pg'
require 'fox16'
include Fox

class Consulta < FXMainWindow
  def initialize(app)
    super(app, 'Parroquia San Judas Tadeo', width: 700, height: 380)
    @app = app
    self.backColor = FXRGB(3, 187, 133)

    # seccion encabezado
    # create label
    @lbltitle = FXLabel.new(self, 'Bienvenido a la Parroquia San Judas Tadeo',
                            opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700, height: 20, x: 0, y: 20)
    @lbltitle.font = FXFont.new(app, 'Geneva', 16, FONTWEIGHT_BOLD)
    @lbltitle.backColor = FXRGB(3, 187, 133)
    # create label
    @lblsubtitle = FXLabel.new(self, 'ARQUIDIOSESIS DE QUITO - VICARIA NORTE SERVICIO PARROQUIAL DE SAN JUDAS TADEO',
                               opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700, height: 20, x: 0, y: 40)
    @lblsubtitle.font = FXFont.new(app, 'Geneva', 10, FONTWEIGHT_BOLD)
    @lblsubtitle.backColor = FXRGB(3, 187, 133)
    # create label
    @date = Time.now.strftime('%d/%m/%Y')
    @lbldate = FXLabel.new(self, "Fecha: #{cambiar_formato_fecha(@date)} ", opts: LAYOUT_EXPLICIT | JUSTIFY_RIGHT,
                                                                            width: 680, height: 20, x: 0, y: 60)
    @lbldate.font = FXFont.new(app, 'Geneva', 12, FONTWEIGHT_BOLD)
    @lbldate.backColor = FXRGB(3, 187, 133)
    # seccioan consulta
    @lbl_consulta = FXLabel.new(self, 'Consultar por: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                         x: 10, y: 150)
    @lbl_consulta.backColor = FXRGB(3, 187, 133)
    @lbl_apellidos = FXLabel.new(self, 'Apellidos: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                      y: 180)
    @lbl_apellidos.backColor = FXRGB(3, 187, 133)
    @input_apellidos = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                                 y: 180)
    @lbl_nombres = FXLabel.new(self, 'Nombres: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                                  y: 180)
    @lbl_nombres.backColor = FXRGB(3, 187, 133)
    @input_nombres = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                               y: 180)
    @lbl_cedula = FXLabel.new(self, 'Cédula: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                y: 210)
    @lbl_cedula.backColor = FXRGB(3, 187, 133)
    @input_cedula = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                              y: 210)
    @lbl_anio_lectivo = FXLabel.new(self, 'Año lectivo: ', opts: LAYOUT_EXPLICIT, width: 250,
                                                           height: 20, x: 10, y: 240)
    @lbl_anio_lectivo.backColor = FXRGB(3, 187, 133)
    @input_anio_lectivo = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 340,
                                                    y: 240)
    @lbl_nivel = FXLabel.new(self, 'Nivel: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                              x: 10, y: 300)
    @lbl_nivel.backColor = FXRGB(3, 187, 133)
    @input_nivel = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                             y: 300)
    @lbl_sector = FXLabel.new(self, 'Sector: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                x: 340, y: 270)
    @lbl_sector.backColor = FXRGB(3, 187, 133)
    @input_sector = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                              y: 270)
    @lbl_nombres_catequista = FXLabel.new(self, 'Nombres catequista: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                        height: 20, x: 340, y: 300)
    @lbl_nombres_catequista.backColor = FXRGB(3, 187, 133)
    @input_nombres_catequista = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                          y: 300)
    @lbl_apellidos_catequista = FXLabel.new(self, 'Apellidos catequista: ', opts: LAYOUT_EXPLICIT, width: 150,
                                                                            height: 20, x: 340, y: 330)
    @lbl_apellidos_catequista.backColor = FXRGB(3, 187, 133)
    @input_apellidos_catequista = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 510,
                                                            y: 330)

    # create buttons
    @btnsearch = FXButton.new(self, 'Buscar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                              x: 450, y: 330)
    @btncancel = FXButton.new(self, 'Cancelar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                x: 560, y: 330)

    # connect buttons
    @btnsearch.connect(SEL_COMMAND) do
      apellidos = @input_apellidos.text
      nombres = @input_nombres.text
      cedula = @input_cedula.text
      anio_lectivo = @input_anio_lectivo.text
      nivel = @input_nivel.text
      sector = @input_sector.text
      nombres_catequista = @input_nombres_catequista.text
      apellidos_catequista = @input_apellidos_catequista.text

      if apellidos.empty? && nombres.empty? && cedula.empty? && anio_lectivo.empty? && nivel.empty? && nombres_catequista.empty? && apellidos_catequista.empty? && sector.empty?
        FXMessageBox.warning(self, MBOX_OK, 'Advertencia', 'Debe ingresar al menos un criterio de búsqueda')
      else
        # conectar a la base de datos
        # tables
        # tabla catequistas (id, nombres, apellidos, fecha de nacimiento, lugar de nacimiento, cedula)
        # tabla alumnos (id, nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula, fk_catequistas, fk_niveles)
        # tabla niveles (id, nivel, sector, anio_lectivo)
        sql = 'SELECT * FROM alumnos INNER JOIN niveles ON alumnos.id = niveles.id INNER JOIN catequistas ON alumnos.id = catequistas.id'
        sql += " WHERE alumnos.apellidos LIKE '%#{apellidos}%'" unless apellidos.empty?
        sql += " AND alumnos.nombres LIKE '%#{nombres}%'" unless nombres.empty?
        sql += " AND alumnos.cedula = '#{cedula}'" unless cedula.empty?
        sql += " AND niveles.anio_lectivo = '#{anio_lectivo}'" unless anio_lectivo.empty?
        sql += " AND niveles.nivel = '#{nivel}'" unless nivel.empty?
        sql += " AND catequistas.nombres LIKE '%#{nombres_catequista}%'" unless nombres_catequista.empty?
        sql += " AND catequistas.apellidos LIKE '%#{apellidos_catequista}%'" unless apellidos_catequista.empty?
        # Se escoge año lectivo, sector, catequista y nivel
        unless anio_lectivo.empty? || nivel.empty? || nombres_catequista.empty? || apellidos_catequista.empty?
          sql += " AND niveles.anio_lectivo = '#{anio_lectivo}' AND niveles.nivel = '#{nivel}' AND catequistas.nombres LIKE '%#{nombres_catequista}%' AND catequistas.apellidos LIKE '%#{apellidos_catequista}%'"
        end


        $conn.exec(sql) do |result|
          if result.values.empty?
            FXMessageBox.information(self, MBOX_OK, 'Información', 'No se encontraron registros')
          else
            # mostrar resultados
            FXMessageBox.information(self, MBOX_OK, 'Información', "Se encontraron #{result.values.length} registros")
            require_relative 'resultado'
            vtnresultados = ResultadosConsulta.new(@app, result.values)
            vtnresultados.create
            vtnresultados.show(PLACEMENT_SCREEN)
          end
        end
      end
    end

    @btncancel.connect(SEL_COMMAND) do
      clear_input_fields
    end

    def clear_input_fields
      @input_apellidos.text = ''
      @input_nombres.text = ''
      @input_cedula.text = ''
      @input_anio_lectivo.text = ''
      @input_nivel.text = ''
      @input_nombres_catequista.text = ''
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
