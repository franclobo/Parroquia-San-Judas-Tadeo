require 'fox16'
include Fox

class Confirmacion < FXMainWindow
  def initialize(app)
    @app = app
    super(app, 'Parroquia San Judas Tadeo', width: 700, height: 500)
    # create label
    @lbltitle = FXLabel.new(self, 'Bienvenido a la Parroquia San Judas Tadeo',
                            opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700, height: 20, x: 0, y: 20)
    # create label
    @lblsubtitle = FXLabel.new(self, 'ARQUIDIOSESIS DE QUITO - VICARIA NORTE SERVICIO PARROQUIAL DE SAN JUDAS TADEO',
                               opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700, height: 20, x: 0, y: 40)

    # create label
    @date = Time.now.strftime('%d/%m/%Y %H:%M:%S')
    @lbldate = FXLabel.new(self, "Fecha: #{@date}", opts: LAYOUT_EXPLICIT | JUSTIFY_RIGHT, width: 680,
                                                    height: 20, x: 0, y: 60)
    # section libros
    @lbltomo = FXLabel.new(self, 'Tomo', opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 10, y: 100)
    @inputtomo = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 70, y: 100)
    @lblpage = FXLabel.new(self, 'Pagina', opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 130, y: 100)
    @inputpage = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 190, y: 100)
    @lblnumber = FXLabel.new(self, 'Numero', opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 250,
                                             y: 100)
    @inputnumber = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 50, height: 20, x: 310, y: 100)

    # section datos
    @lblname = FXLabel.new(self, 'Fecha de confirmación: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                            x: 10, y: 150)
    @inputname = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170, y: 150)
    @lblname = FXLabel.new(self, 'Iglesia parroquial: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20,
                                                         x: 10, y: 180)
    @inputname = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170, y: 180)
    @lblname = FXLabel.new(self, 'Celebrante: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                 y: 210)
    @inputname = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170, y: 210)
    @lblname = FXLabel.new(self, 'Nombres: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                              y: 240)
    @inputname = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170, y: 240)
    @lblname = FXLabel.new(self, 'Apellidos: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                y: 270)
    @inputname = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170, y: 270)
    @lblpadrino = FXLabel.new(self, 'Padrino: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                 y: 300)
    @inputpadrino = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170,
                                              y: 300)
    @lblname = FXLabel.new(self, 'Certifica: ', opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 10,
                                                y: 330)
    @inputname = FXTextField.new(self, 10, opts: LAYOUT_EXPLICIT, width: 150, height: 20, x: 170, y: 330)

    # create buttons
    @btnsave = FXButton.new(self, 'Guardar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                             x: 120, y: 400)
    @btncancel = FXButton.new(self, 'Cancelar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 100, height: 30,
                                                x: 230, y: 400)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
