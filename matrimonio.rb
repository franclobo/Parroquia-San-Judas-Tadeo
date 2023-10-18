require 'fox16'
include Fox

class Matrimonio < FXMainWindow
  def initialize(app)
    super(app, "Parroquia San Judas Tadeo", :width => 1050, :height => 530)
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
    @lbl_fecha = FXLabel.new(self, "Fecha de matrimonio (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 250, :height => 20, :x => 10, :y => 150)
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
    @lbl_name_novio = FXLabel.new(self, "Nombres del novio: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 240)
    @input_name_novio = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 240)
    @lbl_apellido_novio = FXLabel.new(self, "Apellidos del novio: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 240)
    @input_apellido_novio = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 240)
    @lbl_cedula_novio = FXLabel.new(self, "Cédula del novio: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 240)
    @input_cedula_novio = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 240)
    @lbl_name_novia = FXLabel.new(self, "Nombres de la novia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 270)
    @input_name_novia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 270)
    @lbl_apellido_novia = FXLabel.new(self, "Apellidos de la novia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 270)
    @input_apellido_novia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 270)
    @lbl_cedula_novia = FXLabel.new(self, "Cédula de la novia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 270)
    @input_cedula_novia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 270)
    @lbl_testigo_novio = FXLabel.new(self, "Testigo del novio: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 300)
    @input_nombres_testigo_novio = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 300)
    @lbl_testigo_novia = FXLabel.new(self, "Testigo novia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 300)
    @input_nombres_testigo_novia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 300)
    @lblcertifica = FXLabel.new(self, "Certifica: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 300)
    @inputcertifica = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 300)

    #section registro civil
    @lblregciv = FXLabel.new(self, "------------------------------------ REGISTRO CIVIL ------------------------------------", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 1050, :height => 20, :x => 10, :y => 330)
    @lblprovinciarc = FXLabel.new(self, "Provincia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 360)
    @inputprovinciarc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170,:y => 360)
    @lblcantonrc = FXLabel.new(self, "Cantón: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 360)
    @inputcantonrc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y =>360)
    @lblparroquiarc = FXLabel.new(self, "Parroquia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 360)
    @inputparroquiarc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850,:y => 360)
    @lblaniorc = FXLabel.new(self, "Año: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 50, :y => 390)
    @inputaniorc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 110,:y => 390)
    @lbltomorc = FXLabel.new(self, "Tomo: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 170, :y => 390)
    @inputtomorc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 230,:y => 390)
    @lblpagrc = FXLabel.new(self, "Página: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 290, :y => 390)
    @inputpagrc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 350,:y => 390)
    @lblactarc = FXLabel.new(self, "Acta: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 410, :y => 390)
    @inputactarc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 470,:y => 390)
    @lbldaterc = FXLabel.new(self, "Fecha (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 420)
    @inputdaterc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170,:y => 420)


    # create buttons
    @btnsave = FXButton.new(self, "Guardar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 790, :y => 480)
    @btncancel = FXButton.new(self, "Cancelar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 900, :y => 480)

    # connect buttons
    @btnsave.connect(SEL_COMMAND) do
      tomo = @inputtomo.text
      page = @inputpage.text
      number = @inputnumber.text
      fecha = @input_fecha.text
      sacramento = @input_sacramento.text
      parroquia = @input_parroquia.text
      sector = @input_sector.text
      parroco = @input_parroco.text
      celebrante = @input_celebrante.text
      name_novio = @input_name_novio.text
      apellido_novio = @input_apellido_novio.text
      cedula_novio = @input_cedula_novio.text.empty? ? nil : @input_cedula_novio.text
      nombres_novia = @input_name_novia.text.empty? ? nil : @input_name_novia.text
      apellidos_novia = @input_apellido_novia.text.empty? ? nil : @input_apellido_novia.text
      cedula_novia = @input_cedula_novia.text.empty? ? nil : @input_cedula_novia.text
      testigo_novio = @input_nombres_testigo_novio.text.empty? ? nil : @input_nombres_testigo_novio.text
      testigo_novia = @input_nombres_testigo_novia.text.empty? ? nil : @input_nombres_testigo_novia.text
      certifica = @inputcertifica.text
      provincia_rc = @inputprovinciarc.text
      canton_rc = @inputcantonrc.text
      parroquia_rc = @inputparroquiarc.text
      anio_rc = @inputaniorc.text
      tomo_rc = @inputtomorc.text
      pagina_rc = @inputpagrc.text
      acta_rc = @inputactarc.text
      fecha_rc = @inputdaterc.text

      begin
        $conn.exec('INSERT INTO libros (tomo, pagina, numero) VALUES ($1, $2, $3)', [tomo, page, number])
        $conn.exec('INSERT INTO creyentes (nombres, apellidos, cedula) VALUES ($1, $2, $3)', [name_novio, apellido_novio, cedula_novio])
        $conn.exec('INSERT INTO parroquias (nombre, sector, parroco) VALUES ($1, $2, $3)', [parroquia, sector, parroco])
        $conn.exec('INSERT INTO sacramentos (nombre, fecha, celebrante, certifica, testigo_novio, testigo_novia, nombres_novia, apellidos_novia, cedula_novia) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)', [sacramento, fecha, celebrante, certifica, testigo_novio, testigo_novia, nombres_novia, apellidos_novia, cedula_novia])
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
      @inputtomo.text = ""
      @inputpage.text = ""
      @inputnumber.text = ""
      @input_fecha.text = ""
      @input_sacramento.text = ""
      @input_parroquia.text = ""
      @input_sector.text = ""
      @input_parroco.text = ""
      @input_celebrante.text = ""
      @input_name_novio.text = ""
      @input_apellido_novio.text = ""
      @input_cedula_novio.text = ""
      @input_name_novia.text = ""
      @input_apellido_novia.text = ""
      @input_cedula_novia.text = ""
      @input_nombres_testigo_novio.text = ""
      @input_nombres_testigo_novia.text = ""
      @inputcertifica.text = ""
      @inputprovinciarc.text = ""
      @inputcantonrc.text = ""
      @inputparroquiarc.text = ""
      @inputaniorc.text = ""
      @inputtomorc.text = ""
      @inputpagrc.text = ""
      @inputactarc.text = ""
      @inputdaterc.text = ""
    end


  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
