require 'fox16'
include Fox

class Bautizo < FXMainWindow
  def initialize(app)
    super(app, "Parroquia San Judas Tadeo", :width => 700, :height => 650)
    # create label
    @lbltitle = FXLabel.new(self, "Bienvenido a la Parroquia San Judas Tadeo", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 700, :height => 20, :x => 0, :y => 20)
    # create label
    @lblsubtitle = FXLabel.new(self, "ARQUIDIOSESIS DE QUITO - VICARIA NORTE SERVICIO PARROQUIAL DE SAN JUDAS TADEO", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 700, :height => 20, :x => 0, :y => 40)

    #create label
    @date = Time.now.strftime("%d/%m/%Y %H:%M:%S")
    @lbldate = FXLabel.new(self, "Fecha: #{@date}", :opts => LAYOUT_EXPLICIT|JUSTIFY_RIGHT, :width => 680, :height => 20, :x => 0, :y => 60)
    #section libros
    @lbltomo = FXLabel.new(self, "Tomo", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 50, :y => 100)
    @inputtomo = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 110, :y => 100)
    @lblpage = FXLabel.new(self, "Pagina", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 170, :y => 100)
    @inputpage = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 230, :y => 100)
    @lblnumber = FXLabel.new(self, "Numero", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 290, :y => 100)
    @inputnumber = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 350, :y => 100)

    #section datos
    @lblbautismo = FXLabel.new(self, "Fecha de bautismo (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 150)
    @inputbautismo = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 150)
    @lbliglesia = FXLabel.new(self, "Iglesia parroquial: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 180)
    @inputglesia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 180)
    @lblsector = FXLabel.new(self, "Sector: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 180)
    @inputsector = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 500, :y => 180)
    @lblministro = FXLabel.new(self, "Ministro: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 210)
    @inputministro = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 210)
    @lblname = FXLabel.new(self, "Nombres: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 240)
    @inputname = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 240)
    @lblapellido = FXLabel.new(self, "Apellidos: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 240)
    @inputapellido = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 500, :y => 240)
    @lblcedula = FXLabel.new(self, "Cédula: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 270)
    @inputcedula = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 270)
    @lbllugarnacimiento = FXLabel.new(self, "Lugar de nacimiento: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 300)
    @inputlugarnacimiento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 300)
    @lblfechanacimiento = FXLabel.new(self, "Fecha de nacimiento: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 300)
    @inputfechanacimiento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 500, :y => 300)
    @lblpadre = FXLabel.new(self, "Padre: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 330)
    @inputpadre = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 330)
    @lblmadre = FXLabel.new(self, "Madre: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 330)
    @inputmadre = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 500, :y => 330)
    @lblpadrino = FXLabel.new(self, "Padrino: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 360)
    @inputpadrino = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 360)
    @lblmadrina = FXLabel.new(self, "Madrina: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 360)
    @inputmadrina = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 500, :y => 360)
    @lblcertifica = FXLabel.new(self, "Certifica: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 390)
    @inputcertifica = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 390)

    #section registro civil
    @lblregciv = FXLabel.new(self, "------------------------------------ REGISTRO CIVIL ------------------------------------", :opts => LAYOUT_EXPLICIT, :width => 700, :height => 20, :x => 10, :y => 420)
    @lblprovinciarc = FXLabel.new(self, "Provincia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 450)
    @inputprovinciarc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170,:y => 450)
    @lblcantonrc = FXLabel.new(self, "Cantón: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 450)
    @inputcantonrc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 500, :y =>450)
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
    @btnsave = FXButton.new(self, "Guardar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 440, :y => 600)
    @btncancel = FXButton.new(self, "Cancelar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 550, :y => 600)

  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
