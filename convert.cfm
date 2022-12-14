<cfscript>
  // Some paths
  foldeerPath   = expandPath(".")
  emlFilesPath  = foldeerPath & "/eml/"
  pdfOutputPath = foldeerPath & "/outputpdf/"
  processedPath = foldeerPath & "/processed/"

  // Make sure the folders are there
  directoryCreate(emlFilesPath, true, true)
  directoryCreate(pdfOutputPath, true, true)
  directoryCreate(processedPath, true, true)

  // Get a list of files
  dl = directoryList(emlFilesPath, false, 'query', '*.eml')

  // Flag to see how many files processed
  totalProcessed = 0

  // Set this up if you want to pull a certain part off the file
  splitString = ""

  dl.filter( function(row, currentRow, qry){
    pdfFileName  = pdfOutputPath & arguments.row.name & ".pdf"
    thisFilePath = emlFilesPath & arguments.row.name;
    fileNewPath  = processedPath & "#createUniqueID()#-#row.name#"
    // Read the .eml
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