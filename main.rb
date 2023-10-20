require 'pg'
require 'fox16'
include Fox

$conn = PG.connect(host: 'localhost', port: '5432', dbname: 'sacramentos', user: 'postgres', password: 'postgres')
# Comprobar conexión con la base de datos
if $conn.status != PG::CONNECTION_OK
  puts "Error de conexión con la base de datos"
  exit
end

class Home < FXMainWindow
  def initialize(app)
    super(app, "Parroquia San Judas Tadeo", :width => 700, :height => 500)
    @app = app
     # create label
    @lbltitle = FXLabel.new(self, "Bienvenido a la Parroquia San Judas Tadeo", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 700, :height => 20, :x => 0, :y => 20)
    # create label
    @lblsubtitle = FXLabel.new(self, "ARQUIDIOSESIS DE QUITO - VICARIA NORTE SERVICIO PARROQUIAL DE SAN JUDAS TADEO", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 700, :height => 20, :x => 0, :y => 40)

    #create label
    @date = Time.now.strftime("%d/%m/%Y %H:%M:%S")
    @lbldate = FXLabel.new(self, "Fecha: #{@date}", :opts => LAYOUT_EXPLICIT|JUSTIFY_RIGHT, :width => 680, :height => 20, :x => 0, :y => 60)
    #section lista
    @lblbautizo = FXLabel.new(self, "Ingresar Bautizo", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 150)
    @btnbautizo = FXButton.new(self, "Ingresar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 150,:height => 20, :x => 170, :y => 150)
    @lblconfirmacion = FXLabel.new(self, "Ingresar Confirmacion", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 180)
    @btnconfirmacion = FXButton.new(self, "Ingresar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 150,:height => 20, :x => 170, :y => 180)
    @lblmatrimonio = FXLabel.new(self, "Ingresar Matrimonio", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 210)
    @btnmatrimonio = FXButton.new(self, "Ingresar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 150,:height => 20, :x => 170, :y => 210)
    @lblconsulta = FXLabel.new(self, "Realizar una consulta", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 240)
    @btnconsulta = FXButton.new(self, "Consultar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 150,:height => 20, :x => 170, :y => 240)

    #section buttons executions
    @btnbautizo.connect(SEL_COMMAND) do
      require_relative 'bautizo.rb'
      vtnbautizo = Bautizo.new(@app)
      vtnbautizo.create
      vtnbautizo.show(PLACEMENT_SCREEN)
    end
    @btnconfirmacion.connect(SEL_COMMAND) do
      require_relative 'confirmacion.rb'
      vtnconfirmacion = Confirmacion.new(@app)
      vtnconfirmacion.create
      vtnconfirmacion.show(PLACEMENT_SCREEN)
    end
    @btnmatrimonio.connect(SEL_COMMAND) do
      require_relative 'matrimonio.rb'
      vtnmatrimonio = Matrimonio.new(@app)
      vtnmatrimonio.create
      vtnmatrimonio.show(PLACEMENT_SCREEN)
    end
    @btnconsulta.connect(SEL_COMMAND) do
      require_relative 'consultas.rb'
      vtnconsulta = Consulta.new(@app)
      vtnconsulta.create
      vtnconsulta.show(PLACEMENT_SCREEN)
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

app = FXApp.new
vtnhome = Home.new(app)
app.create
app.run


