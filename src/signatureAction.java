import Dao.Database;
import model.CMSSignatureModel;
import org.apache.struts.action.*;
import org.apache.struts.actions.MappingDispatchAction;
import org.apache.struts.upload.FormFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;


public class signatureAction extends MappingDispatchAction {

    public ActionForward selectSettings(ActionMapping mapping, ActionForm form,
                                        HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int userId = 2;

        ResultSet resultSet = Database.selectByUserId(userId);
        CMSSignatureModel CMSSignatureModel = new CMSSignatureModel();
        if (resultSet.next()) {

            // set all variables
            CMSSignatureModel.setDIGITAL_SIGNATURE_ALIAS(resultSet.getString("DIGITAL_SIGNATURE_ALIAS"));
            CMSSignatureModel.setDIGITAL_SIGNATURE_ALIGNMENT(resultSet.getString("DIGITAL_SIGNATURE_ALIGNMENT"));
            CMSSignatureModel.setDIGITAL_SIGNATURE_CLIENT_IP(resultSet.getString("DIGITAL_SIGNATURE_CLIENT_IP"));
            CMSSignatureModel.setDIGITAL_SIGNATURE_IMAGE(resultSet.getString("DIGITAL_SIGNATURE_IMAGE"));
            CMSSignatureModel.setDIGITAL_SIGNATURE_PAGENO(resultSet.getInt("DIGITAL_SIGNATURE_PAGENO"));
            CMSSignatureModel.setDIGITAL_SIGNATURE_SERIAL_NUMBER(resultSet.getString("DIGITAL_SIGNATURE_SERIAL_NUM"));
            CMSSignatureModel.setDIGITAL_SIGNATURE_POSITION(resultSet.getString("DIGITAL_SIGNATURE_POSITION"));
            CMSSignatureModel.setID(resultSet.getInt("Id"));
            CMSSignatureModel.setUSER_ID(resultSet.getInt("USER_ID"));
        } else {
            CMSSignatureModel.setDIGITAL_SIGNATURE_CLIENT_IP("localhost");

        }
        request.setAttribute("CMSSignatureModel", CMSSignatureModel);
        request.setAttribute("digitalSignaturePDFPluginPort", "8085");
//        request.setAttribute("positionMap", positionMap);
//        request.setAttribute("alignementMap", alignementMap);
//
        System.out.println("selectSettings");
        return mapping.findForward("success");
    }


    public ActionForward saveSettings(ActionMapping mapping, ActionForm form,
                                      HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        signatureForm signatureForm = (signatureForm) form;

        CMSSignatureModel cmsSignatureModel = signatureForm.getCmsSignatureModel();

        FormFile file = signatureForm.getUploadImage();



        //Get the servers upload directory real path name
        String filePath =
                getServlet().getServletContext().getRealPath("/") + "upload";

        //create the upload folder if not exists
        File folder = new File(filePath);
        if (!folder.exists()) {
            folder.mkdir();
        }

        String fileName = file.getFileName();

        if (!("").equals(fileName)) {

            System.out.println("Server path:" + filePath);
            File newFile = new File(filePath, fileName);

            if (!newFile.exists()) {
                FileOutputStream fos = new FileOutputStream(newFile);
                fos.write(file.getFileData());
                fos.flush();
                fos.close();
            }


            String savedPath = convertPath(newFile.getAbsolutePath());

//            request.setAttribute("uploadedFilePath",savedPath);

            cmsSignatureModel.setDIGITAL_SIGNATURE_IMAGE(savedPath);
        }

        // save to database
        ResultSet resultSet = Database.selectByUserId(cmsSignatureModel.getUSER_ID());
        // if exists update
        if (resultSet.next()) {

            // update database
            Database.updateIntoDatabase(cmsSignatureModel);

        }
        // else create New
        else {
            Database.saveIntoDatabase(cmsSignatureModel);
        }

        return mapping.findForward("success");


    }

    private String convertPath(String str) {
        StringBuilder stringBuilder = new StringBuilder(str);
        for (int i = 0; i < stringBuilder.length(); i++) {

            if (stringBuilder.charAt(i) == '\\') {
                stringBuilder.replace(i, i + 1, "/");

            }
        }

        return stringBuilder.toString();


    }

}