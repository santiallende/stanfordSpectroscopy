#load libraries
library(pdftools)
library(stringr)
library(dplyr)

#create list of files
files <- list.files("~/Desktop/StimpsonPdfs", pattern = "*.pdf",
                    full.names = F, recursive = F)

#create empty df to add to
masterDf <- data.frame()

#clean/structure each file and combine into master dataframe
for (x in files) {
        
        #parse name of pdf file
        study <- word(x, 1, sep = "_")
        id <- word(x, 2, sep = "_")
        roi <- word(x, 3, sep = "_")
        prePost <- word(x, 4, sep = "_")
        task <- word(x, 5, sep = "_")
        task <- unlist(strsplit(task, ".pdf"))
        
        #read pdf file and convert to dataframe
        myPdf <- pdf_data(x)
        myPdf <- as.data.frame(myPdf)
        myPdf <- dplyr::select(myPdf, text)
        
        #parse data
        fileName <- myPdf[3, 1]
        
        gabaGlxArea <- myPdf[7, 1]
        gabaPlusArea <- word(gabaGlxArea, 1, sep = "/")
        glxArea <- word(gabaGlxArea, 2, sep = "/")
        
        waterCrArea <- myPdf[11, 1]
        waterArea <- word(waterCrArea, 1, sep = "/")
        crArea <- word(waterCrArea, 2, sep = "/")
        
        fwhmWaterCr <- myPdf[15, 1]
        fwhmWater <- word(fwhmWaterCr, 1, sep = "/")
        fwhmCr <- word(fwhmWaterCr, 2, sep = "/")
        
        fitErrWaterCrGaba <- myPdf[21, 1]
        fitErrWaterGaba <- word(fitErrWaterCrGaba, 1, sep = "/")
        fitErrCrGaba <- word(fitErrWaterCrGaba, 2, sep = "/")
        
        fitErrWaterCrGlx <- myPdf[24, 1]
        fitErrWaterGlx <- word(fitErrWaterCrGlx, 1, sep = "/")
        fitErrCrGlx <- word(fitErrWaterCrGlx, 2, sep = "/")
        
        gabaGlxWater <- myPdf[28, 1]
        gabaPlusWater <- word(gabaGlxWater, 1, sep = "/")
        glxWater <- word(gabaGlxWater, 2, sep = "/")
        
        gabaGlxCr <- myPdf[33, 1]
        gabaPlusCr <- word(gabaGlxCr, 1, sep = "/")
        glxCr <- word(gabaGlxCr, 2, sep = "/")
        
        fitVer <- myPdf[36, 1]
        
        #create clean/individual dataframe
        myDf <- data.frame(study, id, roi, prePost, task, fileName, 
                           gabaPlusArea, glxArea, waterArea, crArea,
                           fwhmWater, fwhmCr, fitErrWaterGaba, 
                           fitErrCrGaba, fitErrWaterGlx, fitErrCrGlx, 
                           gabaPlusWater, glxWater, gabaPlusCr, glxCr, fitVer,
                           stringsAsFactors = F)
        
        #combine rows into master dataframe
        masterDf <- rbind(masterDf, myDf)
        
        #write csv file
        write.csv(masterDf, "masterDf.csv", row.names = F)
}
















































