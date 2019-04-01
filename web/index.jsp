<%--
  Created by IntelliJ IDEA.
  User: ahmed.marey
  Date: 3/27/2019
  Time: 9:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>


<html>
<head>
    <title>$Title$</title>
    <meta charset="UTF-8">
    <!--Internet explorer-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--first Mobile Meta-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Title</title>

    <!--bootstrap stylesheet-->
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/css.css">
    <link rel="stylesheet" href="css/style.css">

    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>


    <![endif]-->
    <!--jquery lib-->
    <script src="js/jquery-2.0.0.js"></script>
    <!--bootstrap lib-->
    <script src="js/bootstrap.min.js"></script>
    <!--custom js file -->
    <script src="js/script.js"></script>
    <script src="js/pdfDigitalSignatureAction.js"></script>

</head>
<body>
<script>
    <%
//                // get it from user database signature settings (request)
//                String signaturePositionInProfile =  (String)profileModel.getSettings().get(ProfileModel.DIGITAL_SIGNATURE_POSITION);
//                String signatureAlignmentInProfile =  (String)profileModel.getSettings().get(ProfileModel.DIGITAL_SIGNATURE_ALIGNMENT);
//                String signaturePageNumberInProfile = (String)profileModel.getSettings().get(ProfileModel.DIGITAL_SIGNATURE_PAGENO);
//                String certificateInProfile = (String)profileModel.getSettings().get(ProfileModel.DIGITAL_SIGNATURE_ALIAS);
//                String certificateSerialNumInProfile = (String)profileModel.getSettings().get(ProfileModel.DIGITAL_SIGNATURE_SERIAL_NUMBER);
//                String clientMachineIPInProfile = (String)profileModel.getSettings().get(ProfileModel.DIGITAL_SIGNATURE_CLIENT_IP);
//
//                String digitalSignaturePDFPluginPort="8080";
//                if( session.getAttribute("siteEntries") != null ){
//                    digitalSignaturePDFPluginPort =  (String) ((Map)session.getAttribute("siteEntries")).get(WebKeys.DigitalSignaturePDFPluginPort);
//                    if(digitalSignaturePDFPluginPort==null){
//                        digitalSignaturePDFPluginPort="8080";
//                    }
//                }
            %>
    var certificateInProfile = 'ahmed marey';
    var certificateSerialNumInProfile = '-35936765170763056493867';
    var digitalSignaturePDFPluginIP = 'localhost';
    var digitalSignaturePDFPluginPort = '8085';
    var extensionOfDoc = 'pdf';

    var itemId = '100';
    var parentId = '50';
    var parentType = '2';
    var context = '<%=request.getContextPath()%>';
    var signaturePropertiesSerialized = "signaturePosition=" + '2' +
        "&signatureAlignment=" + '2' + "&signaturePageNumber=" + '1';
    <%--<bean:message key="label.common.clientIp.label" />--%>

    var extError = "<bean:message key="JUPITER_SIGNATURE_ACTION_EXT_ERROR" />";
    var certDNEError = "<bean:message key="JUPITER_SIGNATURE_ACTION_CERTIFICATE_DNE_ERROR" />";
    var pluginError = "<bean:message key="JUPITER_SIGNATURE_ACTION_PLUGIN_ERROR" />";
    var certDelError = "<bean:message key="JUPITER_SIGNATURE_ACTION_CERTIFICATE_DEL_ERROR" />";
    var certCheckError = "<bean:message key="JUPITER_SIGNATURE_ACTION_CERTIFICATE_CHECK_ERROR" />";
    var signSucceed = "<bean:message key="JUPITER_SIGNATURE_ACTION_SUCCESS" />";
    var signFailed = "<bean:message key="JUPITER_SIGNATURE_ACTION_FAIL" />";


    function digitalSignPdf()// digital signature
    {
        var responseMessageSign = validateCertificateAndSign();
        alert(responseMessageSign);
        //refresh if successfully signed the document
        if (responseMessageSign == signSucceed)
            location.reload();
    }

    // *********************************************

    function openSettingDialog() {
        var url = '<%=request.getContextPath()%>/CMSSignatureModel.do';
        console.log(url);

        openPopUpWindow(url, 'openSettingsWindow', 750, 650);
    }

    function openPopUpWindow(url, winName, width, height, paramWinFeatures) {
        var popUpWindowWidth = width;
        var popUpWindowHeight = height;
        var centerLeft = (window.screen.width - popUpWindowWidth) / 2;
        var centerTop = (window.screen.height - popUpWindowHeight) / 2;
        var features = 'width=' + width + ',height=' + height + ',left=' + centerLeft + ',top=' + 10;
        if (paramWinFeatures != null) {
            features += ',' + paramWinFeatures
        }
        else {
            features += ',menubar=no,resizable=no,scrollbars=no,status=no';
        }
        var popUpWindow = window.open(url, winName, features);
        return popUpWindow;
    }


</script>
<button class="btn-primary" onclick="openSettingDialog();">اعدادات التوقيع</button>


<div class="row ">

    <div class="col-md-6">

        <div class="form-group files color">
            <label>Upload Your File </label>
            <input type="file" id="attachment" class="form-control" multiple="false">
        </div>

    </div>
</div>

<button class="btn-danger" onClick ="digitalSignPdf();"> توقيع</button>

</body>
</html>
