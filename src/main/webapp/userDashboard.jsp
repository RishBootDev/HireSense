<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List,java.util.Set,java.text.SimpleDateFormat"%>
<%@ page import="org.rishbootdev.hiresenseapplication.pojo.JobPojo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard|<%=application.getAttribute("appName")%></title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet">
</head>
<body>
	<%@ include file="includes/header.jsp"%>
	<%
	if (session == null || session.getAttribute("userId") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	%>

	<main class="container py-5">
		<h2 class="mb-4">
			Welcome,
			<%=session.getAttribute("userName")%>👋
		</h2>

		<!--filter code start here-->
		<form action="UserDashboardServlet">
			<div class="row g-3 mb-4">
				<div class="col-md-3">
					<input type="text" name="search" class="form-control"
						placeholder="search by title or company" value="${param.search}">
				</div>

				<div class="col-md-2">
					<input type="text" name="location" class="form-control"
						placeholder="location" value="${param.location}">
				</div>

				<div class="col-md-2">
					<select name="experience" class="form-select">
						<option value="" selected disabled>Experience</option>
						<option value="fresher"
							${param.experience=='Fresher'?'selected':'' }>Fresher</option>
						<option value="0-1" ${param.experience=='0-1 year'?'selected':'' }>0-1
							years</option>
						<option value="1-2"
							${param.experience=='1-2 years'?'selected':'' }>1-2
							years</option>
						<option value="2-3"
							${param.experience=='2-3 years'?'selected':'' }>2-3
							years</option>
						<option value="3-5"
							${param.experience=='3-5 years'?'selected':'' }>3-5
							years</option>
						<option value="5+" ${param.experience=='5+ years'?'selected':'' }>5+
							years</option>
					</select>
				</div>

				<div class="col-md-2">
					<select name="packaageLpa" class="form-select">
						<option value="" selected disabled>Package (LPA)</option>
						<option value="1-2 Lacs P.A."
							${param.packageLpa=='1-2 Lacs P.A.'?'selected':'' }>1-2
							LPA</option>
						<option value="2-3 Lacs P.A."
							${param.packageLpa=='2-3 Lacs P.A.'?'selected':'' }>2-3
							LPA</option>
						<option value="3-4 Lacs P.A."
							${param.packageLpa=='3-4 Lacs P.A.'?'selected':'' }>3-4
							LPA</option>
						<option value="4-5 Lacs P.A."
							${param.packageLpa=='4-5 Lacs P.A.'?'selected':'' }>4-5
							LPA</option>
						<option value="5+ Lacs P.A."
							${param.packageLpa=='5+ Lacs P.A.'?'selected':'' }>5+
							LPA</option>
						<option value="not-disclosed"
							${param.packageLpa=='Not disclosed'?'selected':'' }>Not
							disclosed</option>
					</select>
				</div>

				<div class="col-md-2">
					<select name="sort" class="form-select">
						<option value="">Sort</option>
						<option value="asc" ${param.sort=='asc'?'selected':'' }>Fewest</option>
						<option value="desc" ${param.sort=='desc'?'selected':'' }>Most</option>
					</select>
				</div>

				<div class="col-md-1">
					<button type="submit" class="btn btn-primary">Go</button>
				</div>
			</div>
		</form>
		<!--filter code ends here-->

		<!--job card start-->
		<%
		List<JobPojo> jobs = (List<JobPojo>) request.getAttribute("jobs");
		Set<Integer> appliedJobIds = (Set<Integer>) request.getAttribute("appliedJobIds");
		Boolean resumeUploaded = (Boolean) request.getAttribute("resumeUploaded");
		if (jobs != null && !jobs.isEmpty()) {
			for (JobPojo job : jobs) {
		%>
		<div class="col-md-4">
			<div class="card p-3 position-relative">
				<span class="position-absolute top-0 end-0 px-2 py-1 small">
					<%=job.getCreatedAt() != null ? new SimpleDateFormat("d MMM").format(job.getCreatedAt()) : ""%>
				</span>
				<%
				if (resumeUploaded) {
				%>
				<div class="match-score">
					Match:<%=job.getScore()%></div>
				<%
				}
				%>


				<div class="card-body">
					<h5 class="mb-1"><%=job.getTitle()%></h5>
					<p class="text-muted"><%=job.getCompany()%></p>

					<div class="d-flex flex-wrap text-muted small mb-2 gap-3">
						<div>
							<i class="bi bi-briefcase-fill me-1"></i><%=job.getExperience()%>
						</div>
						<div>
							<i class="bi bi-currency-dollar me-1"></i><%=job.getPackageLpa()%>
						</div>
						<div>
							<i class="bi bi-geo-alt-fill me-1"></i><%=job.getLocation()%>
						</div>
						<div>
							<i class="bi bi-people-fill me-1"><%=job.getVacancies()%>
								Openings</i>
						</div>
						<%
						if (appliedJobIds.contains(job.getId())) {
						%>
						<span class="badge bg-success">Applied</span>
						<%
						} else {
						%>
						<button type="button" class="btn btn-outline-primary btn-sm mt-2"
							data-bs-toggle="modal" data-bs-target="#uploadresume"
							onclick="openResumePopup(<%=job.getId()%>, <%=job.getScore()%>, '<%=job.getSkills().replace("'", "\\'")%>">Apply
							Now</button>
						<button type="button"
							class="btn btn-outline-secondary btn-sm mt-2 ms-2"
							onclick='showDetails(<%=job.getId()%>,"<%=job.getTitle().replace("\"", "&quot;")%>", " <%=job.getCompany().replace("\"", "&quot;")%>", "<%=job.getLocation().replace("\"", "&quot;")%>", "<%=job.getExperience().replace("\"", "&quot;")%>", "<%=job.getPackageLpa().replace("\"", "&quot;")%>", "<%=job.getVacancies()%>", "<%=job.getSkills().replace("\"", "&quot;")%>", "<%=job.getDescription().replace("\"", "&quot;")%>", "<%=new java.text.SimpleDateFormat("dd MMM yyyy").format(job.getCreatedAt())%>")'>
							View Details</button>

						<%
						}
						%>
					</div>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<p class="text-danger text-center">No jobs found</p>
			<%
			}
			%>
		</div>
		<div class="modal fade" id="jobDetailsModal" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-lg">
				<div class="modal-content bg-white text-dark">
					<div class="modal-header">
						<h5 class="modal-title fw-bold" id="modalJobTitle">Job Title</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<p>
							<strong>Company:</strong> <span id="modalCompany"></span>
						</p>
						<p>
							<strong>Location:</strong> <span id="modalLocation"></span>
						</p>
						<p>
							<strong>Experience:</strong> <span id="modalExperience"></span>
						</p>
						<p>
							<strong>Package:</strong> <span id="modalPackage"></span>
						</p>
						<p>
							<strong>Vacancies:</strong> <span id="modalVacancies"></span>
						</p>
						<p>
							<strong>Skills:</strong> <span id="modalSkills"></span>
						</p>
						<p>
							<strong>Description:</strong> <span id="modalDescription"></span>
						</p>
						<p>
							<strong>Posted On:</strong> <span id="modalPostedDate"></span>
						</p>
					</div>
				</div>
			</div>
		</div>

		<!--job card end-->

		<!--upload resume popup code-->
		<div class="modal fade" id="uploadresume">
			<div class="modal-dialog modal-dialog-centered modal-lg">
				<form action="#" method="post"
					class="modal-content bg-dark text-white">
					<div class="modal-header">
						<h5>Upload Resume</h5>
						<button type="button" class="btn-close btn-close-white"
							data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" name="jobId" id="modalJobId"> <input
							type="hidden" name="skills" id="modalSkills"> <label
							for="resumeFile" class="form-label">Upload Resume</label> <input
							type="file" name="resume" id="resumeFile" class="form-control"
							accept=".pdf" required>
					</div>
					<div class="modal-footer justify-content-between">
						<button type="submit" class="btn btn-success">Submit
							Resume</button>
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
					</div>
				</form>
			</div>
		</div>
		<!--upload resume popup code end-->

		<!--view details code-->
		<div class="modal fade" id="jobDetails">
			<div class="modal-dialog modal-dialog-centered modal-lg">
				<form action="#" method="post" class="modal-content bg-white ">
					<div class="modal-header">
						<h5 class="fw-bold" id="modalJobTitle">Software developer</h5>
						<button type="button" class="btn-close " data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<p>
							<strong>Company :</strong> <span id="modalCompany">A2infotech
								Pvt Ltd</span>
						</p>
						<p>
							<strong>Location :</strong> <span id="modalLocation">Delhi</span>
						</p>
						<p>
							<strong>Experience :</strong> <span id="modalExperience">2-3
								years</span>
						</p>
						<p>
							<strong>Package :</strong> <span id="modalPackage">3-4 LPA</span>
						</p>
						<p>
							<strong>Vacancies :</strong> <span id="modalVacancies">6</span>
						</p>
						<p>
							<strong>Skills :</strong> <span id="modalSkills">Java,HTML,CSS</span>
						</p>
						<p>
							<strong>Job Description :</strong> <span id="modalDescription">Lorem
								ipsum dolor sit amet consectetur.</span>
						</p>
						<p>
							<strong>Posted Date :</strong> <span id="modalPostedDate">05-Sep-2025</span>
						</p>
					</div>
				</form>
			</div>
		</div>
		<!--view details code end-->
	</main>

	<%@ include file="includes/footer.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous">
	<%if (request.getParameter("applied") != null) {%>
	Swal.fire({icon:'success',title:'Applied Successfully',showConfirmButton:false,timer:1500})
	<%}%>
	function openResumePopup(jobId, score, skills) { 
	   const resumeUploaded =<%=request.getAttribute("resumeUploaded")%>;
	   if (resumeUploaded) { 
	       	Swal.fire({ title: "Apply for this job?", icon:
				"question", showCancelButton: true, confirmButtonText: "Yes, Apply",
				 cancelButtonText: "Cancel" })
				 .then((result) => { 
				 if(result.isConfirmed) { 
				 	const form = document.createElement("form");
				 	form.method = "POST";
				 	form.action = "ApplyJobServlet"; 
				 	const input1 =document.createElement("input"); 
				 	input1.type = "hidden"; 
				 	input1.name ="jobId"; 
				 	input1.value = jobId; 
				 	form.appendChild(input1); 
				 	const input2 =document.createElement("input"); 
				 	input2.type = "hidden"; 
				 	input2.name ="score"; 
				 	input2.value = score; 
				 	form.appendChild(input2);
					document.body.appendChild(form); 
					form.submit(); 
					} 
					}); 
					} else {
						document.getElementById("modalJobId").value = jobId;
						document.getElementById("modalSkills").value = skills;
						document.getElementById("resumeFile").value = ""; new
						bootstrap.Modal(document.getElementById('resumeModal')).show(); 
						} 
					}
	function showDetails(id, title, company, location, experience, packageLpa, vacancies, skills, description, posted) {
		document.getElementById("modalJobTitle").innerText = title;
		document.getElementById("modalCompany").innerText = company;
		document.getElementById("modalLocation").innerText = location;
		document.getElementById("modalExperience").innerText = experience;
		document.getElementById("modalPackage").innerText = packageLpa;
		document.getElementById("modalVacancies").innerText = vacancies;
		document.getElementById("modalSkills").innerText = skills;
		document.getElementById("modalDescription").innerText = description;
		document.getElementById("modalPostedDate").innerText = posted;

		new bootstrap.Modal(document.getElementById('jobDetailsModal')).show();
		}

	</script>
	<!-- Resume Upload Modal -->
	<div class="modal fade" id="resumeModal" tabindex="-1"
		aria-labelledby="resumeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<form id="resumeForm" method="post" enctype="multipart/form-data"
				action="UploadResumeServlet"
				class="modal-content bg-dark text-white">
				<div class="modal-header">
					<h5 class="modal-title" id="resumeModalLabel">📄 Upload Resume</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<input type="hidden" name="jobId" id="modalJobId"> <input
						type="hidden" name="skills" id="modalSkills"> <label
						for="resumeFile" class="form-label">Upload Resume (PDF)</label> <input
						type="file" name="resume" id="resumeFile" class="form-control"
						accept=".pdf" required />
				</div>
				<div class="modal-footer justify-content-between">
					<button type="submit" class="btn btn-success">Continue</button>
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Cancel</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>