package controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

/**
 * Servlet makes proper forward to necessary jsp pages. Parameter to jsp page mapping made in a HashMap.
 */
public class Controller extends HttpServlet {
    private HashMap<String, String> forwardMap = new HashMap<String, String>();

    public Controller() {
        forwardMap.put("home", "/gallery.jsp");

        forwardMap.put("image", "/image.jsp");
        forwardMap.put("rate", "/image.jsp");

        forwardMap.put("game", "/game.jsp");
        forwardMap.put("playMore", "/game.jsp");

        forwardMap.put("upload", "/upload.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doForward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doForward(request, response);
    }

    private void doForward(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if(action == null || !forwardMap.containsKey(action)){
            action = "home";
        }

        request.getRequestDispatcher(forwardMap.get(action)).forward(request, response);
    }
}
