// Verovio options

var $defaultVerovioOptions = {
    header:               'none',
    footer:               'none',
    font:                 'Bravura',
    adjustPageHeight:     true,
    noJustification:      false,
    breaks:               'encoded',
    systemDivider:        'none',
    minLastJustification: '0.5',
    pageMarginLeft:        28,
    pageMarginRight:        0
};
 
function loadMeiFromDoc() {
    /* Read MEI data from <script> elements in the HTML document with @id = the MEI file name (without extension) + '_data'.
       To display options for transposition etc., add another <DIV> for the menu as shown below.
       If an MDIV other than the first is wanted, the word "MDIV" and its id must be appended to the DIV ids (except for the data DIV as explained below).
       Example: 
       <div id="Ul_1535_LN0076_000a04vMDIVmdiv-02_options" class="mei_options"><!-- menu will be generated here; must not be empty --></div>
       <div id="Ul_1535_LN0076_000a04vMDIVmdiv-02" class="mei"><!-- SVG will be put here; must not be empty --></div>
       To avoid duplicate IDs, the data must only be included once in the document _without_ any MDIV indication: 
       <script id="Ul_1535_LN0076_000a04v_data" type="text/xml">[MEI data here]</script> */

    vrvToolkit = new verovio.toolkit();
    console.log("Verovio has loaded");
     
    vrvToolkit.setOptions($defaultVerovioOptions);
    
    $(".verovioSVG").each( function() {
        let id = $(this).attr("id");
        console.log('Rendering ' + id);
        let meiXML = $(dataId(id)).html();
        let svg = vrvToolkit.renderData(meiXML, {});
        document.getElementById(id).innerHTML = svg;

    });
}

function dataId(id) {
    // Return the id of the <script> element that holds the relevant data (necessary for IDs also containing information about the <mdiv> section to extract).
    // If there is no data marked specifically for the desired <mdiv>, we assume that data is to be taken from the original data containing all the MDIVs  
    var dataElementId = (id.indexOf('_mdiv_') > 0 && $('#' + id + '_data').length == 0) ? '#' + id.substring(0, id.indexOf('_mdiv_')) + '_data' : '#' + id + '_data';  
    return dataElementId;
}

function mdivId(id) {
    // Return the id of the desired <mdiv> element specified as part of a compound ID
    var mdiv = (id.indexOf("_mdiv_") > 0) ? id.substring(id.indexOf("_mdiv_")+6) : "";  
    return mdiv;
}

function repositionMei(svg) {
   // Align first bar line or instrument names (if present) with the containing block's left border. 
   // First, calculate the SVG's scaling factor by comparing its actual width with the SVG's default width, which is 2100px (Verovio's default).
   // Ideally the value should be read from the SVG's actual width attribute.
   var scaleFactor = svg.width() / 2100;
   // Add a negative left margin according to the SVG's left margin and the scaling factor
   var newMargin = 0 - $defaultVerovioOptions.pageMarginLeft * scaleFactor;
   svg.css("margin-left",newMargin);
}

function repositionAllMei() {
/* Align SVG with left border of its container */
   $(".verovioSVG").each( function() {
      repositionMei($(this));
    });
}

window.addEventListener("resize", (event) => {
   repositionAllMei();
});

document.addEventListener("DOMContentLoaded", (event) => {
  verovio.module.onRuntimeInitialized = () => {
     loadMeiFromDoc();
  }
});
