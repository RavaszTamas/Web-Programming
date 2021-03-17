package DB;

import Domain.Profile;
import Domain.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DBManager {

    private static Connection connection;

    public static void connect(){
        loadDriver();
        if(connection == null){
            String url = "jdbc:mysql://localhost/web_lab8";
            try{
                connection = DriverManager.getConnection( url, "ubbstudent", "forclasspurposes" );
            } catch (SQLException throwable) {
                throwable.printStackTrace();
            }
        }
    }

    public static void disconnect() {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        connection = null;
    }

    private static void loadDriver() {
        try {
            Class.forName( "com.mysql.jdbc.Driver" );
        } catch (ClassNotFoundException e) {
            System.err.println("Can’t load driver");
        }
    }

    public static Connection getConnection() {
        if(connection == null)
            connect();
        return connection;
    }

    public static User addNewUser(String username, String password) {
        String sql = "INSERT INTO `user`(username, password) VALUES ('" + username + "','"  + password + "');";
        System.out.println( sql );
        // Execute the query
        User user = null;
        try {
            PreparedStatement stmt = DBManager.getConnection().prepareStatement(sql);
            stmt.execute();

            String sqlForID = "SELECT * FROM `user` where `username` = '" + username +"' AND `password` = '" + password + "';";
            PreparedStatement stmtForID = DBManager.getConnection().prepareStatement(sqlForID);
            ResultSet resultsForID = stmtForID.executeQuery();

            while(resultsForID.next()) {
                user = new User(resultsForID.getInt("user_id"),resultsForID.getString("username"),resultsForID.getString("password"));
            }

            if(user != null){
                String sqlForProfile = "INSERT INTO `profile` (`user_id`) VALUES (" + user.getId()+")";
                PreparedStatement statement = DBManager.getConnection().prepareStatement(sqlForProfile);
                statement.execute();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return user;
    }

    public static Profile getProfile(String userID){
        String sqlProfile = "SELECT * FROM `profile` where `user_id` = '" + userID +"'";
        Profile profile = null;
        try{
        PreparedStatement stmt = DBManager.getConnection().prepareStatement(sqlProfile);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                profile = new Profile(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email_address"),
                        rs.getString("picture"),
                        rs.getInt("age"),
                        rs.getString("home_town")
                );
            }
        }
        catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return profile;
    }


    public static List<Profile> getAllProfilesWithQuery(String sqlQuery){
        List<Profile> profiles  = new ArrayList<>();
        PreparedStatement stmt = null;
        try {
            stmt = DBManager.getConnection().prepareStatement(sqlQuery);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                profiles.add(new Profile(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email_address"),
                        rs.getString("picture"),
                        rs.getInt("age"),
                        rs.getString("home_town")
                ));
            }
            rs.close();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return profiles;

    }

}
