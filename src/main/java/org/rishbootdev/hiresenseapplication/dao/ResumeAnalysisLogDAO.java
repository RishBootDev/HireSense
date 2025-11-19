package org.rishbootdev.hiresenseapplication.dao;

import org.rishbootdev.hiresenseapplication.dbutils.DBConnection;
import org.rishbootdev.hiresenseapplication.pojo.ResumeAnalysisLogsPojo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class ResumeAnalysisLogDAO {
	public static void saveLog(int userId, String resultJson) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBConnection.getConnection();
			ps = conn.prepareStatement("Insert into resume_analysis_logs(user_id,result_json)values(?,?)");
			ps.setInt(1, userId);
			ps.setString(2, resultJson);
			ps.executeUpdate();
		} finally {
			if (ps != null)
				ps.close();

		}
	}

	public static List<ResumeAnalysisLogsPojo> getLogsByUser(int userId) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			List<ResumeAnalysisLogsPojo> list = new ArrayList<>();
			conn = DBConnection.getConnection();
			ps = conn.prepareStatement("Select * from resume_analysis_logs  where user_id=? order by created_at DESC");
			ps.setInt(1, userId);
			rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new ResumeAnalysisLogsPojo(rs.getInt("id"), rs.getInt("user_id"), rs.getString("result_json"),
						rs.getString("created_at")));
			}
			return list;
		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();

		}
	}
}
