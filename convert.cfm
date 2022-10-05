<cfscript>
  cfsetting( enablecfoutputonly="true")
  thisPath      = expandPath(".")
  emlFilesPath  = thisPath & "/eml/"
  pdfOutputPath = thisPath & "/outputpdf/"
  processedPath = thisPath & "/processed/"

  // Make sure the folders are there
  directoryCreate(emlFilesPath, true, true)
  directoryCreate(pdfOutputPath, true, true)
  directoryCreate(processedPath, true, true)

  dl = directoryList(emlFilesPath, false, 'query', '*.eml')

  // Loop over the first email only (we're going to send one every 5 seconds)
  splitString = "You have made a payment of &##xA3"

  totalProcessed = 0

  dl.filter( function(row, currentRow, qry){
    pdfFileName  = pdfOutputPath & arguments.row.name & ".pdf"
    thisFilePath = emlFilesPath & arguments.row.name;
    fileNewPath  = processedPath & "#createUniqueID()#-#row.name#"
    thisFile     = fileRead( thisFilePath )
    findSplit    = findNoCase(splitString, thisFile)
    thisFile     = right(thisFile, 1+len(thisFile)-(findSplit))

    cfdocument(
      format="pdf"
      , pagetype="A4"
      , orientation="portrait"
      , fontEmbed="true"
      , unit="cm"
      , localUrl="true"
      , filename="#pdfFileName#"
      , marginLeft="0"
      , margintop="0"
      , marginright="0"
      , marginbottom="0"
      , overwrite="true"){
      writeOutput( thisFile );
    }
    fileMove(thisFilePath, fileNewPath)
    totalProcessed++;
    return true
  })

  writeOutput( "Total Processed: " & totalProcessed)
</cfscript>