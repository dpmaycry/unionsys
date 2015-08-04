package org.dp.excel2db;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ReadExcel {

	public List<String> errorList=new ArrayList<String>();
	
	@SuppressWarnings("rawtypes")
	public List<Member> readXls() throws IOException, SQLException {
		InputStream is = new FileInputStream(Common.EXCEL_PATH);
		boolean isExcel2003 = true;  
		  
        if (Common.EXCEL_PATH.matches("^.+\\.(?i)(xlsx)$"))  
        {  
            isExcel2003 = false;  
        } 
        List<Member> member;
        if (isExcel2003)  
        {
             member = readXlsHSSF(is);
        }  
        else  
        {  
        	member = readXlsXSSF(is);
        } 
		return member;
	}
	
	public List<Member> readXlsHSSF(InputStream is) throws IOException, SQLException {
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
		Member member = null;
		List<Member> list = new ArrayList<Member>();
		for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
			HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
			if (hssfSheet == null) {
				continue;
			}
			for (int rowNum = 0; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
				HSSFRow hssfRow = hssfSheet.getRow(rowNum);
				if (hssfRow != null) {
					if(!getValueHSSF(hssfRow.getCell(0)).matches("^[0-9]*$")){
						continue;
					}
					member = new Member();
					
					HSSFCell member_number = hssfRow.getCell(0);
					HSSFCell member_name = hssfRow.getCell(1);
					HSSFCell department = hssfRow.getCell(2);
					HSSFCell gender = hssfRow.getCell(3);
					HSSFCell nation = hssfRow.getCell(4);
					HSSFCell dues = hssfRow.getCell(5);
					HSSFCell join_date = hssfRow.getCell(6);
					HSSFCell WeChat = hssfRow.getCell(7);
					
					String member_number1 = getValueHSSF(member_number);
					String member_name1 = getValueHSSF(member_name);
					String department1 = getValueHSSF(department);
					String gender1 = getValueHSSF(gender);
					String nation1 = getValueHSSF(nation);					
					String dues1 = getValueHSSF(dues);
					String join_date1 = getValueHSSF(join_date);
					String WeChat1 = getValueHSSF(WeChat);

					boolean insertFlag = true;
					String errorFields = "";
					 if(!member_number1.matches("^[0-9]+$")){
						 errorFields += " 工号 ";
						 insertFlag = false;						 
					 }
						 
					 if(!member_name1.matches("^[\u4e00-\u9fa5]+$")){
						 errorFields += " 姓名 ";
						 insertFlag = false;
					 }
						
					 if(!department1.matches("^[0-9]+-[0-9]+$")){
						 errorFields += " 部门 ";
						 insertFlag = false;
					 }
						 
					 if(!gender1.matches("[男]|[女]")){
						 errorFields += " 性别 ";
						 insertFlag = false;
					 }
						 
					 if(!nation1.matches("^[\u4e00-\u9fa5]+$")){
						 errorFields += " 民族 ";
						 insertFlag = false;
					 }
						 
					 if(!dues1.matches("^[0-9]+$")){
						 errorFields += " 会费 ";
						 insertFlag = false;
					 }
					 
					 if(!join_date1.matches("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")){
						 errorFields += " 入会时间 ";
						 insertFlag = false;
					 }
					 String errorMessage = "";
					 int numSheetReal = numSheet + 1;
					 int rowNumReal = rowNum + 1;
					 if(insertFlag){						
						member.setMember_number(member_number1);
						member.setMember_name(member_name1);
						member.setDepartment(department1);
						member.setGender(gender1);
						member.setNation(nation1);						
						member.setDues(Integer.valueOf(Math.round(Float.valueOf(dues1))));						
						member.setJoin_date(join_date1);					
						member.setWeChat(WeChat1);
						List l = DbUtil.selectOne(Common.SELECT_MEMBER_SQL + member.getMember_number(), member);
						if(l.contains(1)){
							errorMessage = "工作表 " + numSheetReal + " 行 " + rowNumReal + " 插入失败： 工号为 " + member_number1 + " 的记录已存在！";
							errorList.add(errorMessage);
						}else{
							list.add(member);
						}						
					}else{
						errorMessage = "工作表 " + numSheetReal + " 行 " + rowNumReal + " 插入失败： " + errorFields + "错误！";
						errorList.add(errorMessage);	
					}				
				}
			}
		}
		return list;		
	}
	public List<Member> readXlsXSSF(InputStream is) throws IOException, SQLException {
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(is);
		Member member = null;
		List<Member> list = new ArrayList<Member>();
		for (int numSheet = 0; numSheet < xssfWorkbook.getNumberOfSheets(); numSheet++) {
			XSSFSheet hssfSheet = xssfWorkbook.getSheetAt(numSheet);
			if (hssfSheet == null) {
				continue;
			}
			for (int rowNum = 0; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
				XSSFRow xssfRow = hssfSheet.getRow(rowNum);
				if (xssfRow != null) {
					if(!getValueXSSF(xssfRow.getCell(0)).matches("^[0-9]*$")){
						continue;
					}
					member = new Member();
					
					XSSFCell member_number = xssfRow.getCell(0);
					XSSFCell member_name = xssfRow.getCell(1);
					XSSFCell department = xssfRow.getCell(2);
					XSSFCell gender = xssfRow.getCell(3);
					XSSFCell nation = xssfRow.getCell(4);
					XSSFCell dues = xssfRow.getCell(5);
					XSSFCell join_date = xssfRow.getCell(6);
					XSSFCell WeChat = xssfRow.getCell(7);

					String member_number1 = getValueXSSF(member_number);
					String member_name1 = getValueXSSF(member_name);
					String department1 = getValueXSSF(department);
					String gender1 = getValueXSSF(gender);
					String nation1 = getValueXSSF(nation);					
					String dues1 = getValueXSSF(dues);
					String join_date1 = getValueXSSF(join_date);
					String WeChat1 = getValueXSSF(WeChat);

					boolean insertFlag = true;
					String errorFields = "";
					 if(!member_number1.matches("^[0-9]+$")){
						 errorFields += " 工号 ";
						 insertFlag = false;						 
					 }
						 
					 if(!member_name1.matches("^[\u4e00-\u9fa5]+$")){
						 errorFields += " 姓名 ";
						 insertFlag = false;
					 }
						
					 if(!department1.matches("^[0-9]+-[0-9]+$")){
						 errorFields += " 部门 ";
						 insertFlag = false;
					 }
						 
					 if(!gender1.matches("[男]|[女]")){
						 errorFields += " 性别 ";
						 insertFlag = false;
					 }
						 
					 if(!nation1.matches("^[\u4e00-\u9fa5]+$")){
						 errorFields += " 民族 ";
						 insertFlag = false;
					 }
						 
					 if(!dues1.matches("^[0-9]+$")){
						 errorFields += " 会费 ";
						 insertFlag = false;
					 }
					 
					 if(!join_date1.matches("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")){
						 errorFields += " 入会时间 ";
						 insertFlag = false;
					 }
					 String errorMessage = "";
					 int numSheetReal = numSheet + 1;
					 int rowNumReal = rowNum + 1;
					 if(insertFlag){						
						member.setMember_number(member_number1);
						member.setMember_name(member_name1);
						member.setDepartment(department1);
						member.setGender(gender1);
						member.setNation(nation1);						
						member.setDues(Integer.valueOf(Math.round(Float.valueOf(dues1))));						
						member.setJoin_date(join_date1);					
						member.setWeChat(WeChat1);
						List l = DbUtil.selectOne(Common.SELECT_MEMBER_SQL + member.getMember_number(), member);
						if(l.contains(1)){
							errorMessage = "工作表 " + numSheetReal + " 行 " + rowNumReal + " 插入失败： 工号为 " + member_number1 + " 的记录已存在！";
							errorList.add(errorMessage);
						}else{
							list.add(member);
						}						
					}else{
						errorMessage = "工作表 " + numSheetReal + " 行 " + rowNumReal + " 插入失败： " + errorFields + "错误！";
						errorList.add(errorMessage);	
					}				
				}
			}
		}
		return list;		
	}
	 @SuppressWarnings("static-access")
	private String getValueHSSF(HSSFCell hssfCell) {
		 if(hssfCell == null){
			 return "";
		 }
		 hssfCell.setCellType(Cell.CELL_TYPE_STRING);
		 return String.valueOf(hssfCell.getStringCellValue());  
	 }
	 private String getValueXSSF(XSSFCell hssfCell) {
		 if(hssfCell == null){
			 return "";
		 }
		 hssfCell.setCellType(Cell.CELL_TYPE_STRING);
		 return String.valueOf(hssfCell.getStringCellValue());  
	 }
	 
	 public List<String> geterrprList(){
		 return errorList;
	 }	 
}
