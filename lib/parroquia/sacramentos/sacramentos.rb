# frozen_string_literal: true

require 'pg'
require 'fox16'
include Fox

class Sacramentos < FXMainWindow
  def initialize(app)
    super(app, 'Parroquia San Judas Tadeo', width: 800, height: 500)
    @app = app
    self.backColor = FXRGB(3, 187, 133)

    # Font
    @font = FXFont.new(app, 'Geneva', 12, FONTWEIGHT_BOLD)

    # Inserar imagen del logo
    @image = File.join(File.dirname(__FILE__), '../assets/images/Logo-SJT.png')
    @image = File.open(@image, 'rb')
    @image = FXPNGIcon.new(app, @image.read)
    @logo = FXImageFrame.new(self, @image, opts: LAYOUT_EXPLICIT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y, width: 400,
                                           height: 250, x: 10, y: 100)
    # Color de fondo de image frame es el mismo que el de la ventana
    @logo.backColor = FXRGB(3, 187, 133)
    # Escalar imagen
    @image.scale(400, 250)

    # Title
    @lbltitle = FXLabel.new(self, 'Bienvenido a la Parroquia San Judas Tadeo',
                            opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700, height: 20, x: 0, y: 20)
    @lbltitle.font = FXFont.new(app, 'Geneva', 16, FONTWEIGHT_BOLD)
    @lbltitle.backColor = FXRGB(3, 187, 133)
    # Subtitle
    @lblsubtitle = FXLabel.new(self, 'ARQUIDIOSESIS DE QUITO - SERVICIO PARROQUIAL DE SAN JUDAS TADEO',
                               opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700, height: 20, x: 0, y: 40)
    @lblsubtitle.font = FXFont.new(app, 'Geneva', 10, FONTWEIGHT_BOLD)
    @lblsubtitle.backColor = FXRGB(3, 187, 133)
    # Date
    @date = Time.now.strftime('%d/%m/%Y')
    @lbldate = FXLabel.new(self, "Fecha: #{cambiar_formato_fecha(@date)}", opts: LAYOUT_EXPLICIT | JUSTIFY_RIGHT,
                                                                           width: 700, height: 20, x: 0, y: 60, padRight: 20)
    @lbldate.font = FXFont.new(app, 'Geneva', 12, FONTWEIGHT_BOLD)
    @lbldate.backColor = FXRGB(3, 187, 133)

    # section lista
    @btnbautizo = FXButton.new(self, 'Ingresar Bautismo', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 150,
                                                          height: 30, x: 460, y: 150)
    @btncomunion = FXButton.new(self, 'Ingresar Comunión', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 150,
                                                           height: 30, x: 460, y: 190)
    @btnconfirmacion = FXButton.new(self, 'Ingresar Confirmación', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL,
                                                                   width: 150, height: 30, x: 460, y: 230)
    @btnmatrimonio = FXButton.new(self, 'Ingresar Matrimonio', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 150,
                                                               height: 30, x: 460, y: 270)
    @btnconsulta = FXButton.new(self, 'Consultar', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 150, height: 30,
                                                   x: 460, y: 310)
    @btnsupletoria = FXButton.new(self, 'Partida Supletoria', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 150,
                                                              height: 30, x: 620, y: 150)
    @btnprebautismal = FXButton.new(self, 'Certificado Prebautismal', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL,
                                                                      width: 150, height: 30, x: 620, y: 190)
    @btnpermisobautizo = FXButton.new(self, 'Permiso de Bautismo', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL,
                                                                   width: 150, height: 30, x: 620, y: 230)
    @btnprematrimonial = FXButton.new(self, 'Permiso Prematrimonial', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL,
                                                                      width: 150, height: 30, x: 620, y: 270)
    @btnlicenciamatrimonio = FXButton.new(self, 'Licencia de Matrimonio', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL,
                                                                          width: 150, height: 30, x: 620, y: 310)
    @btnmisa = FXButton.new(self, 'Misa', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 150, height: 30,
                                          x: 620, y: 350)
    # Footer
    @lblfooter = FXLabel.new(self, 'WebMinds Studio - 2023', opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700,
                                                             height: 20, x: 0, y: 400)
    @lblfooter.font = FXFont.new(app, 'Geneva', 10)
    @lblfooter.backColor = FXRGB(3, 187, 133)
    @lblauthor = FXLabel.new(self, 'Desarrollado por Ing. Francisco J. Borja L.',
                             opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700, height: 20, x: 0, y: 420)
    @lblauthor.font = FXFont.new(app, 'Geneva', 10)
    @lblauthor.backColor = FXRGB(3, 187, 133)
    @lblweb = FXLabel.new(self, 'www.webmindsstudio.com', opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700,
                                                          height: 20, x: 0, y: 440)
    @lblweb.font = FXFont.new(app, 'Geneva', 10)
    @lblweb.backColor = FXRGB(3, 187, 133)
    @lbllicence = FXLabel.new(self, 'MIT License', opts: LAYOUT_EXPLICIT | JUSTIFY_CENTER_X, width: 700,
                                                   height: 20, x: 0, y: 460)
    @lbllicence.font = FXFont.new(app, 'Geneva', 10)
    @lbllicence.backColor = FXRGB(3, 187, 133)
    # section buttons executions
    @btnbautizo.connect(SEL_COMMAND) do
      require_relative 'bautizo'
      vtnbautizo = Bautizo.new(@app)
      vtnbautizo.create
      vtnbautizo.show(PLACEMENT_SCREEN)
    end
    @btncomunion.connect(SEL_COMMAND) do
      require_relative 'comunion'
      vtncomunion = Comunion.new(@app)
      vtncomunion.create
      vtncomunion.show(PLACEMENT_SCREEN)
    end
    @btnconfirmacion.connect(SEL_COMMAND) do
      require_relative 'confirmacion'
      vtnconfirmacion = Confirmacion.new(@app)
      vtnconfirmacion.create
      vtnconfirmacion.show(PLACEMENT_SCREEN)
    end
    @btnmatrimonio.connect(SEL_COMMAND) do
      require_relative 'matrimonio'
      vtnmatrimonio = Matrimonio.new(@app)
      vtnmatrimonio.create
      vtnmatrimonio.show(PLACEMENT_SCREEN)
    end
    @btnconsulta.connect(SEL_COMMAND) do
      require_relative 'consultas'
      vtnconsulta = Consulta.new(@app)
      vtnconsulta.create
      vtnconsulta.show(PLACEMENT_SCREEN)
    end
    @btnsupletoria.connect(SEL_COMMAND) do
      require_relative 'supletoria'
      vtnsupletoria = Supletoria.new(@app)
      vtnsupletoria.create
      vtnsupletoria.show(PLACEMENT_SCREEN)
    end
    @btnprebautismal.connect(SEL_COMMAND) do
      require_relative 'certificado_prebautismal'
      vtnprebautismal = PreBautismal.new(@app)
      vtnprebautismal.create
      vtnprebautismal.show(PLACEMENT_SCREEN)
    end
    @btnpermisobautizo.connect(SEL_COMMAND) do
      require_relative 'permiso_bautismo'
      vtnpermisobautizo = PermisoBautizo.new(@app)
      vtnpermisobautizo.create
      vtnpermisobautizo.show(PLACEMENT_SCREEN)
    end
    @btnprematrimonial.connect(SEL_COMMAND) do
      require_relative 'permiso_prematrimonial'
      vtnprematrimonial = PermisoMatrimonio.new(@app)
      vtnprematrimonial.create
      vtnprematrimonial.show(PLACEMENT_SCREEN)
    end
    @btnlicenciamatrimonio.connect(SEL_COMMAND) do
      require_relative 'licencia_matrimonio'
      vtnlicenciamatrimonio = LicenciaMatrimonio.new(@app)
      vtnlicenciamatrimonio.create
      vtnlicenciamatrimonio.show(PLACEMENT_SCREEN)
    end
    @btnmisa.connect(SEL_COMMAND) do
      require_relative 'misa'
      vtnmisa = Misa.new(@app)
      vtnmisa.create
      vtnmisa.show(PLACEMENT_SCREEN)
    end
  end

  # Nombre del mes
  def nombre_mes(mes)
    meses = {
      '01' => 'enero',
      '02' => 'febrero',
      '03' => 'marzo',
      '04' => 'abril',
      '05' => 'mayo',
      '06' => 'junio',
      '07' => 'julio',
      '08' => 'agosto',
      '09' => 'septiembre',
      '10' => 'octubre',
      '11' => 'noviembre',
      '12' => 'diciembre'
    }
    meses[mes]
  end

  # Cambiar el formato de la fecha de YYYY-MM-DD a DD de nombre_mes de YYYY
  def cambiar_formato_fecha(fecha)
    # split "-" or "/"
    fecha = fecha.split(%r{-|/})
    # si el formato de fecha es YYYY-MM-DD o YYYY/MM/DD, sino si es DD-MM-YYYY o DD/MM/YYYY
    if fecha[0].length == 4
      "#{fecha[2]} de #{nombre_mes(fecha[1])} de #{fecha[0]}"
    else
      "#{fecha[0]} de #{nombre_mes(fecha[1])} de #{fecha[2]}"
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

$conn = PG.connect(host: 'localhost', port: '5432', dbname: 'sacramentos', user: 'postgres', password: 'postgres')
# Comprobar conexión con la base de datos
exit if $conn.status != PG::CONNECTION_OK
