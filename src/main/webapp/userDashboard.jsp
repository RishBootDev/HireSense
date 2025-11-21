<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Set"%>
<%@ page import="org.rishbootdev.hiresenseapplication.pojo.JobPojo"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard | <%=application.getAttribute("appName")%></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <!-- Source doc: /mnt/data/27-HireSense_userDashboard.jsp_file.docx -->

    <style>
        .card:hover {
            transform: translateY(-5px);
            transition: 0.3s;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .match-score {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background: #0d6efd;
            color: white;
            font-size: 12px;
            padding: 3px 8px;
            border-radius: 10px;
        }
    </style>
</head>

<body>

<%@ include file="includes/header.jsp"%>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<main class="container py-5">

    <h2 class="mb-4">Welcome, <%=session.getAttribute("userName")%> 👋</h2>

    <!-- Filters -->
    <form method="get" action="UserDashboardServlet">
        <div class="row g-3 mb-4">

            <div class="col-md-3">
                <input type="text" name="search" class="form-control"
                       placeholder="Search by title or company..."
                       value="${param.search}">
            </div>

            <div class="col-md-2">
                <input type="text" name="location" class="form-control"
                       placeholder="Location" value="${param.location}">
            </div>

            <div class="col-md-2">
                <select name="experience" class="form-select">
                    <option value="">Any Experience</option>
                    <option value="Fresher" ${param.experience=='Fresher'?'selected':''}>Fresher</option>
                    <option value="0 - 1 year" ${param.experience=='0 - 1 year'?'selected':''}>0 - 1 year</option>
                    <option value="1 - 2 years" ${param.experience=='1 - 2 years'?'selected':''}>1 - 2 years</option>
                    <option value="2 - 3 years" ${param.experience=='2 - 3 years'?'selected':''}>2 - 3 years</option>
                    <option value="3 - 5 years" ${param.experience=='3 - 5 years'?'selected':''}>3 - 5 years</option>
                    <option value="5+ years"  ${param.experience=='5+ years'?'selected':''}>5+ years</option>
                </select>
            </div>

            <div class="col-md-2">
                <select name="packageLpa" class="form-select">
                    <option value="">Any Package</option>
                    <option value="1-2 Lacs P.A." ${param.packageLpa=='1-2 Lacs P.A.'?'selected':''}>1-2 LPA</option>
                    <option value="2-3 Lacs P.A." ${param.packageLpa=='2-3 Lacs P.A.'?'selected':''}>2-3 LPA</option>
                    <option value="3-4 Lacs P.A." ${param.packageLpa=='3-4 Lacs P.A.'?'selected':''}>3-4 LPA</option>
                    <option value="4-5 Lacs P.A." ${param.packageLpa=='4-5 Lacs P.A.'?'selected':''}>4-5 LPA</option>
                    <option value="5+ Lacs P.A." ${param.packageLpa=='5+ Lacs P.A.'?'selected':''}>5+ LPA</option>
                    <option value="Not disclosed" ${param.packageLpa=='Not disclosed'?'selected':''}>Not disclosed</option>
                </select>
            </div>

            <div class="col-md-1">
                <select name="sort" class="form-select">
                    <option value="">Sort</option>
                    <option value="asc"  ${param.sort=='asc'?'selected':''}>Fewest</option>
                    <option value="desc" ${param.sort=='desc'?'selected':''}>Most</option>
                </select>
            </div>

            <div class="col-md-1">
                <button type="submit" class="btn btn-primary">Go</button>
            </div>

        </div>
    </form>

    <!-- Job Cards -->
    <div class="row g-4">

        <%
            List<JobPojo> jobs = (List<JobPojo>) request.getAttribute("jobs");
            Set<Integer> appliedJobIds = (Set<Integer>) request.getAttribute("appliedJobIds");
            Boolean resumeUploadedAttr = (Boolean) request.getAttribute("resumeUploaded");

            if (jobs != null && !jobs.isEmpty()) {
                for (JobPojo job : jobs) {

                    // escape values for safe insertion into data-* attributes:
                    String escTitle = job.getTitle() != null ? job.getTitle().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("\r"," ").replace("\n"," ") : "";
                    String escCompany = job.getCompany() != null ? job.getCompany().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("\r"," ").replace("\n"," ") : "";
                    String escLocation = job.getLocation() != null ? job.getLocation().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("\r"," ").replace("\n"," ") : "";
                    String escExperience = job.getExperience() != null ? job.getExperience().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("\r"," ").replace("\n"," ") : "";
                    String escPackage = job.getPackageLpa() != null ? job.getPackageLpa().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("\r"," ").replace("\n"," ") : "";
                    String escSkills = job.getSkills() != null ? job.getSkills().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("\r"," ").replace("\n"," ") : "";
                    String escDescription = job.getDescription() != null ? job.getDescription().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("\r"," ").replace("\n"," ") : "";
                    String postedDate = job.getCreatedAt() != null ? new java.text.SimpleDateFormat("dd MMM yyyy").format(job.getCreatedAt()) : "";
        %>

        <div class="col-md-6 col-lg-4">
            <div class="card shadow-sm border rounded-4 p-3 h-100 position-relative">

                <span class="position-absolute top-0 end-0 px-2 py-1 small text-muted">
                    <%= job.getCreatedAt() != null ? new java.text.SimpleDateFormat("d MMM").format(job.getCreatedAt()) : "" %>
                </span>

                <% if (resumeUploadedAttr != null && resumeUploadedAttr) { %>
                <div class="match-score">Match: <%=job.getScore()%>%</div>
                <% } %>

                <div class="card-body">
                    <h5 class="fw-bold mb-1"><%=job.getTitle()%></h5>
                    <p class="text-muted mb-2"><%=job.getCompany()%></p>

                    <div class="d-flex flex-wrap text-muted small mb-2 gap-3">
                        <span><i class="bi bi-briefcase-fill me-1"></i> <%=job.getExperience()%></span>
                        <span><i class="bi bi-currency-rupee me-1"></i> <%=job.getPackageLpa()%></span>
                        <span><i class="bi bi-geo-alt-fill me-1"></i> <%=job.getLocation()%></span>
                        <span><i class="bi bi-people-fill me-1"></i> <%=job.getVacancies()%> Openings</span>
                    </div>

                    <% if (appliedJobIds != null && appliedJobIds.contains(job.getId())) { %>

                    <span class="badge bg-success">✔ Applied</span>

                    <% } else { %>

                    <button type="button"
                            class="btn btn-outline-primary btn-sm mt-2"
                            data-jobid="<%=job.getId()%>"
                            data-score="<%=job.getScore()%>"
                            data-skills="<%=escSkills%>"
                            onclick="openResumePopup(this.dataset.jobid ? this.dataset.jobid.trim() : '', this.dataset.score ? this.dataset.score.trim() : '', this.dataset.skills)">
                        Apply Now
                    </button>


                    <button type="button"
                            class="btn btn-outline-secondary btn-sm mt-2 ms-2"
                            data-id="<%=job.getId()%>"
                            data-title="<%=escTitle%>"
                            data-company="<%=escCompany%>"
                            data-location="<%=escLocation%>"
                            data-experience="<%=escExperience%>"
                            data-package="<%=escPackage%>"
                            data-vacancies="<%=job.getVacancies()%>"
                            data-skills="<%=escSkills%>"
                            data-description="<%=escDescription%>"
                            data-posted="<%=postedDate%>"
                            onclick="showDetailsFromButton(this)">
                        View Details
                    </button>

                    <% } %>

                </div>
            </div>
        </div>

        <%  }
        } else { %>

        <p class="text-danger text-center">No jobs found.</p>

        <% } %>

    </div>

</main>

<!-- Job Details Modal -->
<div class="modal fade" id="jobDetailsModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content bg-white text-dark">

            <div class="modal-header">
                <h5 class="modal-title fw-bold" id="modalJobTitle">Job Title</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <p><strong>Company:</strong> <span id="modalCompany"></span></p>
                <p><strong>Location:</strong> <span id="modalLocation"></span></p>
                <p><strong>Experience:</strong> <span id="modalExperience"></span></p>
                <p><strong>Package:</strong> <span id="modalPackage"></span></p>
                <p><strong>Vacancies:</strong> <span id="modalVacancies"></span></p>
                <p><strong>Skills:</strong> <span id="modalSkills"></span></p>
                <p><strong>Description:</strong> <span id="modalDescription"></span></p>
                <p><strong>Posted On:</strong> <span id="modalPostedDate"></span></p>
            </div>

        </div>
    </div>
</div>

<!-- Resume Upload Modal -->
<div class="modal fade" id="resumeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">

        <form id="resumeForm" method="post" enctype="multipart/form-data"
              action="UploadResumeServlet" class="modal-content bg-dark text-white">

            <div class="modal-header">
                <h5 class="modal-title">📄 Upload Resume</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <input type="hidden" name="jobId" id="modalJobId">
                <input type="hidden" name="skills" id="modalSkillsHidden">

                <label class="form-label">Upload Resume (PDF)</label>
                <input type="file" name="resume" id="resumeFile"
                       class="form-control" accept=".pdf" required>
            </div>

            <div class="modal-footer justify-content-between">
                <button type="submit" class="btn btn-success">Continue</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            </div>

        </form>
    </div>
</div>

<%@ include file="includes/footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    // render resumeUploaded as a true/false JS literal (safe)
    const resumeUploaded = <%= (request.getAttribute("resumeUploaded") != null && (Boolean)request.getAttribute("resumeUploaded")) ? "true" : "false" %>;

    // Show success message after apply
    <% if (request.getParameter("applied") != null) { %>
    Swal.fire({
        icon: 'success',
        title: 'Applied Successfully',
        showConfirmButton: false,
        timer: 1500
    });
    <% } %>

    function openResumePopup(jobId, score, skills) {
        // Normalize
        jobId = (jobId || '').toString().trim();
        score = (score || '').toString().trim();
        skills = (skills || '').toString();

        // Debug (comment out in production)
        // console.log("openResumePopup", {jobId, score, skills, resumeUploaded});

        if (resumeUploaded) {
            if (!jobId) {
                Swal.fire({
                    icon: 'error',
                    title: 'Unable to apply',
                    text: 'Job id missing. Please try again.'
                });
                return;
            }

            Swal.fire({
                title: "Apply for this job?",
                icon: "question",
                showCancelButton: true,
                confirmButtonText: "Yes, Apply",
                cancelButtonText: "Cancel"
            }).then(result => {
                if (result.isConfirmed) {
                    // create form + inputs using DOM API (safer than innerHTML)
                    const form = document.createElement("form");
                    form.method = "POST";
                    form.action = "ApplyJobServlet";

                    const inputJob = document.createElement("input");
                    inputJob.type = "hidden";
                    inputJob.name = "jobId";
                    inputJob.value = jobId;
                    form.appendChild(inputJob);

                    const inputScore = document.createElement("input");
                    inputScore.type = "hidden";
                    inputScore.name = "score";
                    inputScore.value = score;
                    form.appendChild(inputScore);

                    document.body.appendChild(form);
                    form.submit();
                }
            });
        } else {
            // open upload modal and set hidden inputs (existing form will submit to UploadResumeServlet)
            document.getElementById("modalJobId").value = jobId;
            document.getElementById("modalSkillsHidden").value = skills;
            document.getElementById("resumeFile").value = "";
            new bootstrap.Modal(document.getElementById("resumeModal")).show();
        }
    }

    function showDetailsFromButton(btn) {
        if (!btn) return;

        const ds = btn.dataset || {};

        document.getElementById("modalJobTitle").innerText = ds.title || '';
        document.getElementById("modalCompany").innerText = ds.company || '';
        document.getElementById("modalLocation").innerText = ds.location || '';
        document.getElementById("modalExperience").innerText = ds.experience || '';
        document.getElementById("modalPackage").innerText = ds.package || '';
        document.getElementById("modalVacancies").innerText = ds.vacancies || '';
        document.getElementById("modalSkills").innerText = ds.skills || '';
        document.getElementById("modalDescription").innerText = ds.description || '';
        document.getElementById("modalPostedDate").innerText = ds.posted || '';

        new bootstrap.Modal(document.getElementById("jobDetailsModal")).show();
    }

</script>

</body>
</html>
