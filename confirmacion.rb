require 'pg'
require 'fox16'
include Fox

$conn = PG.connect(host: 'localhost', port: '5432', dbname: 'sacramentos', user: 'postgres', password: 'postgres')
# Comprobar conexión con la base de datos
if $conn.status != PG::CONNECTION_OK
  puts "Error de conexión con la base de datos"
  exit
end

class Confirmacion < FXMainWindow
  def initialize(app)
    @app = app
    super(app, "Parroquia San Judas Tadeo", :width => 1050, :height => 450)
     # create label
    @lbltitle = FXLabel.new(self, "Bienvenido a la Parroquia San Judas Tadeo", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 1050, :height => 20, :x => 0, :y => 20)
    # create label
    @lblsubtitle = FXLabel.new(self, "ARQUIDIOSESIS DE QUITO - VICARIA NORTE SERVICIO PARROQUIAL DE SAN JUDAS TADEO", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 1050, :height => 20, :x => 0, :y => 40)

    #create label
    @date = Time.now.strftime("%d/%m/%Y %H:%M:%S")
    @lbldate = FXLabel.new(self, "Fecha: #{@date}", :opts => LAYOUT_EXPLICIT|JUSTIFY_RIGHT, :width => 1000, :height => 20, :x => 0, :y => 60)
    #section libros
    @lbl_tomo = FXLabel.new(self, "Tomo", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 10, :y => 100)
    @input_tomo = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 70, :y => 100)
    @lbl_page = FXLabel.new(self, "Página", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 130, :y => 100)
    @input_page = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 190, :y => 100)
    @lbl_number = FXLabel.new(self, "Numero", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 250, :y => 100)
    @input_number = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 310, :y => 100)

    #section datos
    @lbl_fecha = FXLabel.new(self, "Fecha de confirmación (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 250, :height => 20, :x => 10, :y => 150)
    @input_fecha = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 340, :y => 150)
    @lbl_sacramento = FXLabel.new(self, "Sacramento: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 150)
    @input_sacramento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 150)
    @lbl_parroquia = FXLabel.new(self, "Iglesia parroquial: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 180)
    @input_parroquia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 180)
    @lbl_sector = FXLabel.new(self, "Sector: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 180)
    @input_sector = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 180)
    @lbl_parroco = FXLabel.new(self, "Parroco: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 180)
    @input_parroco = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 180)
    @lbl_celebrante = FXLabel.new(self, "Celebrante: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 210)
    @input_celebrante = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 210)
    @lbl_name = FXLabel.new(self, "Nombres: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 240)
    @input_name = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 240)
    @lbl_apellidos = FXLabel.new(self, "Apellidos: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 270)
    @input_apellidos = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 270)
    @lbl_lugar_nacimiento = FXLabel.new(self, "Lugar de nacimiento: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 300)
    @input_lugar_nacimiento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 300)
    @lbl_fecha_nacimiento = FXLabel.new(self, "Fecha de nacimiento (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 250, :height => 20, :x => 340, :y => 300)
    @input_fecha_nacimiento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 590, :y => 300)
    @lbl_cedula = FXLabel.new(self, "Cédula: ", :opts => LAYOUT_EXPLICIT, :width => 80, :height => 20, :x => 750, :y => 300)
    @input_cedula = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x =>850, :y => 300)
    @lbl_padrino = FXLabel.new(self, "Padrino: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 330)
    @input_padrino = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 330)
    @lbl_certifica = FXLabel.new(self, "Certifica: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 360)
    @input_certifica = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 360)

    # create buttons
    @btnsave = FXButton.new(self, "Guardar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 790, :y => 400)
    @btncancel = FXButton.new(self, "Cancelar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 900, :y => 400)

    # connect buttons
    @btnsave.connect(SEL_COMMAND) do
      tomo = @input_tomo.text
      page = @input_page.text
      number = @input_number.text
      fecha = @input_fecha.text
      sacramento = @input_sacramento.text
      parroquia = @input_parroquia.text
      sector = @input_sector.text
      parroco = @input_parroco.text
      celebrante = @input_celebrante.text
      name = @input_name.text
      apellidos = @input_apellidos.text
      lugar_nacimiento = @input_lugar_nacimiento.text
      fecha_nacimiento = @input_fecha_nacimiento.text
      cedula = @input_cedula.text.empty? ? nil : @input_cedula.text
      padrino = @input_padrino.text.empty? ? nil : @input_padrino.text
      certifica = @input_certifica.text

      begin
        $conn.exec('INSERT INTO libros (tomo, pagina, numero) VALUES ($1, $2, $3)', [tomo, page, number])
        $conn.exec('INSERT INTO creyentes (nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula) VALUES ($1, $2, $3, $4, $5)', [name, apellidos, lugar_nacimiento, fecha_nacimiento, cedula])
        $conn.exec('INSERT INTO parroquias (nombre, sector, parroco) VALUES ($1, $2, $3)', [parroquia, sector, parroco])
        $conn.exec('INSERT INTO sacramentos (nombre, fecha, celebrante, certifica, padrino) VALUES ($1, $2, $3, $4, $5)', [sacramento, fecha, celebrante, certifica, padrino])
        FXMessageBox.information(self, MBOX_OK, "Información", "Datos guardados correctamente")
        clear_input_fields
      rescue PG::Error => e
        FXMessageBox.error(self, MBOX_OK, "Error", "Error al guardar los datos")
      end
    end

    @btncancel.connect(SEL_COMMAND) do
      clear_input_fields
    end

    def clear_input_fields
      @input_tomo.text = ""
      @input_page.text = ""
      @input_number.text = ""
      @input_fecha.text = ""
      @input_sacramento.text = ""
      @input_parroquia.text = ""
      @input_sector.text = ""
      @input_parroco.text = ""
      @input_celebrante.text = ""
      @input_name.text = ""
      @input_apellidos.text = ""
      @input_lugar_nacimiento.text = ""
      @input_fecha_nacimiento.text = ""
      @input_cedula.text = ""
      @input_padrino.text = ""
      @input_certifica.text = ""
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
