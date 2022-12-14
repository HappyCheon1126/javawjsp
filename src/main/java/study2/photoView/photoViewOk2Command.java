package study2.photoView;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import study2.StudyInterface;

public class photoViewOk2Command implements StudyInterface {

	@SuppressWarnings("rawtypes")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/photoView");
		int maxSize = 1024 * 1024 * 20;	// 서버에 저장할 최대용량을 20MByte로 한다.(1회 저장)
		String encoding = "UTF-8";
		
		// 파일 업로드..처리...끝
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		Enumeration fileNames = multipartRequest.getFileNames();
		String file = "";
		String originalFileName = "";
		String filesystemName = "";
		
		while(fileNames.hasMoreElements()) {
			file = (String) fileNames.nextElement();			// 업로드시의 폼태그안의 필드네임(name)
			originalFileName = multipartRequest.getOriginalFileName(file);
			filesystemName = multipartRequest.getFilesystemName(file);
			System.out.println("업로드시의 원본 파일명 : " + originalFileName);
			System.out.println("서버에 저장된 실제 파일명 : " + filesystemName);
		}
				
		
		if(filesystemName.equals("")) {
			request.setAttribute("msg", "photoViewNo");
		}
		else {
			request.setAttribute("msg", "photoViewOk");
		}
		request.setAttribute("url", request.getContextPath()+"/photoView2.st");
	}

}
