package org.rishbootdev.hiresenseapplication.dao;

import org.rishbootdev.hiresenseapplication.dbutils.DBConnection;
import org.rishbootdev.hiresenseapplication.pojo.JobPojo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class JobDao {

	public static boolean postJob(JobPojo job) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		boolean result = false;
		try {
			conn = DBConnection.getConnection();
			ps = conn.prepareStatement(
					"Insert into jobs(title,description,skills,company,location,experience,package_lpa,vacancies,employer_id) values(?,?,?,?,?,?,?,?,?)");
			ps.setString(1, job.getTitle());
			ps.setString(2, job.getDescription());
			ps.setString(3, job.getSkills());
			ps.setString(4, job.getCompany());
			ps.setString(5, job.getLocation());
			ps.setString(6, job.getExperience());
			ps.setString(7, job.getPackageLpa());
			ps.setInt(8, job.getVacancies());
			ps.setInt(9, job.getEmployerId());
			result = ps.executeUpdate() > 0;

		} finally {
			if (ps != null)
				ps.close();
			return result;
		}
	}

	public static JobPojo getJobById(int jobId) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		JobPojo job = null;

		try {
			conn = DBConnection.getConnection();
			ps = conn.prepareStatement("Select * from jobs where id=?");
			ps.setInt(1, jobId);
			rs = ps.executeQuery();

			if (rs.next()) {
				job = new JobPojo();
				job.setId(rs.getInt("id"));
				job.setTitle(rs.getString("title"));
				job.setDescription(rs.getString("description"));
				job.setSkills(rs.getString("skills"));
				job.setCompany(rs.getString("company"));
				job.setLocation(rs.getString("location"));
				job.setExperience(rs.getString("experience"));
				job.setPackageLpa(rs.getString("package_lpa"));
				job.setVacancies(rs.getInt("vacancies"));
				job.setEmployerId(rs.getInt("employer_id"));
				job.setCreatedAt(rs.getTimestamp("created_at"));
				job.setStatus(rs.getString("status"));
			}

		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			return job;
		}
	}

	public static List<JobPojo> getJobsByEmployer(int employerId, String search, String status, String sort)
			throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<JobPojo> list = new ArrayList<>();

		try {
			conn = DBConnection.getConnection();

			StringBuilder sql = new StringBuilder(
					"SELECT j.*, (SELECT COUNT(*) FROM applications a WHERE a.job_id = j.id) AS applicant_count "
							+ "FROM jobs j WHERE j.employer_id = ?");

			List<Object> params = new ArrayList<>();
			params.add(employerId); // First parameter is always employerId

			// Add search condition if the search term is provided
			if (search != null && !search.trim().isEmpty()) {
				sql.append(" AND j.title LIKE ?");
				params.add("%" + search + "%");
			}

			if (status != null && !status.trim().isEmpty()) {
				sql.append(" AND j.status = ?");
				params.add(status);
			}

			if ("asc".equalsIgnoreCase(sort)) {
				sql.append(" ORDER BY applicant_count ASC");
			} else if ("desc".equalsIgnoreCase(sort)) {
				sql.append(" ORDER BY applicant_count DESC");
			} else {
				sql.append(" ORDER BY j.created_at DESC");
			}

			ps = conn.prepareStatement(sql.toString());
			for (int i = 0; i < params.size(); i++) {
				ps.setObject(i + 1, params.get(i));
			}

			rs = ps.executeQuery();
			while (rs.next()) {
				JobPojo job = new JobPojo();
				job.setId(rs.getInt("id"));
				job.setTitle(rs.getString("title"));
				job.setDescription(rs.getString("description"));
				job.setSkills(rs.getString("skills"));
				job.setCompany(rs.getString("company"));
				job.setLocation(rs.getString("location"));
				job.setExperience(rs.getString("experience"));
				job.setPackageLpa(rs.getString("package_lpa"));
				job.setVacancies(rs.getInt("vacancies"));
				job.setEmployerId(rs.getInt("employer_id"));
				job.setCreatedAt(rs.getTimestamp("created_at"));
				job.setStatus(rs.getString("status"));
				job.setApplicantCount(rs.getInt("applicant_count"));
				list.add(job); // Add job to the list
			}


		} finally {
			// Clean up resources to avoid memory leaks
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			return list;
		}
	}

	public static void toggleJobStatus(int jobId) throws Exception {

		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBConnection.getConnection();
			ps = conn.prepareStatement(
					"Update jobs set status=CASE WHEN status='active' THEN 'inactive' ELSE 'active' END Where id=?");
			ps.setInt(1, jobId);
			ps.executeUpdate();
		} finally {
			if (ps != null)
				ps.close();

		}
	}

	public static boolean deleteJob(int jobId) throws Exception {
		Connection conn = null;
		PreparedStatement ps1 = null, ps2 = null;
		int rowsEffected = 0;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			ps1 = conn.prepareStatement("Delete from applications where job_id=?");
			ps1.setInt(1, jobId);
			ps1.executeUpdate();

			ps2 = conn.prepareStatement("Delete from jobs where id=?");
			ps2.setInt(1, jobId);
			rowsEffected = ps2.executeUpdate();
			conn.commit();

		} finally {
			if (ps1 != null)
				ps1.close();
			if (ps2 != null)
				ps2.close();
			return rowsEffected > 0;

		}
	}

	public static List<JobPojo> getAllJobsForUserDashboard(String search, String sort, String location,
			String experience, String packageLpa) throws Exception {

		List<JobPojo> jobs = new ArrayList<>();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// Step 1: Establish DB connection
			Connection conn = DBConnection.getConnection();

			// Step 2: Build base SQL query to fetch active jobs and applicant count
			StringBuilder sql = new StringBuilder(
					"SELECT j.*, " + "(SELECT COUNT(*) FROM applications a WHERE a.job_id = j.id) AS applicant_count "
							+ "FROM jobs j WHERE j.status = 'active'");

			List<Object> params = new ArrayList<>();

			// Step 3: Add optional filters based on provided parameters

			if (search != null && !search.trim().isEmpty()) {
				sql.append(" AND (j.title LIKE ? OR j.company LIKE ?)");
				String keyword = "%" + search.trim() + "%";
				params.add(keyword);
				params.add(keyword);
			}

			if (location != null && !location.trim().isEmpty()) {
				sql.append(" AND j.location LIKE ?");
				params.add("%" + location.trim() + "%");
			}

			if (experience != null && !experience.trim().isEmpty()) {
				sql.append(" AND j.experience = ?");
				params.add(experience.trim());
			}

			if (packageLpa != null && !packageLpa.trim().isEmpty()) {
				sql.append(" AND j.package_lpa = ?");
				params.add(packageLpa.trim());
			}

			// Step 4: Add sorting logic
			if ("asc".equalsIgnoreCase(sort)) {
				sql.append(" ORDER BY j.vacancies ASC");
			} else if ("desc".equalsIgnoreCase(sort)) {
				sql.append(" ORDER BY j.vacancies DESC");
			} else {
				sql.append(" ORDER BY j.created_at DESC"); // Default: latest first
			}

			// Step 5: Prepare and execute SQL statement
			ps = conn.prepareStatement(sql.toString());
			for (int i = 0; i < params.size(); i++) {
				ps.setObject(i + 1, params.get(i));
			}

			rs = ps.executeQuery();

			// Step 6: Parse result set into JobPojo list
			while (rs.next()) {
				JobPojo job = new JobPojo();
				job.setId(rs.getInt("id"));
				job.setTitle(rs.getString("title"));
				job.setDescription(rs.getString("description"));
				job.setSkills(rs.getString("skills"));
				job.setCompany(rs.getString("company"));
				job.setVacancies(rs.getInt("vacancies"));
				job.setEmployerId(rs.getInt("employer_id"));
				job.setCreatedAt(rs.getTimestamp("created_at"));
				job.setStatus(rs.getString("status"));
				job.setLocation(rs.getString("location"));
				job.setExperience(rs.getString("experience"));
				job.setPackageLpa(rs.getString("package_lpa"));
				job.setApplicantCount(rs.getInt("applicant_count"));
				jobs.add(job);

                System.out.println(job);
			}

			return jobs;

		} finally {
			// Step 7: Close resources
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
		}
	}

	public static List<JobPojo>getAllJobsWithEmployerAndApplicantCount() throws Exception{
	   Connection conn=null;
	   PreparedStatement ps=null;
	   ResultSet rs=null;
	   List<JobPojo>jobList=new ArrayList<>();
	   try {
		conn = DBConnection.getConnection();
		String sql = new String(
							"SELECT j.*, " + "(SELECT COUNT(*) FROM applications a WHERE a.job_id = j.id) AS applicant_count "
									+ "FROM jobs j ");
		ps=conn.prepareStatement(sql);
		rs=ps.executeQuery();
		while(rs.next()) {
			JobPojo job = new JobPojo();
			job.setId(rs.getInt("id"));
			job.setTitle(rs.getString("title"));
			job.setCompany(rs.getString("company"));
			job.setEmployerId(rs.getInt("employer_id"));
			job.setCreatedAt(rs.getTimestamp("created_at"));
			job.setStatus(rs.getString("status"));
			job.setLocation(rs.getString("location"));
			job.setExperience(rs.getString("experience"));
			job.setPackageLpa(rs.getString("package_lpa"));
			job.setApplicantCount(rs.getInt("applicant_count"));
			jobList.add(job);
		}
		return jobList;
	   }finally {
			
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
		}
   }
}
