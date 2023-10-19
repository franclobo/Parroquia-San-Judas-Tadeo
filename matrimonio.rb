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
    @lbl_tomo = FXLabel.new(self, "Tomo", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 50, :y => 100)
    @input_tomo = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 110, :y => 100)
    @lbl_page = FXLabel.new(self, "Pagina", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 170, :y => 100)
    @input_page = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 230, :y => 100)
    @lbl_number = FXLabel.new(self, "Numero", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 290, :y => 100)
    @input_number = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 350, :y => 100)

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
    @lbl_certifica = FXLabel.new(self, "Certifica: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 300)
    @input_certifica = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 300)

    #section registro civil
    @lbl_reg_civ = FXLabel.new(self, "------------------------------------ REGISTRO CIVIL ------------------------------------", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 1050, :height => 20, :x => 10, :y => 330)
    @lbl_provincia_rc = FXLabel.new(self, "Provincia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 360)
    @input_provincia_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170,:y => 360)
    @lbl_canton_rc = FXLabel.new(self, "Cantón: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 360)
    @input_canton_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y =>360)
    @lbl_parroquia_rc = FXLabel.new(self, "Parroquia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 360)
    @input_parroquia_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850,:y => 360)
    @lbl_anio_rc = FXLabel.new(self, "Año: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 50, :y => 390)
    @input_anio_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 110,:y => 390)
    @lbl_tomo_rc = FXLabel.new(self, "Tomo: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 170, :y => 390)
    @input_tomo_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 230,:y => 390)
    @lbl_pag_rc = FXLabel.new(self, "Página: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 290, :y => 390)
    @input_pag_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 350,:y => 390)
    @lbl_acta_rc = FXLabel.new(self, "Acta: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 410, :y => 390)
    @input_acta_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 470,:y => 390)
    @lbl_date_rc = FXLabel.new(self, "Fecha (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 420)
    @input_date_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170,:y => 420)


    # create buttons
    @btnsave = FXButton.new(self, "Guardar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 790, :y => 480)
    @btncancel = FXButton.new(self, "Cancelar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 900, :y => 480)

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
      name_novio = @input_name_novio.text
      apellido_novio = @input_apellido_novio.text
      cedula_novio = @input_cedula_novio.text.empty? ? nil : @input_cedula_novio.text
      nombres_novia = @input_name_novia.text.empty? ? nil : @input_name_novia.text
      apellidos_novia = @input_apellido_novia.text.empty? ? nil : @input_apellido_novia.text
      cedula_novia = @input_cedula_novia.text.empty? ? nil : @input_cedula_novia.text
      testigo_novio = @input_nombres_testigo_novio.text.empty? ? nil : @input_nombres_testigo_novio.text
      testigo_novia = @input_nombres_testigo_novia.text.empty? ? nil : @input_nombres_testigo_novia.text
      certifica = @input_certifica.text
      provincia_rc = @input_provincia_rc.text
      canton_rc = @input_canton_rc.text
      parroquia_rc = @input_parroquia_rc.text
      anio_rc = @input_anio_rc.text
      tomo_rc = @input_tomo_rc.text
      pagina_rc = @input_pag_rc.text
      acta_rc = @input_acta_rc.text
      fecha_rc = @input_date_rc.text

      begin
        # tables
          # tabla libros (id, tomo, pagina, numero)
          # tabla creyentes (id, nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula)
          # tabla parroquias (id, nombre, sector, parroco)
          # tabla sacramentos (id, nombre, fecha, celebrante, certifica, padrino, madrina, testigo_novio, testigo_novia, padre, madre, nombres_novia, apellidos_novia, cedula_novia, fk_creyentes, fk_parroquias, fk_registros_civiles, fk_libros)
          # tabla registros_civiles (id, provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc)
        $conn.transaction do
          $conn.exec('INSERT INTO libros (tomo, pagina, numero) VALUES ($1, $2, $3)', [tomo, page, number])
          $conn.exec('INSERT INTO creyentes (nombres, apellidos, cedula) VALUES ($1, $2, $3)', [name_novio, apellido_novio, cedula_novio])
          $conn.exec('INSERT INTO parroquias (parroquia, sector, parroco) VALUES ($1, $2, $3)', [parroquia, sector, parroco])
          $conn.exec('INSERT INTO registros_civiles (provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)', [provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc])
          $conn.exec('INSERT INTO sacramentos (sacramento, fecha, celebrante, certifica, testigo_novio, testigo_novia, nombres_novia, apellidos_novia, cedula_novia) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)', [sacramento, fecha, celebrante, certifica, testigo_novio, testigo_novia, nombres_novia, apellidos_novia, cedula_novia])
          $conn.exec("COMMIT")
          FXMessageBox.information(self, MBOX_OK, "Información", "Datos guardados correctamente")
          clear_input_fields
        end
      rescue PG::Error => e
        FXMessageBox.error(self, MBOX_OK, "Error", "Error al guardar los datos")
        # Imprimir el error en la consola
        puts e.message
        # Imprimir detalles del error en la consola
        puts e.backtrace.inspect
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
      @input_name_novio.text = ""
      @input_apellido_novio.text = ""
      @input_cedula_novio.text = ""
      @input_name_novia.text = ""
      @input_apellido_novia.text = ""
      @input_cedula_novia.text = ""
      @input_nombres_testigo_novio.text = ""
      @input_nombres_testigo_novia.text = ""
      @input_certifica.text = ""
      @input_provincia_rc.text = ""
      @input_canton_rc.text = ""
      @input_parroquia_rc.text = ""
      @input_anio_rc.text = ""
      @input_tomo_rc.text = ""
      @input_pag_rc.text = ""
      @input_acta_rc.text = ""
      @input_date_rc.text = ""
    end


  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
