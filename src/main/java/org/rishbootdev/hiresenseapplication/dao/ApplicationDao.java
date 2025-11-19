package org.rishbootdev.hiresenseapplication.dao;

import org.rishbootdev.hiresenseapplication.dbutils.DBConnection;
import org.rishbootdev.hiresenseapplication.pojo.ApplicationPojo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class ApplicationDao {

	public static boolean apply(ApplicationPojo app) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBConnection.getConnection();
			ps = conn.prepareStatement("insert into applications (user_id,job_id,resume_path,score) values(?,?,?,?)");
			ps.setInt(1, app.getUserId());
			ps.setInt(2, app.getJobId());
			ps.setString(3, app.getResumePath());
			ps.setDouble(4, app.getScore());
			int ans = ps.executeUpdate();
			return ans > 0;

		} finally {
			if (ps != null)
				ps.close();
		}
	}

	public static List<ApplicationPojo> getApplicationsByUser(int userid) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<ApplicationPojo> appList = new ArrayList<>();
		try {
			conn = DBConnection.getConnection();
			ps = conn.prepareStatement("Select * from applications where user_id=?");
			ps.setInt(1, userid);
			rs = ps.executeQuery();
			while (rs.next()) {
				ApplicationPojo app = new ApplicationPojo();
				app.setId(rs.getInt("id"));
				app.setJobId(rs.getInt("job_id"));
				app.setUserId(rs.getInt("user_id"));
				app.setResumePath(rs.getString("resume_path"));
				app.setScore(rs.getDouble("score"));
				app.setStatus(rs.getString("status"));
				app.setAppliedAt(rs.getString("applied_at"));
				appList.add(app);
			}
			return appList;
		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
		}
	}

	public static List<ApplicationPojo> getApplicationsByJobAndStatus(int jobId,String status)throws Exception{
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			List<ApplicationPojo> list=new ArrayList<>();
			conn=DBConnection.getConnection();
			String sql="Select * from applications where job_id=? and status=? ORDER BY score DESC";
			ps.setInt(1, jobId);
			ps.setString(2,status);
			rs=ps.executeQuery();
			while(rs.next()) {
				ApplicationPojo application=new ApplicationPojo(rs.getInt("id"),rs.getInt("user_id"),rs.getInt("job_id"),rs.getString("resume_path"),rs.getFloat("score"),rs.getString("status"),rs.getString("applied_at"));
				list.add(application);
			}
			return list;
			
		}finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
		}
	}
	public static boolean updateApplicationStatus(int appId,String status)throws Exception{
		Connection conn=null;
		PreparedStatement ps=null;
		try {
			conn=DBConnection.getConnection();
			String sql="UPDATE applications SET status=? WHERE id=?";
			ps.setString(1, status);
			ps.setInt(2, appId);
			int rows=ps.executeUpdate();
			return rows>0;
		}finally {
			if (ps != null)
				ps.close();
		}
	}
}
