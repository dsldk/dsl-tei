// Verovio options

var $defaultVerovioOptions = {
    scale:                100,
    pageWidth:            1800,
    scaleToPageSize:      false,
    header:               'none',
    footer:               'none',
    font:                 'Bravura',
    adjustPageHeight:     true,
    adjustPageWidth:      false,
    noJustification:      false,
    pageMarginRight:      0,
    pageMarginLeft:       40,
    pageMarginTop:        10,
    pageMarginBottom:     10,
    breaks:               'encoded',
    systemDivider:        'none',
    minLastJustification: 0.5
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


document.addEventListener("DOMContentLoaded", (event) => {
   console.log("Document loaded");
   verovio.module.onRuntimeInitialized = () => {
        loadMeiFromDoc();
     }
});
