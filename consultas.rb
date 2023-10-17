require 'pg'
require 'fox16'
include Fox

class Consulta < FXMainWindow
  def initialize(app)
    super(app, "Parroquia San Judas Tadeo", :width => 700, :height => 500)

    # seccion encabezado
    # create label
    @lbltitle = FXLabel.new(self, "Bienvenido a la Parroquia San Judas Tadeo", :opts => LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, :width => 700, :height => 20, :x => 0, :y => 20)
    # create label
    @lblsubtitle = FXLabel.new(self, "ARQUIDIOSESIS DE QUITO - VICARIA NORTE SERVICIO PARROQUIAL DE SAN JUDAS TADEO", :opts => LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, :width => 700, :height => 20, :x => 0, :y => 40)

    # create label
    @date = Time.now.strftime("%d/%m/%Y %H:%M:%S")
    @lbldate = FXLabel.new(self, "Fecha: #{@date}", :opts => LAYOUT_EXPLICIT | JUSTIFY_RIGHT, :width => 680, :height => 20, :x => 0, :y => 60)

    # seccioan consulta
    @groupbox = FXGroupBox.new(self, "Elija una opción para su consulta", :opts => LAYOUT_EXPLICIT | FRAME_GROOVE | LAYOUT_FILL_X, :width => 200, :height => 120, :x => 10, :y => 100)
    @dataTarget = FXDataTarget.new(4)
    @dataTarget.connect(SEL_COMMAND) do
      clear_input_fields
      case @dataTarget.value
      when 0
        create_apellidos_fields
      when 1
        create_cedula_fields
      when 2
        create_fecha_fields
      when 3
        create_sacramento_fields
      end
    end

    @radio_apellidos = FXRadioButton.new(@groupbox, "Apellidos", @dataTarget, FXDataTarget::ID_OPTION + 0)
    @radio_cedula = FXRadioButton.new(@groupbox, "Cédula", @dataTarget, FXDataTarget::ID_OPTION + 1)
    @radio_fecha = FXRadioButton.new(@groupbox, "Fecha", @dataTarget, FXDataTarget::ID_OPTION + 2)
    @radio_sacramento = FXRadioButton.new(@groupbox, "Sacramento", @dataTarget, FXDataTarget::ID_OPTION + 3)

    # Inicialmente, no muestra ningún campo de entrada
    clear_input_fields
  end

  def clear_input_fields
    if defined? @lbl_apellidos
      @lbl_apellidos.destroy
      @input_apellidos.destroy
    end
    if defined? @lbl_nombres
      @lbl_nombres.destroy
      @input_nombres.destroy
    end
    if defined? @lbl_cedula
      @lbl_cedula.destroy
      @input_cedula.destroy
    end
    if defined? @lbl_fecha
      @lbl_fecha.destroy
      @input_fecha.destroy
    end
    if defined? @lbl_sacramento
      @lbl_sacramento.destroy
      @input_sacramento.destroy
    end
  end

  def create_apellidos_fields
    puts "create_apellidos_fields"
    @lbl_apellidos = FXLabel.new(self, "Apellidos", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 340)
    @input_apellidos = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 170, :y => 340)
    @lbl_nombres = FXLabel.new(self, "Nombres", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 340)
    @input_nombres = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 510, :y => 340)
  end

  def create_cedula_fields
    puts "create_cedula_fields"
    @lbl_cedula = FXLabel.new(self, "Cédula", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 340)
    @input_cedula = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 170, :y => 340)
  end

  def create_fecha_fields
    puts "create_fecha_fields"
    @lbl_fecha = FXLabel.new(self, "Fecha", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 340)
    @input_fecha = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 170, :y => 340)
  end

  def create_sacramento_fields
    puts "create_sacramento_fields"
    @lbl_sacramento = FXLabel.new(self, "Sacramento", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 340)
    @input_sacramento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 170, :y => 340)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
