package Controller;

import Auth.AuthManager;
import DB.DBManager;
import Domain.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@MultipartConfig
public class UpdateProfile extends HttpServlet {

    private final String  SAVE_DIR = "img";

    private final String PROJECT_DIRECTORY = "C:\\Users\\tamas\\Documents\\UBB\\Web\\lab8\\src\\main\\webapp\\img" + File.separator;

    private boolean verifyEmail(String emailString){
        Pattern pattern = Pattern.compile("[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}");
        Matcher mat = pattern.matcher(emailString);
        return mat.matches();

    }

    private String validateInput(String age,String emailAddress,String homeTown,String name){
        StringBuilder errorMessage = new StringBuilder("");
        if(emailAddress != null && !emailAddress.equals("")) {
            if (!verifyEmail(emailAddress)) {
                errorMessage.append("Invalid email address. ");
            }
        }
        try{
            if(age != null && !age.equals("")) {
                int ageValue = Integer.parseInt(age);
                if (ageValue <= 13)
                    errorMessage.append("Invalid age, not old enough! ");
                else if(ageValue >= 99){
                    errorMessage.append("Invalid age, too old. ");
                }
            }
        }catch (NumberFormatException ex){
            errorMessage.append("Invalid age, is not an integer!. ");
        }

        return errorMessage.toString();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String age = req.getParameter( "ageInput" );
        String emailAddress = req.getParameter( "emailAddress" );
        String homeTown = req.getParameter( "homeTown" );
        String name = req.getParameter( "nameInput" );

        RequestDispatcher rd = null;

        Optional<User> userOptional = ProfileController.validateRequest(req);
        if(userOptional.isEmpty()){
            return;
        }
        User user = userOptional.get();

        String errorMessage = validateInput(age,emailAddress,homeTown,name);
        //errorcase
        if(errorMessage.length() > 0){
            resp.sendRedirect("/components/profileDetail.jsp?errorString="+errorMessage);
            return;
        }


        String fileName = null;
        String saveLocation = null;
        try {
            Part filePart = req.getPart("imageInput"); // Retrieves <input type="file" name="imageInput">
            if(filePart != null) {
                fileName = getSubmittedFileName(filePart);
                if(fileName != null && !fileName.equals("")) {// MSIE fix.
                    fileName = new File(fileName).getName();

                    String appPath = req.getServletContext().getRealPath("");
                    String savePath  = appPath + java.io.File.separator + SAVE_DIR;

                    File fileSaveDir = new File(savePath);
                    if (!fileSaveDir.exists()) {
                        fileSaveDir.mkdir();
                    }

                    saveLocation = savePath + java.io.File.separator + fileName;

                    filePart.write(saveLocation);

                    Path src = Paths.get(saveLocation);
                    Path dest = Paths.get(PROJECT_DIRECTORY+fileName);
                    Files.copy(src, dest, StandardCopyOption.REPLACE_EXISTING);

                    saveLocation = java.io.File.separator + SAVE_DIR + java.io.File.separator + fileName;
                }
            }
        }
        catch (IOException | ServletException ex){
            ex.printStackTrace();
            fileName = null;
        }
        String updateSql = "UPDATE `profile` SET ";

        List<String> fieldsToUpdate = new LinkedList<>();
        List<String> valuesToAdd = new LinkedList<>();

        if(name != null && !name.equals("")){
            fieldsToUpdate.add("name");
            valuesToAdd.add(" name = ? ");
        }
        if(emailAddress != null  && !emailAddress.equals("")) {
            fieldsToUpdate.add("email_address");
            valuesToAdd.add(" email_address = ? ");
        }
        if(age != null && !age.equals("")){
            fieldsToUpdate.add("age");
            valuesToAdd.add(" age = ? ");
        }
        if(homeTown != null && !homeTown.equals("") ){
            fieldsToUpdate.add("home_town");
            valuesToAdd.add(" home_town = ? ");
        }
        if(saveLocation != null){
            fieldsToUpdate.add("picture");
            valuesToAdd.add(" picture = ? ");
        }
        if(fieldsToUpdate.size() == 0){
            rd = req.getRequestDispatcher("/components/profileDetail.jsp");

            rd.forward(req,resp);
            return;
        }

//        String resultToUpdate = String.join(",",fieldsToUpdate);
//        resultToUpdate = "(" + resultToUpdate + ")";
//        String valuesToEnter = String.join(",",valuesToAdd);
//        valuesToEnter = "(" + valuesToEnter + ")";
        updateSql += String.join(",",valuesToAdd) + "where user_id = ?";


        System.out.println(updateSql);

        try {
            PreparedStatement preparedStatement = DBManager.getConnection().prepareStatement(updateSql);

            for(int i = 0; i < fieldsToUpdate.size(); i++){
                switch (fieldsToUpdate.get(i)){

                    case "name":
                        preparedStatement.setString(i+1,name);
                        break;
                    case "email_address":
                        preparedStatement.setString(i+1,emailAddress);
                        break;
                    case "age":
                        preparedStatement.setInt(i+1,Integer.parseInt(age));
                        break;
                    case "home_town":
                        preparedStatement.setString(i+1,homeTown);
                        break;
                    case "picture":
                        preparedStatement.setString(i+1,saveLocation);
                        break;
                    default:
                        throw new IllegalArgumentException("Something is not right");

                }
            }
            preparedStatement.setInt(fieldsToUpdate.size()+1,user.getId());
            preparedStatement.executeUpdate();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

//        req.setAttribute("successMessage","Data successfully updated!");
//        getServletContext().getRequestDispatcher("/components/profileDetail.jsp").forward(
//                req, resp);
        resp.sendRedirect("/components/profileDetail.jsp?successMessage="+"Data successfully updated!");

    }

    private static String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
    }

}
