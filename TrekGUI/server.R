################################################################################
#//    Aleksandr B. Sahakyan (aleksahak [at] cantab.net), Cambridge 2015     \\#
################################################################################
options(shiny.maxRequestSize=8000*1024^2)       # max allowed upload size - 8GB
library(shiny)

shinyServer(function(input, output){

    out    <- NULL
    status <- NULL

    update.out <- reactive({
      if(!is.null(input$FastaFile) | input$sequence!=""){
        status <<- "Chartering of the provided sequence is in progress..."
        #output$status <- renderText({status})
        out <- Trek(FastaFile=input$FastaFile$datapath,
                    OutFile="out.txt", MutRates=input$MutRates,
                    nCPU=as.numeric(input$nCPU),
                    parsed.seq=input$sequence)
        output$downloadTrekOUT <<- downloadHandler(
          filename=function(){"out.txt"},
          content=function(file){ file.rename(from="out.txt", to=file) }
        )
        output$out <<- renderTable({ data.frame(out, stringsAsFactors=FALSE) })
        status <<- "Trek is done! You can download the full output from the link below."
        #output$status <- renderText({status})
      } else {
        status <<- "Idle"
        #output$status <- renderText({status})
      }
    })

    #***#######################
    output$logo <- renderImage({
     list(src = "Trek_logo.png",
          contentType = 'image/png',
          width = 230, height = 260,
          alt = "No logo is found...")
    }, deleteFile = FALSE)
    #***#######################

    #***#######################
    output$text <-  renderText({
      withProgress(message="Chartering in progress...", value=5,
                   {  update.out()  })
      return(status)
    })
    #***#######################

})
################################################################################
