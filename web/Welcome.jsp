<%@ page import="model.CMSSignatureModel" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: ahmed.marey
  Date: 3/28/2019
  Time: 2:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@page import="signatureAction" %>--%>

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>


<%
    CMSSignatureModel CMSSignatureModel = (CMSSignatureModel) request.getAttribute("CMSSignatureModel");
    String digitalSignaturePDFPluginPort = (String) request.getAttribute("digitalSignaturePDFPluginPort");
    if (digitalSignaturePDFPluginPort.isEmpty() || digitalSignaturePDFPluginPort == null)
        digitalSignaturePDFPluginPort = "8080";
    if (CMSSignatureModel.getDIGITAL_SIGNATURE_ALIAS() == null) CMSSignatureModel.setDIGITAL_SIGNATURE_ALIAS("");
    if (CMSSignatureModel.getDIGITAL_SIGNATURE_IMAGE() == null) CMSSignatureModel.setDIGITAL_SIGNATURE_IMAGE("");
//    Map positionMap = (Map) request.getAttribute("positionMap");
//    System.out.println(CMSSignatureModel.getDIGITAL_SIGNATURE_ALIAS() + "    pppppppppp ");

%>

<html>
<head>
    <title>Title</title>
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
    <style>


        /************** image style */
        body {
            background: whitesmoke;
            font-family: 'Open Sans', sans-serif;
        }

        .container {
            max-width: 960px;
            margin: 30px auto;
            padding: 20px;
        }

        h1 {
            font-size: 20px;
            text-align: center;
            margin: 20px 0 20px;
        }

        h1 small {
            display: block;
            font-size: 15px;
            padding-top: 8px;
            color: gray;
        }

        .avatar-upload {

            max-width: 243px;
            margin: auto;
        }

        .avatar-upload .avatar-edit {
            position: absolute;
            right: -5px;
            z-index: 1;
        }

        .avatar-upload .avatar-edit input {
            display: none;
        }

        .avatar-upload .avatar-edit input + label {
            padding-top: 5px;
            border-radius: 10%;
            text-align: center;
            display: inline-block;
            width: 80px;
            height: 30px;
            margin-bottom: 0;
            background: rgba(0, 0, 0, 0.12);
            border: 1px solid transparent;
            box-shadow: 0px 2px 4px 0px lightgray;
            cursor: pointer;
            font-weight: normal;
            transition: all 0.2s ease-in-out;

        }

        .avatar-upload .avatar-edit input + label:hover {
            background: #f1f1f1;
            border-color: #d6d6d6;
        }

        .avatar-upload .avatar-edit input + label:after {
            /*content: "\f040";*/
            font-family: 'FontAwesome';
            color: #757575;
            position: absolute;
            top: 10px;
            left: 0;
            right: 0;
            text-align: center;
            margin: auto;
        }

        .avatar-upload .avatar-preview {
            width: 192px;
            height: 192px;
            position: relative;
            /*border-radius: 100%;*/
            /*border: 6px solid #F8F8F8;*/
            /*box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.1);*/
        }

        .avatar-upload .avatar-preview > div {
            width: 100%;
            height: 100%;
            /*border-radius: 100%;*/
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }

        #refreshCertificatesList:hover {
            color: blue;
        }


    </style>
</head>
<body>

<html:form action="/saveSettings" method="post" enctype="multipart/form-data">


    <div class="container-fluid" style="margin-top: 20px;">

        <span class="badge badge-success center-block"
              style="font-size: large;
               margin-bottom: 20px;"><bean:message key="label.common.signature.label" /></span>

            <%--***************** Error **************--%>
        <div style="color:red">
            <html:errors/>
        </div>

        <html:messages id="err_name" property="common.name.err">
            <div style="color:red">
                <bean:write name="err_name"/>
            </div>
        </html:messages>
            <%--***************************************************--%>

        <div class="form-horizontal col-md-12 col-sm-12">
            <div class="alert alert-danger" role="alert" id="certNotExist" style="display:none">
                <bean:message key="SIGNATURE_CERT_ERROR" />
            </div>
            <div class="alert alert-danger" role="alert" id="pluginDown" style="display:none">
                <bean:message key="SIGNATURE_PLUGIN_ERROR" />
            </div>


            <!-- Client User Machine IP Address -->
            <div class="form-group">

                <html:hidden property="cmsSignatureModel.USER_ID"
                             value="<%=String.valueOf(CMSSignatureModel.getUSER_ID())%>" styleId="digitalUserId"/>
                <html:hidden property="cmsSignatureModel.ID" value="<%=String.valueOf(CMSSignatureModel.getID())%>"
                             styleId="digitalId"/>
                <html:hidden property="cmsSignatureModel.DIGITAL_SIGNATURE_IMAGE"
                             value="<%=CMSSignatureModel.getDIGITAL_SIGNATURE_IMAGE()%>" styleId="digitalImage"/>

                <label class="col-md-5 col-xs-5 control-label"><bean:message key="label.common.clientIp.label" /></label>
                <div class="col-md-5 col-xs-5">
                    <html:text property="cmsSignatureModel.DIGITAL_SIGNATURE_CLIENT_IP"
                               value="<%=CMSSignatureModel.getDIGITAL_SIGNATURE_CLIENT_IP()%>"
                               styleId="digitalSignatureId" styleClass="form-control"/>

                </div>
            </div>
            <!-- Certificates Aliases Drop down -->
            <div class="form-group">
                <label class="col-md-5 col-xs-5 control-label">
                    <bean:message key="label.common.alias.label" /> </label>
                <div class="col-md-5 col-xs-5">
                    <select id="certificateAliases"
                            value="<%=CMSSignatureModel.getDIGITAL_SIGNATURE_ALIAS()%>"
                            class="form-control m-b">

                    </select>
                    <html:text property="cmsSignatureModel.DIGITAL_SIGNATURE_ALIAS"
                               styleId="selectedCertificateHiddenField" style="display:none"/>
                    <html:text property="cmsSignatureModel.DIGITAL_SIGNATURE_SERIAL_NUMBER"
                               styleId="selectedSerialNumHiddenField" style="display:none"/>

                </div>
                <div class="col-md-2 col-xs-2" style="padding: 0;">
                <span id="refreshCertificatesList" style="font-size: 16px;padding-top: 5px;cursor: pointer;"
                      class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
                </div>
            </div>
            <!-- Signature Page number in PDF -->
            <div class="form-group">
                <label for="pdfPageNum" class="col-md-5 col-xs-5 control-label"><bean:message key="label.common.pageNo.label" /></label>
                <div class="col-md-5 col-xs-5">
                    <html:text property="cmsSignatureModel.DIGITAL_SIGNATURE_PAGENO"
                               value="<%=String.valueOf(CMSSignatureModel.getDIGITAL_SIGNATURE_PAGENO())%>"
                               onkeypress="return allowNumbersOnly(event)"
                               onblur="checkValueRangeForPdfPageNumber(event);"
                               styleId="pdfPageNum" styleClass="form-control"/>

                </div>
            </div>
            <!-- Signature Position in PDF -->
            <div class="form-group">
                <label class="col-md-5 col-xs-5 control-label"><bean:message key="label.common.pos.label" /></label>
                <div class="col-md-5 col-xs-5">

                    <html:select size="1" value="<%=CMSSignatureModel.getDIGITAL_SIGNATURE_POSITION()%>"
                                 property="cmsSignatureModel.DIGITAL_SIGNATURE_POSITION" styleClass="form-control">
                        <html:optionsCollection property="positionMap" value="key" label="value"/>
                    </html:select>

                </div>
            </div>
            <!-- Signature Alignment in PDF -->
            <div class="form-group">
                <label class="col-md-5 col-xs-5 control-label"><bean:message key="label.common.align.label" /></label>
                <div class="col-md-5 col-xs-5">
                    <html:select size="1" value="<%=CMSSignatureModel.getDIGITAL_SIGNATURE_ALIGNMENT()%>"
                                 property="cmsSignatureModel.DIGITAL_SIGNATURE_ALIGNMENT" styleClass="form-control">
                        <html:optionsCollection property="alignementMap" value="key" label="value"/>
                    </html:select>
                </div>
            </div>
            <!-- Signature image in PDF -->
            <div class="form-group">
                <label class="col-md-5 col-xs-5 control-label"><bean:message key="label.common.image.label" /></label>
                <div class="col-md-5 col-xs-5">

                    <div class="avatar-upload">
                        <div class="avatar-edit">
                            <html:file property="uploadImage" size="50" styleId="userImage" name="userImage"
                                       value="CMSSignatureModel.DIGITAL_SIGNATURE_IMAGE" styleClass="form-control"
                                       accept=".png , .jpg , .jpeg , .bmp , .tif , .tiff , .gif"

                            />
                            <label for="userImage">Image</label>
                        </div>
                        <div class="avatar-preview">
                            <div id="imagePreview" style="background-image: url('');">


                            </div>
                        </div>

                    </div>
                        <%--<html:file accept=".png , .jpg , .jpeg , .bmp , .tif , .tiff , .gif" property="uploadImage" size="50" />--%>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-6 col-xs-6">

                    <html:submit styleClass="btn btn-primary center-block" styleId="submitHelp"
                                 onclick="DoSubmit()"><bean:message key="label.common.button.submit"/></html:submit>

                </div>

            </div>


        </div>

    </div>

</html:form>
<script>


    // $(document).ready(function () {
    var pluginPort = '<%=digitalSignaturePDFPluginPort%>';
    var clientIp = '<%=CMSSignatureModel.getDIGITAL_SIGNATURE_CLIENT_IP()%>';
    var pluginConnectionDone = false;
    //to check if the saved certificate in profile , is found NOW at the user personal store in client machine ( not un installed or different client machine)
    var foundSavedCertificateInStore = false;
    //to detect if error happened during getting aliases list from certificate store using certificate service in signaturePlug-in
    var errorHappenedToGetAliases = false;
    var aliasSavedValue = '<%=CMSSignatureModel.getDIGITAL_SIGNATURE_ALIAS()%>';
    var imagePath = '<%=CMSSignatureModel.getDIGITAL_SIGNATURE_IMAGE()%>'

    var context = '<%=request.getContextPath()%>';

    var firstProfileOpen = true;

    // ******************** image Js *************************


    // on load function
    $(document).ready(function () {
        // Handler for .ready() called.
        <%--var imagePath = '<s:property value="commonBean.map['DIGITAL_SIGNATURE_IMAGE']"/>'--%>

        console.log("Image path : " + imagePath + "   " + clientIp + "   " + pluginPort)
        console.log("Context : " + context);


        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {

                    // ----------- call when create Service in cms

                    // checkValidateImage(input.files[0], e);
                    // will removed
                    var img = $('#imagePreview');
                    img.css('background-image', 'url(' + e.target.result + ')');
                    img.hide();
                    img.fadeIn(650);

                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        // on change input File Choose
        $("#userImage").change(function () {
            readURL(this);
        });


        function checkValidateImage(imageFile, e) {
            // ajax request
            var data = new FormData();
            data.append("image", imageFile);


            // ajax save to database
            $.ajax({
                type: 'POST',
                enctype: 'multipart/form-data',
                url: context + "/rest/import/validateImage",
                data: data,
                processData: false, //prevent jQuery from automatically transforming the data into a query string
                contentType: false,
                cache: false,
                timeout: 600000,

                success: function (data) {
                    var img = $('#imagePreview');
                    img.css('background-image', 'url(' + e.target.result + ')');
                    img.hide();
                    img.fadeIn(650);
                },
                error: function (data, textStatus) {
                    alert(data.responseText);
                }
            });

        }


    });


    // **************************************************************

    // validate number Only
    function allowNumbersOnly(e) {
        var charCode = (e.which) ? e.which : e.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            e.preventDefault();
        }
    }

    //Limit pdf page number equal or greater than 1
    function checkValueRangeForPdfPageNumber() {
        var numVal = document.getElementById('pdfPageNum').value;
        if (numVal < 1 && numVal !== "") {
            document.getElementById('pdfPageNum').value = 1;
        }
    }

    function getImageRequest() {
        // $('#imagePreview').css('background-image', 'url(' + "http://" + clientIp + ":" + pluginPort + "/image/getImage?filePath=" + imagePath + ')');

        console.log(clientIp + "  " + pluginPort + "    " + imagePath + "   ")
        // ajax Request
        $.ajax({
            url: "http://" + clientIp + ":" + pluginPort + "/image/getImage?filePath=" + imagePath,
            type: 'GET',
            success: function (res) {
                console.log(res);
                // $('#imagePreview').css('background-image', 'url(' + "http://" + clientIp + ":" + pluginPort + "/image/getImage?filePath=" + imagePath + ')');

                // var img = $('#imagePreview');
                // img.css('background-image', 'url(' + res.target.result + ')');
                // img.hide();
                // img.fadeIn(650);

                alert(res)
            },
            error: function (xhr, status, error) {

                console.log(error);
            }
        });
    }


    // check Digital signature plugin works Or Not
    function checkPluginConnection() {

        console.log("Done Check ")
        console.log(pluginPort)
        console.log(clientIp)

        var pluginUrl = 'http://' + clientIp + ':' + pluginPort + '/digital-signature/check-connection';
        var stuff;
        $.ajax({
            type: 'GET',
            url: pluginUrl,
            data: stuff,
            success: function (data) {
                console.log("Success " + stuff)
                pluginConnectionDone = true;
                // get init Image When Load if plugin on

                console.log("Before ya man ggggg " + imagePath)
                // check if image path != null
                if (imagePath) {
                    getImageRequest();
                }


                // when load call method from plugin to get file from path
                // get image by Ajax
                // getImageRequest();
            },
            error: function (xhr, status, error) {
                // check status && error
                console.log("Error " + stuff)
                // edit style and display Error Message
                document.getElementById("pluginDown").style.display = "block";
                // set var false
                pluginConnectionDone = false;

            },
            // dataType: 'text'
        });


    }


    var personalCertificateStore = [];

    function getAliasesService() {
        var digitalSignaturePDFPluginIP = document.getElementById("digitalSignatureId").value;
        // get Aliases from Plug-in service
        jQuery.ajax({
            url: "http://" + digitalSignaturePDFPluginIP + ":" + pluginPort + "/certificate/get-keystore-alias-and-serial",
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            type: "GET",
            dataType: "json",
            data: {},
            cache: false,
            success: function (result) {
                if (result.succeeded) {
                    console.log("Success " + result)

                    personalCertificateStore = result.resultObject.KeyStores;
                    console.log(personalCertificateStore)

                    document.getElementById("pluginDown").style.display = "none";
                    document.getElementById("certNotExist").style.display = "none";
                    errorHappenedToGetAliases = false;
                }
                else {
                    console.log("Error " + result)

                    errorHappenedToGetAliases = true;
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error " + result)

                errorHappenedToGetAliases = true;
            },
            async: false
        });
    }

    function connectToPluginAndGetAliases() {
        //connect to signature plug-in get aliases service
        getAliasesService();

        console.log(errorHappenedToGetAliases)
        //if error happened in Service Response: View Error Message and Add Profile previously saved Certificate in dropdown Only if  it is still exist in user personal store and if first profile open time
        if (errorHappenedToGetAliases) {
            //view error message
            document.getElementById("pluginDown").style.display = "block";
            //reset dropdown of aliases
            document.getElementById("certificateAliases").innerHTML = "";
        }
        else {
            //fill personalCertificateStore ArrayList in UI dropdown and include profile saved value as first selected item(if still installed in personal store in client machine "not un installed or not different client machine")
            foundSavedCertificateInStore = false;
            var certificatesDropdown = document.getElementById("certificateAliases");
            $('#certificateAliases').empty();
            var choose = document.createElement("option");
            choose.text = " ";
            choose.value = " ";
            choose.selected = "selected";
            certificatesDropdown.add(choose);
            var optionElementId;
            var certificateOpt;
            for (optionElementId = 0; optionElementId < personalCertificateStore.length; ++optionElementId) {
                certificateOpt = personalCertificateStore[optionElementId].Alias;
                var option = document.createElement("option");
                option.text = certificateOpt;
                option.value = optionElementId;
                if (certificateOpt === aliasSavedValue) {
                    option.selected = "selected";
                    foundSavedCertificateInStore = true;
                }
                certificatesDropdown.add(option);
            }
            //if profile certificate doesn't exist in store now  (un installed) (or different client machine) ,show error message
            if (!foundSavedCertificateInStore && (typeof aliasSavedValue != 'undefined' && aliasSavedValue && aliasSavedValue.length !== 0 && aliasSavedValue !== "" && /[^\s]/.test(aliasSavedValue) && !/^\s*$/.test(aliasSavedValue) && aliasSavedValue.replace(/\s/g, "") !== "" && aliasSavedValue !== " ")) {
                document.getElementById("certNotExist").style.display = "block";
            }
        }
    }

    //Refresh Button of getting certificate Aliases List dropdown in profile
    $("#refreshCertificatesList").click(function () {
        //call signaturePlugin to request new certificate Aliases List and fill in dropdown
        console.log("get All aliases")
        connectToPluginAndGetAliases();
    });

    // first Time
    firstProfileOpenTime();
    // check connection Plugin poort
    checkPluginConnection();

    //if profile first opened time and if there is already a saved profile value , view the value in the dropdown
    function firstProfileOpenTime() {
        console.log("First Time ");
        console.log("Alias : " + aliasSavedValue + "   " + firstProfileOpen);
        if (firstProfileOpen && !(typeof aliasSavedValue == 'undefined' || !aliasSavedValue || aliasSavedValue.length === 0 || aliasSavedValue === "" || !/[^\s]/.test(aliasSavedValue) || /^\s*$/.test(aliasSavedValue) || aliasSavedValue.replace(/\s/g, "") === "")) {
            var certsDropdown = document.getElementById("certificateAliases");
            var choose = document.createElement("option");
            choose.text = aliasSavedValue;
            choose.value = aliasSavedValue
            choose.selected = "selected";
            certsDropdown.add(choose);
            firstProfileOpen = false;
        }

    }

    // on save Button Click
    function DoSubmit() {

        //1- save the selected alias value from drop down
        var aliasSelected = $("#certificateAliases option:selected").text();
        document.getElementById("selectedCertificateHiddenField").value = aliasSelected;
        //save the corresponding serial number of the selected alias (search on its serial number in the CertificateList)
        var serial;
        if (personalCertificateStore && personalCertificateStore.length > 0) {
            for (var i = 0; i < personalCertificateStore.length; i++) {
                if (personalCertificateStore[i].Alias == aliasSelected) {
                    serial = personalCertificateStore[i].SerialNumber;
                    break;
                }
            }
        }
        else
            serial = "<%=CMSSignatureModel.getDIGITAL_SIGNATURE_SERIAL_NUMBER()%>";

        if (aliasSelected == " ")
            serial = "";
        document.getElementById("selectedSerialNumHiddenField").value = serial;
        //END Certificate Tab Values Save


    }


</script>

</body>
</html>
