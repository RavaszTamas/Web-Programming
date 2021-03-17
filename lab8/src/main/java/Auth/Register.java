package Auth;

import DB.DBManager;
import Domain.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterServlet")
public class Register extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username").strip();
        String password = req.getParameter("password").strip();
        String repeatPassword = req.getParameter("repeatPassword").strip();
        RequestDispatcher rd = null;

        if(req.getSession().getAttribute("user") != null){
            resp.sendRedirect("/components/mainPage.jsp");
            return;
        }


        //Validation
        String errorString = valiadteParametersForLogin(username,password,repeatPassword);
        String encryptedPassword = AuthManager.encrypt(password);

        if(errorString.length() != 0){
            req.setAttribute("errorString",errorString);
            rd = req.getRequestDispatcher("/components/registrationFailed.jsp");
        }
        else {

            // Save the user
            User user =DBManager.addNewUser(username, encryptedPassword);
            if(user == null){
                req.setAttribute("errorString","Username may be duplicate, please try again with a different one!");
                rd = req.getRequestDispatcher("/components/registrationFailed.jsp");
            }
            else{
            // Login the user
            Login.loginTheUser(req.getSession(),resp, user);
//
//        // Redirect the user to /
            rd = req.getRequestDispatcher("/components/mainPage.jsp");
            }

        }
        rd.forward(req,resp);
    }

    private String valiadteParametersForLogin(String username, String password, String passwordRepeat){
        StringBuilder errorString = new StringBuilder("");
        if(username == null){
            errorString.append("Invalid username, must have a value!\n");
        }
        else if(username.length() == 0){
            errorString.append("Invalid username, must not be empty!\n");
        }
        else if(username.matches(".*\\s.*")){
            errorString.append("Invalid username, must not have any whitespaces!\n");
        }
        if(password == null){
            errorString.append("Invalid password, must have a value!\n");
        }
        else if(password.length() == 0){
            errorString.append("Invalid password, must not be empty!\n");
        }
        else if(password.matches(".*\\s.*")){
            errorString.append("No whitespaces in password!\n");
        }
        if(passwordRepeat == null){
            errorString.append("Invalid password repeat, must have a value!\n");
        }
        else if(passwordRepeat.length() == 0){
            errorString.append("Invalid password repeat, must not be empty!\n");
        }
        else if(passwordRepeat.matches(".*\\s.*")){
            errorString.append("No whitespaces in repeated password!\n");
        }

        if(password != null && passwordRepeat != null && password.length() != 0 && passwordRepeat.length() != 0){
            if(!password.equals(passwordRepeat)){
                errorString.append("Invalid password, password and repeated password must be the same!\n");
            }
        }
        return errorString.toString();

    }

}
