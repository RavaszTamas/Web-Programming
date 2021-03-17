package Auth;

import DB.DBManager;
import Domain.User;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthManager {
    public static User isValidUserLogin(String userName, String password) {

        try {
            String sql = "SELECT * FROM `user` where `username` = '" + userName +"' AND `password` = '" + password + "';";
            PreparedStatement stmt = DBManager.getConnection().prepareStatement(sql);
            ResultSet results = stmt.executeQuery();

            while(results.next()) {
                return new User(results.getInt("user_id"),results.getString("username"),results.getString("password"));
            }
            return null;

        } catch(SQLException e) {
            e.printStackTrace();
        }

        return null;

    }

    public static User getUserByUsername(String username) {
        try {
            String sql = "SELECT * FROM `user` where `username` = '" + username + "'";
            PreparedStatement stmt = DBManager.getConnection().prepareStatement(sql);
            ResultSet results = stmt.executeQuery();

            while(results.next()) {
                return new User(results.getInt("user_id"),results.getString("username"),results.getString("password"));
            }
            return null;

        } catch(SQLException e) {
            e.printStackTrace();
        }

        return null;

    }
    public static User findUserBySessionToken(String token){

        return getUserByUsername(token);
    }

    public static String encrypt(String passwordToHash) {
        String generatedPassword = null;
        try {
            // Create MessageDigest instance for MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
            //Add password bytes to digest
            md.update(passwordToHash.getBytes());
            //Get the hash's bytes
            byte[] bytes = md.digest();
            //This bytes[] has bytes in decimal format;
            //Convert it to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for(int i=0; i< bytes.length ;i++)
            {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            //Get complete hashed password in hex format
            generatedPassword = sb.toString();
        }
        catch (NoSuchAlgorithmException ex)
        {
            ex.printStackTrace();
        }
        return generatedPassword;
    }



}
