package study2.photoView;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import study2.StudyInterface;

public class photoViewOkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/photoView");
		int maxSize = 1024 * 1024 * 20;	// 서버에 저장할 최대용량을 20MByte로 한다.(1회 저장)
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		// 업로드된 파일의 정보를 추출해보자...
		String fName = request.getParameter("fName");
		String originalFileName = multipartRequest.getOriginalFileName("fName");  // 업로드 시킬때의 업로드 파일명이다.
		String filesystemName = multipartRequest.getFilesystemName("fName");			// 실제 서버에 저장된 파일명.
		
		System.out.println("원본 파일명 : " + fName);  // (X)업로드 시킬때의 업로드 파일명이다.
		System.out.println("원본 파일명 : " + originalFileName);  // (O)업로드 시킬때의 업로드 파일명이다.
		System.out.println("파일이 저장될 서버의 실제경로명 : " + realPath);
		System.out.println("서버에 저장되는 실제파일명 : " + filesystemName);
		
		request.setAttribute("msg", "photoViewOk");
		request.setAttribute("url", request.getContextPath()+"/photoView.st");
	}

}
