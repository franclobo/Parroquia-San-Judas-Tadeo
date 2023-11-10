# frozen_string_literal: true

require 'pg'
require 'fox16'
require 'prawn'
include Fox

class Home < FXMainWindow
  def initialize(app)
    super(app, 'Parroquia San Judas Tadeo', width: 700, height: 500)
    @app = app
    self.backColor = FXRGB(3, 187, 133)

    # Font
    @font = FXFont.new(app, 'Geneva', 12, FONTWEIGHT_BOLD)

    # Inserar imagen del logo
    @image = File.join(File.dirname(__FILE__), 'assets/images/Logo-SJT.png')
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
    @btnsacramentos = FXButton.new(self, 'Sacramentos', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 150,
                                                        height: 30, x: 460, y: 150)
    @btncatecismo = FXButton.new(self, 'Catecismo', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 150,
                                                    height: 30, x: 460, y: 190)
    @btnencabezado = FXButton.new(self, 'Encabezado', opts: LAYOUT_EXPLICIT | BUTTON_NORMAL, width: 150,
                                                      height: 30, x: 460, y: 230)

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
    @btnsacramentos.connect(SEL_COMMAND) do
      require_relative 'sacramentos/sacramentos'
      vtnsacramentos = Sacramentos.new(@app)
      vtnsacramentos.create
      vtnsacramentos.show(PLACEMENT_SCREEN)
    end
    @btncatecismo.connect(SEL_COMMAND) do
      require_relative 'catecismo/catecismo'
      vtncatecismo = Catecismo.new(@app)
      vtncatecismo.create
      vtncatecismo.show(PLACEMENT_SCREEN)
    end
    @btnencabezado.connect(SEL_COMMAND) do
      seleccionar_directorio
      imprimir_pdf
    end
  end

  def seleccionar_directorio
    dialog = FXDirDialog.new(self, 'Seleccionar directorio para guardar PDF')
    return unless dialog.execute != 0
    directorio = dialog.getDirectory
    @archivo_pdf = "#{directorio}/Encabezado.pdf"
  end

  def imprimir_pdf
    # Genera el archivo PDF
    Prawn::Document.generate(@archivo_pdf, margin: [100, 100, 100, 100]) do |pdf|
      pdf.font 'Helvetica'
      pdf.font_size 12
      # Definir tres casos en los que se puede imprimir el certificado y los distintos formatos para bautismo, confirmación y matrimonio
      # Bautismo
      # Encabezado
      pdf.image File.join(File.dirname(__FILE__), './assets/images/arquidiocesisquito.png'), height: 80,
                                                                                              position: :absolute, at: [-60, 680]
      pdf.text_box 'Arquidiócesis de Quito', align: :center, size: 16, style: :bold, at: [10, 670],
                                              width: pdf.bounds.width
      pdf.text_box 'Parroquia Eclesiástica "San Judas Tadeo"', align: :center, size: 14, style: :bold,
                                                                at: [10, 650], width: pdf.bounds.width
      pdf.text_box "Jaime Roldós Aguilera, calle Oe13A y N82\nEl Condado, Quito - Ecuador\nTeléfono: 02496446",
                    align: :center, size: 10, at: [10, 630], width: pdf.bounds.width
      pdf.image File.join(File.dirname(__FILE__), './assets/images/sanjudastadeo.png'), height: 80,
                                                                                          position: :absolute, at: [430, 680]
      # Abre el archivo PDF con el visor de PDF predeterminado del sistema
      system("xdg-open '#{@archivo_pdf}'")
      # Mensaje de confirmación
      FXMessageBox.information(self, MBOX_OK, 'Información', 'El archivo PDF se ha generado correctamente')
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

app = FXApp.new
Home.new(app)
app.create
app.run
