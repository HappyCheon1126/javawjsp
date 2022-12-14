package study2;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PhotoViewDeleteAllCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] delItems = request.getParameter("delItems").split("/");
		
		String realPath = request.getServletContext().getRealPath("/data/photoView/");
    
		String res = "0";
		for(String delItem : delItems) {
			File file = new File(realPath + delItem);
			
			res = "0";
			if(file.exists()) {
				file.delete();
				res = "1";
			}
		}
		
		response.getWriter().write(res);

	}

}
