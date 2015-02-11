package uploader;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for uploading your image to server. Apache commons library utilised.
 */
public class Uploader extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // providing upload page with empty attributes
        request.getSession().setAttribute("uploadResultMsg", "");
        request.getSession().setAttribute("uploadFileName", null);

        // check that submitted form has binary data
        if(!ServletFileUpload.isMultipartContent(request)){
            request.getSession().setAttribute("uploadResultMsg", "Nothing uploaded");
            return;
        }

        FileItemFactory itemFactory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(itemFactory);

        try{
            List<FileItem> items = upload.parseRequest(request);

            for(FileItem item : items){
                String contentType = item.getContentType();

                // only png images accepted
                if(!contentType.equals("image/png")){
                    request.getSession().setAttribute("uploadResultMsg", "Only png image files are supported.");
                    request.getRequestDispatcher("/upload.jsp").forward(request, response);
                    return;
                }

                File uploadDir =  new File("c:\\UploadedImages"); // choose any upload folder on your machine
                File file = File.createTempFile("img", ".png", uploadDir);
                item.write(file);

                String uploadFileName = file.getName();

                request.getSession().setAttribute("uploadFileName", uploadFileName);
                request.getSession().setAttribute("uploadResultMsg", "Your image was successfully uploaded!");
            }
        }
        catch(FileUploadException e){
            request.setAttribute("uploadResultMsg", "Upload failed");
        }
        catch(Exception e){
            request.setAttribute("uploadResultMsg", "Can't save file");
        }

        request.getRequestDispatcher("/upload.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // providing upload page with empty attributes
        request.getSession().setAttribute("uploadResultMsg", "");
        request.getSession().setAttribute("uploadFileName", null);

        request.getRequestDispatcher("/upload.jsp").forward(request, response);

    }
}
