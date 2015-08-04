package org.dp.excel2db;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class SaveData2DB {

	@SuppressWarnings({ "rawtypes" })
	public void save() throws IOException, SQLException {
		ReadExcel xlsMain = new ReadExcel();
		Member member = null;
		List<Member> list = xlsMain.readXls();

		for (int i = 0; i < list.size(); i++) {
			member = list.get(i);
			List l = DbUtil.selectOne(Common.SELECT_MEMBER_SQL + "'%" + member.getMember_number() + "%'", member);
			if (!l.contains(1)) {
				DbUtil.insert(Common.INSERT_MEMBER_SQL, member);
			} else {
				System.out.println("The Record was Exist : member_number = " + member.getMember_number() + " , member_name = " +  member.getMember_name() + ", and has been throw away!");
			}
		}
	}
}
