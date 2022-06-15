package market.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonObject;

@Controller
@RequestMapping("/market")
public class CkeditorFileUploadController {

	@RequestMapping(value="/fileUpload.do", method=RequestMethod.POST)
	@ResponseBody
	public String fileUpload(HttpServletRequest req, HttpServletResponse resp,
							 MultipartHttpServletRequest multiFile) throws Exception {
		JsonObject json = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		BufferedOutputStream bos = null;

		
		MultipartFile file = multiFile.getFile("upload");
		System.out.println(file);
		if(file != null){
			if(file.getSize() > 0 ){
				if(file.getContentType().toLowerCase().startsWith("image/")){
					try{
						String fileName = file.getOriginalFilename();
						String ext = FilenameUtils.getExtension(fileName);

						byte[] bytes = file.getBytes();
						String uploadPath = req.getSession().getServletContext().getRealPath("/upload/ckeditor");
						System.out.println(uploadPath);
						File uploadFile = new File(uploadPath);
						if(!uploadFile.exists()){
							uploadFile.mkdirs();
						}
						fileName = UUID.randomUUID() + "." + ext;
						uploadPath = uploadPath + "/" + fileName;
						System.out.println(uploadPath);
						out = new FileOutputStream(new File(uploadPath));
//						out.write(bytes);
						bos = new BufferedOutputStream(out); // Buffer 에 넣기 때문에 남아있는 메모리 사이즈는 신경써야 하죠.
						bos.write(bytes, 0, bytes.length); // Buffer 에 담은 것을 파일에 I/O 합니다.
						bos.flush(); // FileOutputStream 에는 flush 가 없지요. flush 를 해야지 메모리에 남기지 않고 몽땅 파일에 저장해요.

						printWriter = resp.getWriter();
						resp.setContentType("text/html");
						String fileUrl = req.getContextPath() + "/upload/ckeditor/" + fileName;

						// json 데이터로 등록
						// {"uploaded" : 1, "fileName" : "test.jpg", "url" : "/img/test.jpg"}
						// 이런 형태로 리턴이 나가야함.
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);

						printWriter.println(json);
					}catch(IOException e){
						e.printStackTrace();
					}finally{
						if(bos != null){
							bos.close();
						}
						if(out != null){
							out.close();
						}
						if(printWriter != null){
							printWriter.close();
						}
					}
				}
			}
		}
		return null;
	}
	
	@RequestMapping(value="/reviewFileUpload.do", method=RequestMethod.POST)
	@ResponseBody
	public String reviewFileUpload(HttpServletRequest req, HttpServletResponse resp,
							 MultipartHttpServletRequest multiFile) throws Exception {
		
		JsonObject json = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		BufferedOutputStream bos = null;

		
		MultipartFile file = multiFile.getFile("upload");
		System.out.println(file);
		if(file != null){
			if(file.getSize() > 0 ){
				if(file.getContentType().toLowerCase().startsWith("image/")){
					try{
						String fileName = file.getOriginalFilename();
						String ext = FilenameUtils.getExtension(fileName);

						byte[] bytes = file.getBytes();
						String uploadPath = req.getSession().getServletContext().getRealPath("/upload/review");
						System.out.println(uploadPath);
						File uploadFile = new File(uploadPath);
						if(!uploadFile.exists()){
							uploadFile.mkdirs();
						}
						fileName = UUID.randomUUID() + "." + ext;
						uploadPath = uploadPath + "/" + fileName;
						System.out.println(uploadPath);
						out = new FileOutputStream(new File(uploadPath));
//						out.write(bytes);
						bos = new BufferedOutputStream(out); // Buffer 에 넣기 때문에 남아있는 메모리 사이즈는 신경써야 하죠.
						bos.write(bytes, 0, bytes.length); // Buffer 에 담은 것을 파일에 I/O 합니다.
						bos.flush(); // FileOutputStream 에는 flush 가 없지요. flush 를 해야지 메모리에 남기지 않고 몽땅 파일에 저장해요.

						printWriter = resp.getWriter();
						resp.setContentType("text/html");
						String fileUrl = req.getContextPath() + "/upload/review/" + fileName;

						// json 데이터로 등록
						// {"uploaded" : 1, "fileName" : "test.jpg", "url" : "/img/test.jpg"}
						// 이런 형태로 리턴이 나가야함.
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);

						printWriter.println(json);
					}catch(IOException e){
						e.printStackTrace();
					}finally{
						if(bos != null){
							bos.close();
						}
						if(out != null){
							out.close();
						}
						if(printWriter != null){
							printWriter.close();
						}
					}
				}
			}
		}
		return null;
	}

}