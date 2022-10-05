# eml2pdf
Convert .eml files to basic PDF

It's not fancy, its not Javascript, but it generates a PDF from an .eml file in 40 lines of code.

## Requirements

1. You'll need [CommandBox](https://commandbox.ortusbooks.com/setup/installation) installed. If you're on a Mac you can use `brew install commandbox`
2. Clone this repos `https://github.com/andyj/eml2pdf.git`


## Running
1. Place your .eml files in the /eml folder
2. Run `box convert.cfm`.
3. When finished you it should report how many files were processed e.g. *Total Processed: XX*
4. Check `/outputpdf/` for your PDF files
5. Check `eml/` is empty, and the files moved to `/processed/`



## Folder structure

```
/eml2pdf
 + /eml/ - Where you'll place your .eml file
 + /outputpdf/ - Generated PDF files
 + /processed/ - This is where the .eml files are moved to once processed

```


