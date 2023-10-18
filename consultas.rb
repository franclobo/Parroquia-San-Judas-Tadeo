require 'pg'
require 'fox16'
include Fox

class Consulta < FXMainWindow
  def initialize(app)
    super(app, "Parroquia San Judas Tadeo", :width => 700, :height => 500)
    @app = app

    # seccion encabezado
    # create label
    @lbltitle = FXLabel.new(self, "Bienvenido a la Parroquia San Judas Tadeo", :opts => LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, :width => 700, :height => 20, :x => 0, :y => 20)
    # create label
    @lblsubtitle = FXLabel.new(self, "ARQUIDIOSESIS DE QUITO - VICARIA NORTE SERVICIO PARROQUIAL DE SAN JUDAS TADEO", :opts => LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, :width => 700, :height => 20, :x => 0, :y => 40)

    # create label
    @date = Time.now.strftime("%d/%m/%Y %H:%M:%S")
    @lbldate = FXLabel.new(self, "Fecha: #{@date}", :opts => LAYOUT_EXPLICIT | JUSTIFY_RIGHT, :width => 680, :height => 20, :x => 0, :y => 60)

    # seccioan consulta
    @lbl_consulta = FXLabel.new(self, "Consultar por: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 150)
    @lbl_apellidos = FXLabel.new(self, "Apellidos: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 180)
    @input_apellidos = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 170, :y => 180)
    @lbl_nombres = FXLabel.new(self, "Nombres: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 180)
    @input_nombres = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 510, :y => 180)
    @lbl_cedula = FXLabel.new(self, "Cédula: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 210)
    @input_cedula = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 170, :y => 210)
    @lbl_fecha_desde = FXLabel.new(self, "Fecha desde (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 250, :height => 20, :x => 10, :y => 240)
    @input_fecha_desde = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 240)
    @lbl_fecha_hasta = FXLabel.new(self, "Fecha hasta (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 250, :height => 20, :x => 10, :y => 270)
    @input_fecha_hasta = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 270)
    @lbl_sacramento = FXLabel.new(self, "Sacramento: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 300)
    @input_sacramento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 170, :y => 300)

    # create buttons
    @btnsearch = FXButton.new(self, "Buscar", :opts => LAYOUT_EXPLICIT | BUTTON_NORMAL, :width => 100, :height => 30, :x => 450, :y => 330)
    @btncancel = FXButton.new(self, "Cancelar", :opts => LAYOUT_EXPLICIT | BUTTON_NORMAL, :width => 100, :height => 30, :x => 560, :y => 330)

    # connect buttons
    @btnsearch.connect(SEL_COMMAND) do
      apellidos = @input_apellidos.text
      nombres = @input_nombres.text
      cedula = @input_cedula.text
      fecha_desde = @input_fecha_desde.text
      fecha_hasta = @input_fecha_hasta.text
      sacramento = @input_sacramento.text

      if apellidos.empty? && nombres.empty? && cedula.empty? && fecha_desde.empty? && fecha_hasta.empty? && sacramento.empty?
        FXMessageBox.warning(self, MBOX_OK, "Advertencia", "Debe ingresar al menos un criterio de búsqueda")
      else
        begin
          # tables
          # tabla libros (id, tomo, pagina, numero)
          # tabla creyentes (id, nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula)
          # tabla parroquias (id, nombre, sector, parroco)
          # tabla sacramentos (id, nombre, fecha, celebrante, certifica, padrino, madrina, testigo_novio, testigo_novia, padre, madre, nombres_novia, apellidos_novia, cedula_novia, fk_creyentes, fk_parroquias, fk_registros_civiles, fk_libros)
          # tabla registros_civiles (id, provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc)
          # Join tables
          sql = "SELECT * FROM sacramentos INNER JOIN libros ON sacramentos.id = libros.id INNER JOIN creyentes ON sacramentos.id = creyentes.id INNER JOIN parroquias ON sacramentos.id = parroquias.id INNER JOIN registros_civiles ON sacramentos.id = registros_civiles.id"
          sql += " WHERE creyentes.apellidos LIKE '%#{apellidos}%'" unless apellidos.empty?
          sql += " AND creyentes.nombres LIKE '%#{nombres}%'" unless nombres.empty?
          sql += " AND creyentes.cedula = '#{cedula}'" unless cedula.empty?
          sql += " AND sacramentos.fecha >= '#{fecha_desde}'" unless fecha_desde.empty?
          sql += " AND sacramentos.fecha <= '#{fecha_hasta}'" unless fecha_hasta.empty?
          sql += " AND sacramentos.nombre = '#{sacramento}'" unless sacramento.empty?
          puts sql
          $conn.exec(sql) do |result|
            puts result.values
            if result.values.empty?
              FXMessageBox.information(self, MBOX_OK, "Información", "No se encontraron registros")
            else
              # mostrar resultados
              FXMessageBox.information(self, MBOX_OK, "Información", "Se encontraron #{result.values.length} registros")
              require_relative 'resultados.rb'
              vtnresultados = ResultadosConsulta.new(@app, result.values)
              vtnresultados.create
              vtnresultados.show(PLACEMENT_SCREEN)
            end
          end
        rescue PG::Error => e
          puts e.message
        end
      end
    end

    @btncancel.connect(SEL_COMMAND) do
      clear_input_fields
    end

    def clear_input_fields
      @input_apellidos.text = ""
      @input_nombres.text = ""
      @input_cedula.text = ""
      @input_fecha_desde.text = ""
      @input_fecha_hasta.text = ""
      @input_sacramento.text = ""
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
