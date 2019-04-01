package Dao;

import model.CMSSignatureModel;

import java.sql.*;

public class Database {

    private static Database instance;
    private Connection connection;
    private String url = "jdbc:mysql://localhost:3306/signature";
    private String username = "root";
    private String password = "root";

    private Database() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            this.connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException ex) {
            System.out.println("Database Connection Creation Failed : " + ex.getMessage());
        }
    }

    public Connection getConnection() {
        return connection;
    }

    public static Database getInstance() throws SQLException {
        if (instance == null) {
            instance = new Database();
        } else if (instance.getConnection().isClosed()) {
            instance = new Database();
        }

        return instance;
    }


    // select by userId
    public static ResultSet selectByUserId(int userId) {
        Connection connection = null;
        ResultSet resultSet = null;
        try {
            connection = getInstance().getConnection();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement("select * from cms_signature where USER_ID =?");

            preparedStatement.setInt(1, userId);

            resultSet = preparedStatement.executeQuery();


        } catch (SQLException e) {
            e.printStackTrace();
        }


        return resultSet;

    }

    public static void saveIntoDatabase(CMSSignatureModel CMSSignatureModel) {

        Connection connection = null;
        try {
            connection = getInstance().getConnection();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            PreparedStatement preparedStatement = connection.prepareStatement
                    ("insert into cms_signature (DIGITAL_SIGNATURE_POSITION," +
                            " DIGITAL_SIGNATURE_SERIAL_NUM," +
                            "DIGITAL_SIGNATURE_ALIAS," +
                            " DIGITAL_SIGNATURE_CLIENT_IP," +
                            " DIGITAL_SIGNATURE_ALIGNMENT," +
                            " DIGITAL_SIGNATURE_PAGENO, " +
                            "DIGITAL_SIGNATURE_IMAGE," +
                            " USER_ID )  values (?,?,?,?,?,?,?,?)");
            preparedStatement.setString(1, CMSSignatureModel.getDIGITAL_SIGNATURE_POSITION());
            preparedStatement.setString(2, CMSSignatureModel.getDIGITAL_SIGNATURE_SERIAL_NUMBER());
            preparedStatement.setString(3, CMSSignatureModel.getDIGITAL_SIGNATURE_ALIAS());
            preparedStatement.setString(4, CMSSignatureModel.getDIGITAL_SIGNATURE_CLIENT_IP());
            preparedStatement.setString(5, CMSSignatureModel.getDIGITAL_SIGNATURE_ALIGNMENT());
            preparedStatement.setInt(6, CMSSignatureModel.getDIGITAL_SIGNATURE_PAGENO());
            preparedStatement.setString(7, CMSSignatureModel.getDIGITAL_SIGNATURE_IMAGE());
            preparedStatement.setInt(8, CMSSignatureModel.getUSER_ID());

            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }


    public static void updateIntoDatabase(CMSSignatureModel CMSSignatureModel) {

        Connection connection = null;
        try {
            connection = getInstance().getConnection();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            PreparedStatement preparedStatement = connection.prepareStatement
                    ("update  cms_signature set DIGITAL_SIGNATURE_POSITION =? , " +
                            " DIGITAL_SIGNATURE_SERIAL_NUM =?," +
                            "DIGITAL_SIGNATURE_ALIAS =?," +
                            " DIGITAL_SIGNATURE_CLIENT_IP =?," +
                            " DIGITAL_SIGNATURE_ALIGNMENT =?," +
                            " DIGITAL_SIGNATURE_PAGENO =?, " +
                            "DIGITAL_SIGNATURE_IMAGE =? where" +
                            " USER_ID =? ");
            preparedStatement.setString(1, CMSSignatureModel.getDIGITAL_SIGNATURE_POSITION());
            preparedStatement.setString(2, CMSSignatureModel.getDIGITAL_SIGNATURE_SERIAL_NUMBER());
            preparedStatement.setString(3, CMSSignatureModel.getDIGITAL_SIGNATURE_ALIAS());
            preparedStatement.setString(4, CMSSignatureModel.getDIGITAL_SIGNATURE_CLIENT_IP());
            preparedStatement.setString(5, CMSSignatureModel.getDIGITAL_SIGNATURE_ALIGNMENT());
            preparedStatement.setInt(6, CMSSignatureModel.getDIGITAL_SIGNATURE_PAGENO());
            preparedStatement.setString(7, CMSSignatureModel.getDIGITAL_SIGNATURE_IMAGE());
            preparedStatement.setInt(8, CMSSignatureModel.getUSER_ID());

            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }


}
