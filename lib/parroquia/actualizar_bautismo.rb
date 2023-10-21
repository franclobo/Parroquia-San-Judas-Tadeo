require 'fox16'
include Fox

class ActualizarBautismo < FXMainWindow
  def initialize(app, registro)
    super(app, "Editando Registro", :width => 1050, :height => 600)
    @registro = registro
    # Verifica el type de registro
    puts "Registro: #{registro}"

    # create label
    @lbltitle = FXLabel.new(self, "Bienvenido a la Parroquia San Judas Tadeo", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 1050, :height => 20, :x => 0, :y => 20)
    # create label
    @lblsubtitle = FXLabel.new(self, "ARQUIDIOSESIS DE QUITO - VICARIA NORTE SERVICIO PARROQUIAL DE SAN JUDAS TADEO", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 1050, :height => 20, :x => 0, :y => 40)

    #create label
    @date = Time.now.strftime("%d/%m/%Y %H:%M:%S")
    @lbldate = FXLabel.new(self, "Fecha: #{@date}", :opts => LAYOUT_EXPLICIT|JUSTIFY_RIGHT, :width => 1000, :height => 20, :x => 0, :y => 60)
    #section libros
    @lbl_tomo = FXLabel.new(self, "Tomo", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 50, :y => 100)
    # EL input tomoo debe tener el valor del campo "tomo" del registro
    @input_tomo = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 110, :y => 100)
    @input_tomo.text = registro[15]

    @lbl_page = FXLabel.new(self, "Pagina", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 170, :y => 100)
    @input_page = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 230, :y => 100)
    @input_page.text = registro[16]
    @lbl_number = FXLabel.new(self, "Numero", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 290, :y => 100)
    @input_number = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 350, :y => 100)
    @input_number.text = registro[17]

    #section datos
    @lbl_fecha = FXLabel.new(self, "Fecha de bautismo (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 250, :height => 20, :x => 10, :y => 150)
    @input_fecha = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 340, :y => 150)
    @input_fecha.text = registro[2]
    @lbl_sacramento = FXLabel.new(self, "Sacramento: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 150)
    @input_sacramento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 150)
    @input_sacramento.text = registro[1]
    @lbl_parroquia = FXLabel.new(self, "Iglesia parroquial: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 180)
    @input_parroquia = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 180)
    @input_parroquia.text = registro[25]
    @lbl_sector = FXLabel.new(self, "Sector: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 180)
    @input_sector = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 180)
    @input_sector.text = registro[26]
    @lbl_parroco = FXLabel.new(self, "Parroco: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 180)
    @input_parroco = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850, :y => 180)
    @input_parroco.text = registro[27]
    @lbl_ministro = FXLabel.new(self, "Ministro: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 210)
    @input_ministro = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 210)
    @input_ministro.text = registro[3]
    @lbl_name = FXLabel.new(self, "Nombres: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 240)
    @input_name = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 240)
    @input_name.text = registro[19]
    @lbl_apellidos = FXLabel.new(self, "Apellidos: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 240)
    @input_apellidos = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 240)
    @input_apellidos.text = registro[20]
    @lbl_cedula = FXLabel.new(self, "Cédula: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 270)
    @input_cedula = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 270)
    @input_cedula.text = registro[23]
    @lbl_lugar_nacimiento = FXLabel.new(self, "Lugar de nacimiento: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 300)
    @input_lugar_nacimiento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 300)
    @input_lugar_nacimiento.text = registro[21]
    @lbl_fecha_nacimiento = FXLabel.new(self, "Fecha de nacimiento (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 250, :height => 20, :x => 340, :y => 300)
    @input_fecha_nacimiento = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 590, :y => 300)
    @input_fecha_nacimiento.text = registro[22]
    @lbl_padre = FXLabel.new(self, "Padre: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 330)
    @input_padre = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 330)
    @input_padre.text = registro[9]
    @lbl_madre = FXLabel.new(self, "Madre: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 330)
    @input_madre = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 330)
    @input_madre.text = registro[10]
    @lbl_padrino = FXLabel.new(self, "Padrino: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 360)
    @input_padrino = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 360)
    @input_padrino.text = registro[5]
    @lbl_madrina = FXLabel.new(self, "Madrina: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 360)
    @input_madrina = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y => 360)
    @input_madrina.text = registro[6]
    @lbl_certifica = FXLabel.new(self, "Certifica: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 390)
    @input_certifica = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170, :y => 390)
    @input_certifica.text = registro[4]

    #section registro civil
    @lbl_reg_civ = FXLabel.new(self, "------------------------------------ REGISTRO CIVIL ------------------------------------", :opts => LAYOUT_EXPLICIT|JUSTIFY_CENTER_X, :width => 1050, :height => 20, :x => 10, :y => 420)
    @lbl_provincia_rc = FXLabel.new(self, "Provincia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 450)
    @input_provincia_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170,:y => 450)
    @input_provincia_rc.text = registro[29]
    @lbl_canton_rc = FXLabel.new(self, "Cantón: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 340, :y => 450)
    @input_canton_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 510, :y =>450)
    @input_canton_rc.text = registro[30]
    @lbl_parroquia_rc = FXLabel.new(self, "Parroquia: ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 680, :y => 450)
    @input_parroquia_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 850,:y => 450)
    @input_parroquia_rc.text = registro[31]
    @lbl_anio_rc = FXLabel.new(self, "Año: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 50, :y => 480)
    @input_anio_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 110,:y => 480)
    @input_anio_rc.text = registro[32]
    @lbl_tomo_rc = FXLabel.new(self, "Tomo: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 170, :y => 480)
    @input_tomo_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 230,:y => 480)
    @input_tomo_rc.text = registro[33]
    @lbl_pag_rc = FXLabel.new(self, "Página: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 290, :y => 480)
    @input_pag_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 350,:y => 480)
    @input_pag_rc.text = registro[34]
    @lbl_acta_rc = FXLabel.new(self, "Acta: ", :opts => LAYOUT_EXPLICIT, :width => 50, :height => 20, :x => 410, :y => 480)
    @input_acta_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 50,:height => 20, :x => 470,:y => 480)
    @input_acta_rc.text = registro[35]
    @lbl_date_rc = FXLabel.new(self, "Fecha (AAAA/MM/DD): ", :opts => LAYOUT_EXPLICIT, :width => 150, :height => 20, :x => 10, :y => 510)
    @input_date_rc = FXTextField.new(self, 10, :opts => LAYOUT_EXPLICIT, :width => 150,:height => 20, :x => 170,:y => 510)
    @input_date_rc.text = registro[36]


    # create buttons
    @btnupdate = FXButton.new(self, "Actualizar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 790, :y => 540)
    @btncancel = FXButton.new(self, "Cancelar", :opts => LAYOUT_EXPLICIT|BUTTON_NORMAL, :width => 100, :height => 30, :x => 900, :y => 540)

    # connect buttons
    @btnupdate.connect(SEL_COMMAND) do
      tomo = @input_tomo.text
      page = @input_page.text
      number = @input_number.text
      fecha = @input_fecha.text
      sacramento = @input_sacramento.text
      parroquia = @input_parroquia.text
      sector = @input_sector.text
      parroco = @input_parroco.text
      ministro = @input_ministro.text
      name = @input_name.text
      apellidos = @input_apellidos.text
      lugar_nacimiento = @input_lugar_nacimiento.text
      fecha_nacimiento = @input_fecha_nacimiento.text
      cedula = @input_cedula.text.empty? ? nil : @input_cedula.text
      padrino = @input_padrino.text.empty? ? nil : @input_padrino.text
      madrina = @input_madrina.text.empty? ? nil : @input_madrina.text
      padre = @input_padre.text.empty? ? nil : @input_padre.text
      madre = @input_madre.text.empty? ? nil : @input_madre.text
      certifica = @input_certifica.text
      provincia_rc = @input_provincia_rc.text
      canton_rc = @input_canton_rc.text
      parroquia_rc = @input_parroquia_rc.text
      anio_rc = @input_anio_rc.text
      tomo_rc = @input_tomo_rc.text
      pag_rc = @input_pag_rc.text
      acta_rc = @input_acta_rc.text
      date_rc = @input_date_rc.text


      begin
        # tables
          # tabla libros (id, tomo, pagina, numero)
          # tabla creyentes (id, nombres, apellidos, lugar_nacimiento, fecha_nacimiento, cedula)
          # tabla parroquias (id, nombre, sector, parroco)
          # tabla sacramentos (id, nombre, fecha, celebrante, certifica, padrino, madrina, testigo_novio, testigo_novia, padre, madre, nombres_novia, apellidos_novia, cedula_novia, fk_creyentes, fk_parroquias, fk_registros_civiles, fk_libros)
          # tabla registros_civiles (id, provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pagina_rc, acta_rc, fecha_rc)
        # Iniciar una transacción
        $conn.transaction do
          $conn.exec('UPDATE libros SET tomo = $1, pagina = $2, numero = $3 WHERE id = $4', [tomo, page, number, registro[14]])
          $conn.exec('UPDATE sacramentos SET fecha = $1, sacramento = $2, celebrante = $3, certifica = $4, padrino = $5, madrina = $6, padre = $7, madre = $8 WHERE id = $9', [fecha, sacramento, ministro, certifica, padrino, madrina, padre, madre, registro[0]])
          $conn.exec('UPDATE creyentes SET nombres = $1, apellidos = $2, lugar_nacimiento = $3, fecha_nacimiento = $4, cedula = $5 WHERE id = $6', [name, apellidos, lugar_nacimiento, fecha_nacimiento, cedula, registro[18]])
          $conn.exec('UPDATE parroquias SET parroquia = $1, sector = $2, parroco = $3 WHERE id = $4', [parroquia, sector, parroco, registro[24]])
          $conn.exec('UPDATE registros_civiles SET provincia_rc = $1, canton_rc = $2, parroquia_rc = $3, anio_rc = $4, tomo_rc = $5, pagina_rc = $6, acta_rc = $7, fecha_rc = $8 WHERE id = $9', [provincia_rc, canton_rc, parroquia_rc, anio_rc, tomo_rc, pag_rc, acta_rc, date_rc, registro[28]])
          # Confirmar la transacción
          $conn.exec("COMMIT")
          FXMessageBox.information(self, MBOX_OK, "Información", "Datos guardados correctamente")
          clear_input_fields
        end

      rescue PG::Error => e
        FXMessageBox.error(self, MBOX_OK, "Error", "Error al actualizar los datos")
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
      @input_ministro.text = ""
      @input_name.text = ""
      @input_apellidos.text = ""
      @input_lugar_nacimiento.text = ""
      @input_fecha_nacimiento.text = ""
      @input_cedula.text = ""
      @input_padrino.text = ""
      @input_madrina.text = ""
      @input_padre.text = ""
      @input_madre.text = ""
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