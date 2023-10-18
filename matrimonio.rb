require 'fox16'
include Fox

class Matrimonio < FXMainWindow
  def initialize(app)
    super(app, "Parroquia San Judas Tadeo", :width => 1050, :height => 650)
    # create label
    @lbltitle = FXLabel.new(self, "Bienvenido a la Parroquia San Judas Tadeo", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 1050, :height => 20, :x => 0, :y => 20)
    # create label
    @lblsubtitle = FXLabel.new(self, "ARQUIDIOSESIS DE QUITO - VICARIA NORTE SERVICIO PARROQUIAL DE SAN JUDAS TADEO", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 1050, :height => 20, :x => 0, :y => 40)

    #create label
    @date = Time.now.strftime("%d/%m/%Y %H:%M:%S")
    @lbldate = FXLabel.new(self, "Fecha: #{@date}", :opts => LAYOUT_EXPLICIT|JUSTIFY_RIGHT, :width => 1000, :height => 20, :x => 0, :y => 60)
    #section libros
    @lbltomo = FXLabel.new(self, "Tomo", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 50, :y => 100)
    @inputtomo = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 110, :y => 100)
    @lblpage = FXLabel.new(self, "Pagina", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 170, :y => 100)
    @inputpage = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 230, :y => 100)
    @lblnumber = FXLabel.new(self, "Numero", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 290, :y => 100)
    @inputnumber = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 350, :y => 100)

    #section datos
    @lblmatrimonio = FXLabel.new(self, "Fecha de matrimonio (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 250, :height => 20, :x => 10, :y => 150)
    @inputmatrimonio = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 340, :y => 150)
    @lbl_sacramento = FXLabel.new(self, "Sacramento: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 150)
    @input_sacramento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 150)
    @lbliglesia = FXLabel.new(self, "Iglesia parroquial: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 180)
    @inputglesia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 180)
    @lblsector = FXLabel.new(self, "Sector: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 180)
    @inputsector = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 180)
    @lblministro = FXLabel.new(self, "Ministro: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 180)
    @inputministro = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 180)
    @lbl_name_novio = FXLabel.new(self, "Nombres del novio: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 210)
    @input_name_novio = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 210)
    @lbl_apellido_novio = FXLabel.new(self, "Apellidos del novio: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 210)
    @input_apellido_novio = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 210)
    @lbl_cedula_novio = FXLabel.new(self, "Cédula del novio: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 210)
    @input_cedula_novio = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 210)
    @lbl_name_novia = FXLabel.new(self, "Nombres de la novia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 240)
    @input_name_novia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 240)
    @lbl_apellido_novia = FXLabel.new(self, "Apellidos de la novia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 240)
    @input_apellido_novia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 240)
    @lbl_cedula_novia = FXLabel.new(self, "Cédula de la novia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 240)
    @input_cedula_novia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 240)
    @lbl_testigo_novio = FXLabel.new(self, "Testigo del novio: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 300)
    @lbl_nombres_testigo_novio = FXLabel.new(self, "Nombres: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 170, :y => 300)
    @input_nombres_testigo_novio = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 340, :y => 300)
    @lbl_apellidos_testigo_novio = FXLabel.new(self, "Apellidos: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 510, :y => 300)
    @input_apellidos_testigo_novio = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 680, :y => 300)
    @lbl_testigo_novia = FXLabel.new(self, "Testigo novia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 330)
    @lbl_nombres_testigo_novia = FXLabel.new(self, "Nombres: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 170, :y => 330)
    @input_nombres_testigo_novia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 340, :y => 330)
    @lbl_apellidos_testigo_novia = FXLabel.new(self, "Apellidos: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 510, :y => 330)
    @input_apellidos_testigo_novia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 680, :y => 330)
    @lbl_feligreses = FXLabel.new(self, "Feligreses de la parroquia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 360)
    @inputmadrina = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 360)
    @lblcertifica = FXLabel.new(self, "Certifica: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 360)
    @inputcertifica = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 360)

    #section registro civil
    @lblregciv = FXLabel.new(self, "------------------------------------ REGISTRO CIVIL ------------------------------------", :opts => LAYOUT_EXPLICIT, :width => 700, :height => 20, :x => 10, :y => 420)
    @lblprovinciarc = FXLabel.new(self, "Provincia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 450)
    @inputprovinciarc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170,:y => 450)
    @lblcantonrc = FXLabel.new(self, "Cantón: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 450)
    @inputcantonrc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y =>450)
    @lblparroquiarc = FXLabel.new(self, "Parroquia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 480)
    @inputparroquiarc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170,:y => 480)
    @lblaniorc = FXLabel.new(self, "Año: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 50, :y => 510)
    @inputaniorc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 110,:y => 510)
    @lbltomorc = FXLabel.new(self, "Tomo: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 170, :y => 510)
    @inputtomorc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 230,:y => 510)
    @lblpagrc = FXLabel.new(self, "Página: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 290, :y => 510)
    @inputpagrc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 350,:y => 510)
    @lblactarc = FXLabel.new(self, "Acta: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 410, :y => 510)
    @inputactarc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 470,:y => 510)
    @lbldaterc = FXLabel.new(self, "Fecha (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 540)
    @inputdaterc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170,:y => 540)


    # create buttons
    @btnsave = FXButton.new(self, "Guardar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 790, :y => 400)
    @btncancel = FXButton.new(self, "Cancelar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 900, :y => 400)

  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
