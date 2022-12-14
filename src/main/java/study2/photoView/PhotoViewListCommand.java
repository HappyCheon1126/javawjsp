package study2.photoView;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyInterface;

public class PhotoViewListCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/photoView");
		
		String[] files = new File(realPath).list();
		
		for(String file : files) {
			System.out.println("file : " + file);
		}
		
		StringBuffer res = new StringBuffer();
		res.append("{\"res\":[");
		for(int i=0; i<files.length; i++) {
			//res.append("[{\"value\":\""+files[i]+"\"}]");
			res.append("{\"value\":\""+files[i]+"\"}");
			if(i != (files.length-1)) res.append(",");
		}
		res.append("]}");
		response.getWriter().write(res.toString());
	}

}
