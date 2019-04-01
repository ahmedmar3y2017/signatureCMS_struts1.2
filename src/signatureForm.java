import model.CMSSignatureModel;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.upload.FormFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;


public class signatureForm extends ActionForm {

    CMSSignatureModel cmsSignatureModel;
    // set buttom and hight
    Map positionMap;
    // right , left
    Map alignementMap;

    FormFile uploadImage;

    private static final String IPv4_REGEX =
            "^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$";

    private static final Pattern IPv4_PATTERN = Pattern.compile(IPv4_REGEX);

    @Override
    public ActionErrors validate(ActionMapping mapping,
                                 HttpServletRequest request) {

        ActionErrors errors = new ActionErrors();


        // check Client Ip
        if (cmsSignatureModel.getDIGITAL_SIGNATURE_CLIENT_IP().isEmpty()) {
            // error
            errors.add("common.clientIp.err",
                    new ActionMessage("error.common.clientIp.valid"));
        }
        // if not empty check format Ip
        else {

            if (!cmsSignatureModel.getDIGITAL_SIGNATURE_CLIENT_IP().equalsIgnoreCase("localhost")) {
                // check Valid format Ip
                boolean validInet4Address = isValidInet4Address(cmsSignatureModel.getDIGITAL_SIGNATURE_CLIENT_IP());
                if (!validInet4Address) {
                    // error
                    errors.add("common.clientIpFormat.err",
                            new ActionMessage("error.common.clientIpFormat.valid"));
                }
            }

        }
        // check alias
        if (cmsSignatureModel.getDIGITAL_SIGNATURE_ALIAS().isEmpty()) {
            // error
            errors.add("common.alias.err",
                    new ActionMessage("error.common.alias.valid"));
        }
        // if page NUmber <= 0
        if (cmsSignatureModel.getDIGITAL_SIGNATURE_PAGENO() <= 0) {
            // error
            errors.add("common.pageNo.err",
                    new ActionMessage("error.common.pageNo.valid"));
        }


        // ---------- image validation  ----------
        // if image empty
        if (uploadImage.getFileSize() == 0) {
            errors.add("common.file.err",
                    new ActionMessage("error.common.file.required"));
            return errors;
        }
        // if there size
        else {
            //only allow image to upload
            if (!"image/png".equalsIgnoreCase(uploadImage.getContentType())
                    && !"image/jpg".equalsIgnoreCase(uploadImage.getContentType())
                    && !"image/jpeg".equalsIgnoreCase(uploadImage.getContentType())
                    && !"image/bmp".equalsIgnoreCase(uploadImage.getContentType())
                    && !"image/tif".equalsIgnoreCase(uploadImage.getContentType())
                    && !"image/tiff".equalsIgnoreCase(uploadImage.getContentType())
                    && !"image/gif".equalsIgnoreCase(uploadImage.getContentType())

                    ) {
                errors.add("common.file.err.image",
                        new ActionMessage("error.common.file.image.only"));
                return errors;
            }

            // check Size <= .5 mb = 512 kb
            if (uploadImage.getFileSize() > (1024 * 1024) / 2) {

                errors.add("common.fileSize.err",
                        new ActionMessage("error.common.fileSize.valid"));
                return errors;
            }
            // check dimensions (width , height)
            Integer[] imageDimension = new Integer[0];
            try {
                imageDimension = getImageDimensions(uploadImage.getInputStream());
            } catch (IOException e) {
                e.printStackTrace();
            }
            if (imageDimension[0] > 280 || imageDimension[1] > 250) {
                errors.add("common.dimension.err",
                        new ActionMessage("error.common.dimension.valid"));
                return errors;
            }
        }




        return errors;
    }

    @Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
        // reset properties
//        if (cmsSignatureModel == null)
        cmsSignatureModel = new CMSSignatureModel();
    }

    public static boolean isValidInet4Address(String ip) {

        if (ip == null) {
            return false;
        }

        if (!IPv4_PATTERN.matcher(ip).matches())
            return false;

        String[] parts = ip.split("\\.");

        // verify that each of the four subgroups of IPv4 address is legal
        try {
            for (String segment : parts) {
                // x.0.x.x is accepted but x.01.x.x is not
                if (Integer.parseInt(segment) > 255 ||
                        (segment.length() > 1 && segment.startsWith("0"))) {
                    return false;
                }
            }
        } catch (NumberFormatException e) {
            return false;
        }

        return true;
    }
    public Integer[] getImageDimensions(InputStream inputStream) throws IOException {
        BufferedImage bimg = ImageIO.read(inputStream);
        int width = bimg.getWidth();
        int height = bimg.getHeight();
        return new Integer[]{width, height};
    }

    // setter , getter
    public Map getPositionMap() {
        positionMap = new HashMap();
        positionMap.put("1", "Buttom");
        positionMap.put("2", "Hight");

        return positionMap;
    }

    public void setPositionMap(Map positionMap) {
        this.positionMap = positionMap;
    }

    public Map getAlignementMap() {
        alignementMap = new HashMap();

        alignementMap.put("1", "Right");
        alignementMap.put("2", "Left");
        return alignementMap;
    }

    public void setAlignementMap(Map alignementMap) {
        this.alignementMap = alignementMap;
    }

    public FormFile getUploadImage() {
        return uploadImage;
    }

    public void setUploadImage(FormFile uploadImage) {
        this.uploadImage = uploadImage;
    }

    public CMSSignatureModel getCmsSignatureModel() {
        return cmsSignatureModel;
    }

    public void setCmsSignatureModel(CMSSignatureModel cmsSignatureModel) {
        this.cmsSignatureModel = cmsSignatureModel;
    }
}