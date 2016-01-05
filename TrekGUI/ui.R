################################################################################
#//    Aleksandr B. Sahakyan (aleksahak [at] cantab.net), Cambridge 2015     \\#
################################################################################
library(shiny)

shinyUI(pageWithSidebar(

  headerPanel("Trek (Transposon Exposed k) Mapper", windowTitle = "TrekGUI"),

  #***#######################################################################
  sidebarPanel(
      imageOutput("logo", width = "100%", height = "300px", inline = FALSE),

      #--#########################################################
      wellPanel(
        selectInput("MutRates", "Database type:", list("sym"   = "sym",
                                                       "nosym" = "nosym")),
        selectInput("nCPU", "Number of CPU (warp) cores:", list("1 core"  = 1,
                                                                "2 cores" = 2,
                                                                "4 cores" = 4,
                                                                "8 cores" = 8,
                                                               "12 cores" = 12,
                                                               "16 cores" = 16,
                                                               "24 cores" = 24))
      )
      #--#########################################################
  ),
  #***#######################################################################

  #***#######################################################################
  mainPanel(

      #--#########################################################
      conditionalPanel(
        condition = "output.text == 'Idle'",
        h5("A program to calculate the sequence-context dependent core neutral substitution rate constants (Homo sapiens, germline) for any DNA sequence, based on the TRansposon Exposed k values. The on-line server version is only suitable for small sequences and cannot utilise more than one CPU core. To use the full power of the program, please download the stand-alone version, usable with or without (terminal access) this graphical user interface, and utilize as many computing processors as possible. The full instruction sets along with the source data are available from ", a("HERE", href="http://trek.atgcdynamics.org/"),".")
      ),
      #--#########################################################

      #--#########################################################
      wellPanel(
        h4("Input"),
        fileInput('FastaFile', 'Upload the DNA fasta file:',accept=NULL),
        checkboxInput(inputId = "pasteseq", label = "Paste the sequence instead.", FALSE),
        conditionalPanel(
          condition = "input.pasteseq == true",
          textInput("sequence", label="Place the cursor on the box below and paste the sequence without blank spaces and new lines:", value = "")
        )
      ),
      #--#########################################################

      #--#########################################################
      verbatimTextOutput("text"),
      #--#########################################################
      conditionalPanel(
        condition = "output.text != 'Idle'",
        downloadButton('downloadTrekOUT', 'Download')
      ),
      #--#########################################################
      tableOutput("out")
  )
  #***#######################################################################

))
################################################################################
