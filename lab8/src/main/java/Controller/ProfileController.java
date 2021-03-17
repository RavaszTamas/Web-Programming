package Controller;

import Auth.AuthManager;
import DB.DBManager;
import Domain.Profile;
import Domain.User;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        if(action == null)
            return;
        if(validateRequest(request).isEmpty()){
            return;
        }
        String mapAsString = request.getParameterMap().keySet().stream()
            .map(key -> key + "=" + Arrays.toString(request.getParameterMap().get(key)))
            .collect(Collectors.joining(", ", "{", "}"));
        System.out.println(mapAsString);
        if(action.equals("getAll")){
            getAllWithQuery(request,response);
        }
        else if(action.equals("getProfile")){
            getProfile(request,response);
        }

    }

    public static Optional<User> validateRequest(HttpServletRequest request){
        Optional<Cookie>  sessionOptional = Arrays.stream(request.getCookies()).filter(c->c.getName().equals("session")).findAny();

        if(sessionOptional.isEmpty())return Optional.empty();
        Cookie sessionCookie =sessionOptional.get();
        return Optional.ofNullable(AuthManager.findUserBySessionToken(sessionCookie.getValue()));
    }

    private void getProfile(HttpServletRequest request, HttpServletResponse response) {
        String userId = request.getParameter("userID").strip();
        Profile profile = DBManager.getProfile(userId);
        JSONObject jObj = convertProfileToJsonObject(profile);
        try(PrintWriter out = new PrintWriter(response.getOutputStream())) {
            out.println(jObj.toJSONString());
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private JSONObject convertProfileToJsonObject(Profile profile) {
        JSONObject jObj = new JSONObject();
        jObj.put("userID", profile.getUser_id());
        jObj.put("name", profile.getName());
        jObj.put("emailAddress", profile.getEmailAddress());
        jObj.put("age", profile.getAge());
        jObj.put("homeTown", profile.getHomeTown());
        jObj.put("picture", profile.getPictureLocationOnDisk());
        return jObj;
    }

    private void getAllWithQuery(HttpServletRequest request, HttpServletResponse response){
        String imageName = request.getParameter("imageName").strip();
        String nameToSearch = request.getParameter("nameToSearch").strip();
        String email = request.getParameter("email").strip();
        String age = request.getParameter("age").strip();
        String homeTown = request.getParameter("homeTown").strip();
        String sqlQuery = "SELECT * FROM `profile`";
        if(!(imageName.equals("") && nameToSearch.equals("") && email.equals("") && age.equals("") && homeTown.equals(""))){
            sqlQuery += " WHERE ";
            String queryParams = "";
            if(!nameToSearch.equals("")){
                queryParams += " `name` LIKE '"+nameToSearch+"%'";
            }
            if(!email.equals("")){
                if(!queryParams.equals(""))
                    queryParams += " AND ";
                queryParams += " `email_address` LIKE '"+email+"%'";
            }
            if(!age.equals("")){
                if(!queryParams.equals(""))
                    queryParams += " AND ";
                queryParams += " `age` LIKE '"+age+"%'";
            }
            if(!homeTown.equals("")){
                if(!queryParams.equals(""))
                    queryParams += " AND ";
                queryParams += " `home_town` LIKE '"+homeTown+"%'";
            }
            sqlQuery += queryParams;
        }

        List<Profile> profileList = DBManager.getAllProfilesWithQuery(sqlQuery);

        JSONArray jsonProfiles = new JSONArray();
        for (Profile profile : profileList) {
            JSONObject jObj = convertProfileToJsonObject(profile);
            jsonProfiles.add(jObj);
        }
        System.out.println(jsonProfiles.toJSONString());
        try(PrintWriter out = new PrintWriter(response.getOutputStream())) {
            out.println(jsonProfiles.toJSONString());
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
