//boolean to check if certificate exists in client user machine now , before using it to sign
var isCertificateExist = false;

//function checks:
//1- document extension is pdf
//2- certificate serial number is saved in profile
//3- plug-in is running
//4- certificate is physically exists in client user machine now
//if all the above succeeded , then sign the document and import new version to jupiter
function validateCertificateAndSign() {
    //1-Check document extension to apply digital signature to only PDFs
    //2-Check if there is alias saved in profile
    //3-Check if Plug-in is running
    //if plug-in down after setting isSignaturePluginRunning to true , service call of check certificate will alert the error that will force me to refresh the page and re check isSignaturePluginRunning and set to false.
    //if plug-in running after setting isSignaturePluginRunning to false, user must refresh page manually.
    //in both cases , user must refresh.
    if (extensionOfDoc != "pdf") {
        return extError;
    }
    else if (typeof certificateInProfile == 'undefined' || !certificateInProfile || certificateInProfile.length === 0 || certificateInProfile === "" || !/[^\s]/.test(certificateInProfile) || /^\s*$/.test(certificateInProfile) || certificateInProfile.replace(/\s/g, "") === "") {
        return certDNEError;
    }
    else if (!checkSignaturePluginRunningServiceCall()) {
        return pluginError;
    }
    else {
        //4- check if certificate isExist in client user machine certificate store
        var certCheckErrorInService = checkCertificateExistServiceCall();
        if (certCheckErrorInService) {
            return certCheckError;
        }
        // if certificate is retrieved successfully  , Sign PDF and create new version ; else alert error message
        if (isCertificateExist) {
            var signedItemSuccessfuly = signAndImportNewVersion();
            // var signedItemSuccessfuly = true;
            if (signedItemSuccessfuly) {
                return signSucceed;
            }
            else {
                return signFailed;
            }
        }
        else {
            return certDelError;
        }
    }

}


function checkSignaturePluginRunningServiceCall() {
    var isPlugginOn = true;
    jQuery.ajax({
        url: "http://" + digitalSignaturePDFPluginIP + ":" + digitalSignaturePDFPluginPort + "/digital-signature/check-connection",
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        type: "GET",
        dataType: "json",
        data: {},
        cache: false,
        success: function (result) {
            if (!result.succeeded) {
                isPlugginOn = false;
            }
        },
        error: function () {
            isPlugginOn = false;
        },
        async: false
    });

    return isPlugginOn;
}

function checkCertificateExistServiceCall() {
    var certCheckErrorInService = false;
    jQuery.ajax({
        url: "http://" + digitalSignaturePDFPluginIP + ":" + digitalSignaturePDFPluginPort + "/certificate/check-privatekey-exist",
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        type: "GET",
        dataType: "json",
        data: {
            serialNumber: certificateSerialNumInProfile
        },
        cache: false,
        success: function (result) {
            if (result.succeeded) {
                isCertificateExist = result.resultObject;
            }
            if (!result.succeeded) {
                alert("Exception:" + result.exceptionDetails);
            }
        },
        error: function () {
            certCheckErrorInService = true;
        },
        async: false
    });

    return certCheckErrorInService;
}


function signAndImportNewVersion() {

    // sign Ajax Request
    var signAndImportNewVersionResp = false;

        var post_url = '/signature/sign-pdf'; //get form action url
        var request_method = 'post'; //get form GET/POST method



        // Get form

        var data = new FormData();

//$("#attachment").get(0).files[0]
        data.append("attachment",$("#attachment").get(0).files[0] );
        data.append("serialNumber",certificateSerialNumInProfile);
        data.append("signatureProperties",signaturePropertiesSerialized);
        data.append("itemId",itemId);
        //$("#image").get(0).files[0]
        // data.append("image",'image');
        // isToken , signaturePin ,driverLibraryName

        // ajax save to database
        $.ajax({
            type: 'POST',
            enctype: 'multipart/form-data',
            url: "http://localhost:8085"+post_url ,
            data:data,
            processData: false, //prevent jQuery from automatically transforming the data into a query string
            contentType: false,
            cache: false,
            timeout: 600000,
        success: function (json) {
            signAndImportNewVersionResp = json._object;
        },
        error: function () {
            signAndImportNewVersionResp = false;
        },
        async: false

        });


        console.log(post_url + "   " + request_method +"    " + signAndImportNewVersionResp);



    // jQuery.ajax({
    //     url: context + "/rest/import/signAndImportPDF",
    //     headers: {
    //         'Content-Type': 'application/x-www-form-urlencoded'
    //     },
    //     type: "GET",
    //     dataType: "json",
    //     data: {
    //         pluginIP: digitalSignaturePDFPluginIP,
    //         pluginPort: digitalSignaturePDFPluginPort,
    //         parentId: parentId,
    //         parentType: parentType,
    //         itemId: itemId,
    //         serialNum: certificateSerialNumInProfile,
    //         signatureProperties: signaturePropertiesSerialized,
    //         importNewVersion: "true"
    //     },
    //     cache: false,
    //     success: function (json) {
    //         signAndImportNewVersionResp = json._object;
    //     },
    //     error: function () {
    //         signAndImportNewVersionResp = false;
    //     },
    //     async: false
    // });
    return signAndImportNewVersionResp;
}
