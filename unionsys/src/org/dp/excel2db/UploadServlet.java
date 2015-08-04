package org.dp.excel2db;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

public class UploadServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {

	private static final long serialVersionUID = 1L;
	File tmpDir = null;
    File saveDir = null;
  public UploadServlet() {
    super();
  }     

  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doPost(request,response);
  }     
  
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try{
    	String path = getServletContext().getRealPath("/");
        String tmpPath = path + "upload";
        String savePath = path + "upload1";
        tmpDir =new File(tmpPath);
        saveDir = new File(savePath);
        if(!tmpDir.isDirectory())
            tmpDir.mkdir();
        if(!saveDir.isDirectory())
            saveDir.mkdir();
        if(ServletFileUpload.isMultipartContent(request)){
          DiskFileItemFactory factory  = new DiskFileItemFactory();
          factory.setRepository(tmpDir);
          factory.setSizeThreshold(1024000);
          ServletFileUpload upload = new ServletFileUpload(factory);
          //sfu.setSizeMax(5000000);
          upload.setSizeMax(10000000);
          FileItemIterator fii = upload.getItemIterator(request);
          while(fii.hasNext()){
            FileItemStream fis = fii.next();
            if(!fis.isFormField() && fis.getName().length()>0){
            	String fileName = fis.getName(); 
            	if(fileName.contains("\\"))
            		fileName = fis.getName().substring(fis.getName().lastIndexOf("\\"));
                BufferedInputStream in = new BufferedInputStream(fis.openStream());
                BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(new File(saveDir+fileName)));
                Streams.copy(in, out, true);
                request.setAttribute("excelFile", saveDir+fileName);
            }
          }
          RequestDispatcher dispatcher = request.getRequestDispatcher("Excel2DBServlet");
          dispatcher.forward(request,response);
        }
    }catch(Exception e){
        e.printStackTrace();
    }
  }           
}