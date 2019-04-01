package model;

import java.io.Serializable;

public class CMSSignatureModel implements Serializable {

    private int ID;
    private String DIGITAL_SIGNATURE_POSITION;
    private String DIGITAL_SIGNATURE_SERIAL_NUMBER;
    private String DIGITAL_SIGNATURE_ALIAS;
    private String DIGITAL_SIGNATURE_CLIENT_IP;
    private String DIGITAL_SIGNATURE_ALIGNMENT;
    private int DIGITAL_SIGNATURE_PAGENO;
    private String DIGITAL_SIGNATURE_IMAGE;

    private int USER_ID;

    public CMSSignatureModel() {
        super();
    }

    public CMSSignatureModel(String DIGITAL_SIGNATURE_POSITION, String DIGITAL_SIGNATURE_SERIAL_NUMBER,
                             String DIGITAL_SIGNATURE_ALIAS, String DIGITAL_SIGNATURE_CLIENT_IP,
                             String DIGITAL_SIGNATURE_ALIGNMENT, int DIGITAL_SIGNATURE_PAGENO,
                             String DIGITAL_SIGNATURE_IMAGE, int USER_ID) {
        super();
        this.DIGITAL_SIGNATURE_POSITION = DIGITAL_SIGNATURE_POSITION;
        this.DIGITAL_SIGNATURE_SERIAL_NUMBER = DIGITAL_SIGNATURE_SERIAL_NUMBER;
        this.DIGITAL_SIGNATURE_ALIAS = DIGITAL_SIGNATURE_ALIAS;
        this.DIGITAL_SIGNATURE_CLIENT_IP = DIGITAL_SIGNATURE_CLIENT_IP;
        this.DIGITAL_SIGNATURE_ALIGNMENT = DIGITAL_SIGNATURE_ALIGNMENT;
        this.DIGITAL_SIGNATURE_PAGENO = DIGITAL_SIGNATURE_PAGENO;
        this.DIGITAL_SIGNATURE_IMAGE = DIGITAL_SIGNATURE_IMAGE;
        this.USER_ID = USER_ID;
    }

    public boolean equals(Object obj) {
        return super.equals(obj);
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public int getID() {
        return ID;
    }

    public void setDIGITAL_SIGNATURE_POSITION(String DIGITAL_SIGNATURE_POSITION) {
        this.DIGITAL_SIGNATURE_POSITION = DIGITAL_SIGNATURE_POSITION;
    }

    public String getDIGITAL_SIGNATURE_POSITION() {
        return DIGITAL_SIGNATURE_POSITION;
    }

    public void setDIGITAL_SIGNATURE_SERIAL_NUMBER(String DIGITAL_SIGNATURE_SERIAL_NUMBER) {
        this.DIGITAL_SIGNATURE_SERIAL_NUMBER = DIGITAL_SIGNATURE_SERIAL_NUMBER;
    }

    public String getDIGITAL_SIGNATURE_SERIAL_NUMBER() {
        return DIGITAL_SIGNATURE_SERIAL_NUMBER;
    }

    public void setDIGITAL_SIGNATURE_ALIAS(String DIGITAL_SIGNATURE_ALIAS) {
        this.DIGITAL_SIGNATURE_ALIAS = DIGITAL_SIGNATURE_ALIAS;
    }

    public String getDIGITAL_SIGNATURE_ALIAS() {
        return DIGITAL_SIGNATURE_ALIAS;
    }

    public void setDIGITAL_SIGNATURE_CLIENT_IP(String DIGITAL_SIGNATURE_CLIENT_IP) {
        this.DIGITAL_SIGNATURE_CLIENT_IP = DIGITAL_SIGNATURE_CLIENT_IP;
    }

    public String getDIGITAL_SIGNATURE_CLIENT_IP() {
        return DIGITAL_SIGNATURE_CLIENT_IP;
    }

    public void setDIGITAL_SIGNATURE_ALIGNMENT(String DIGITAL_SIGNATURE_ALIGNMENT) {
        this.DIGITAL_SIGNATURE_ALIGNMENT = DIGITAL_SIGNATURE_ALIGNMENT;
    }

    public String getDIGITAL_SIGNATURE_ALIGNMENT() {
        return DIGITAL_SIGNATURE_ALIGNMENT;
    }

    public void setDIGITAL_SIGNATURE_PAGENO(int DIGITAL_SIGNATURE_PAGENO) {
        this.DIGITAL_SIGNATURE_PAGENO = DIGITAL_SIGNATURE_PAGENO;
    }

    public int getDIGITAL_SIGNATURE_PAGENO() {
        return DIGITAL_SIGNATURE_PAGENO;
    }

    public void setDIGITAL_SIGNATURE_IMAGE(String DIGITAL_SIGNATURE_IMAGE) {
        this.DIGITAL_SIGNATURE_IMAGE = DIGITAL_SIGNATURE_IMAGE;
    }

    public String getDIGITAL_SIGNATURE_IMAGE() {
        return DIGITAL_SIGNATURE_IMAGE;
    }

    public void setUSER_ID(int USER_ID) {
        this.USER_ID = USER_ID;
    }

    public int getUSER_ID() {
        return USER_ID;
    }

    @Override
    public String toString() {
        return "CMSSignatureModel{" +
                "ID=" + ID +
                ", DIGITAL_SIGNATURE_POSITION='" + DIGITAL_SIGNATURE_POSITION + '\'' +
                ", DIGITAL_SIGNATURE_SERIAL_NUMBER='" + DIGITAL_SIGNATURE_SERIAL_NUMBER + '\'' +
                ", DIGITAL_SIGNATURE_ALIAS='" + DIGITAL_SIGNATURE_ALIAS + '\'' +
                ", DIGITAL_SIGNATURE_CLIENT_IP='" + DIGITAL_SIGNATURE_CLIENT_IP + '\'' +
                ", DIGITAL_SIGNATURE_ALIGNMENT='" + DIGITAL_SIGNATURE_ALIGNMENT + '\'' +
                ", DIGITAL_SIGNATURE_PAGENO=" + DIGITAL_SIGNATURE_PAGENO +
                ", DIGITAL_SIGNATURE_IMAGE='" + DIGITAL_SIGNATURE_IMAGE + '\'' +
                ", USER_ID=" + USER_ID +
                '}';
    }
}
