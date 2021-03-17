package Auth;

import Controller.ProfileController;
import Domain.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;

@WebServlet(name = "LoginServlet")
public class Login extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String userName = req.getParameter("username");
        String password = req.getParameter("password");
        RequestDispatcher rd = null;

        if(req.getSession().getAttribute("user") != null){
            resp.sendRedirect("/components/mainPage.jsp");
            return;
        }

        String encryptedPassword = AuthManager.encrypt(password);

        User user = AuthManager.isValidUserLogin(userName,encryptedPassword);
        if(user != null){
            loginTheUser(req.getSession(),resp,user);

//            resp.sendRedirect("/index.jsp");
            rd = req.getRequestDispatcher("/components/mainPage.jsp");

        } else {
            rd = req.getRequestDispatcher("/components/loginFailed.jsp");
        }
        rd.forward(req,resp);
    }

    public static void loginTheUser(HttpSession session,HttpServletResponse resp, User user) {
        String sessionToken = user.getUsername();
        Cookie sessionCookie = new Cookie("session",sessionToken);
        sessionCookie.setMaxAge(7200);
        resp.addCookie(sessionCookie);
        session.setAttribute("user",user);
    }
}
