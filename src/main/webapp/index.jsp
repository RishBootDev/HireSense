<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%=application.getAttribute("appName") %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link href="css/style.css" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --primary-dark: #4f46e5;
            --secondary: #8b5cf6;
            --accent: #ec4899;
            --dark: #0f172a;
            --dark-light: #1e293b;
            --text-muted: #94a3b8;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: var(--dark);
            color: #fff;
            overflow-x: hidden;
        }

        /* Hero Section with Advanced Animations */
        .hero {
            position: relative;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #0f172a 100%);
            padding: 4rem 2rem;
        }

        .hero::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(99, 102, 241, 0.2) 0%, transparent 70%);
            animation: pulse 15s ease-in-out infinite;
            top: -50%;
            left: -50%;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1) rotate(0deg); opacity: 0.5; }
            50% { transform: scale(1.3) rotate(180deg); opacity: 0.8; }
        }

        .floating-shapes {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 1;
            pointer-events: none;
        }

        .shape {
            position: absolute;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.7;
            animation: float 25s infinite ease-in-out;
        }

        .shape-1 {
            width: 600px;
            height: 600px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            top: -10%;
            left: -15%;
            animation-delay: 0s;
        }

        .shape-2 {
            width: 500px;
            height: 500px;
            background: linear-gradient(135deg, var(--secondary), var(--accent));
            bottom: -10%;
            right: -15%;
            animation-delay: 8s;
        }

        .shape-3 {
            width: 400px;
            height: 400px;
            background: linear-gradient(135deg, var(--accent), var(--primary));
            top: 40%;
            right: 15%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% {
                transform: translate(0, 0) scale(1) rotate(0deg);
            }
            25% {
                transform: translate(60px, -60px) scale(1.15) rotate(90deg);
            }
            50% {
                transform: translate(-40px, 60px) scale(0.85) rotate(180deg);
            }
            75% {
                transform: translate(50px, 40px) scale(1.1) rotate(270deg);
            }
        }

        .hero h1 {
            position: relative;
            z-index: 2;
            font-size: clamp(2.5rem, 8vw, 6rem);
            font-weight: 900;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, #ffffff 0%, #c7d2fe 50%, #a5b4fc 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: fadeInUp 1s ease-out, glow 3s ease-in-out infinite;
            line-height: 1.1;
            text-align: center;
            letter-spacing: -0.02em;
        }

        @keyframes glow {
            0%, 100% {
                filter: drop-shadow(0 0 20px rgba(99, 102, 241, 0.3));
            }
            50% {
                filter: drop-shadow(0 0 40px rgba(99, 102, 241, 0.6));
            }
        }

        .hero p {
            position: relative;
            z-index: 2;
            font-size: clamp(1.1rem, 2.5vw, 1.5rem);
            color: var(--text-muted);
            margin-bottom: 3rem;
            animation: fadeInUp 1s ease-out 0.2s both;
            max-width: 750px;
            text-align: center;
            line-height: 1.8;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .btn-cta {
            position: relative;
            z-index: 2;
            padding: 1.2rem 3rem;
            font-size: 1.2rem;
            font-weight: 700;
            border: none;
            border-radius: 16px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 15px 40px rgba(99, 102, 241, 0.4), 0 5px 15px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            text-decoration: none;
            display: inline-block;
            animation: fadeInUp 1s ease-out 0.4s both, float-btn 3s ease-in-out infinite;
            letter-spacing: 0.5px;
        }

        @keyframes float-btn {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-5px); }
        }

        .btn-cta::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s;
        }

        .btn-cta:hover::before {
            left: 100%;
        }

        .btn-cta:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 50px rgba(99, 102, 241, 0.5), 0 10px 25px rgba(0, 0, 0, 0.4);
            color: white;
        }

        .btn-cta:active {
            transform: translateY(-2px) scale(1.02);
        }

        /* Stats Section */
        .stats-section {
            padding: 5rem 2rem;
            background: linear-gradient(180deg, var(--dark) 0%, var(--dark-light) 100%);
            position: relative;
            z-index: 2;
            border-top: 1px solid rgba(99, 102, 241, 0.2);
        }

        .stats-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--primary), transparent);
        }

        .stat-item {
            text-align: center;
            padding: 2rem;
            transition: transform 0.3s ease;
        }

        .stat-item:hover {
            transform: translateY(-10px);
        }

        .stat-number {
            font-size: clamp(3rem, 6vw, 4.5rem);
            font-weight: 900;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: block;
            margin-bottom: 0.5rem;
            animation: countUp 2s ease-out;
        }

        @keyframes countUp {
            from { opacity: 0; transform: scale(0.5); }
            to { opacity: 1; transform: scale(1); }
        }

        .stat-label {
            color: var(--text-muted);
            font-size: clamp(1rem, 2vw, 1.3rem);
            font-weight: 500;
            letter-spacing: 0.5px;
        }

        /* Features Section */
        .container.py-5 {
            background: var(--dark-light);
            position: relative;
            z-index: 2;
            padding: 6rem 2rem !important;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.04);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 24px;
            padding: 3rem;
            height: 100%;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.15), rgba(139, 92, 246, 0.15));
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .feature-card::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(99, 102, 241, 0.1) 0%, transparent 70%);
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .feature-card:hover::before,
        .feature-card:hover::after {
            opacity: 1;
        }

        .feature-card:hover {
            transform: translateY(-15px) scale(1.02);
            border-color: rgba(99, 102, 241, 0.6);
            box-shadow: 0 25px 70px rgba(99, 102, 241, 0.3), 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        .feature-icon {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            display: inline-block;
            animation: bounce 2s infinite;
            filter: drop-shadow(0 5px 15px rgba(99, 102, 241, 0.4));
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }

        .feature-card:hover .feature-icon {
            animation: spin-scale 0.7s ease;
        }

        @keyframes spin-scale {
            0% { transform: rotate(0deg) scale(1); }
            50% { transform: rotate(180deg) scale(1.2); }
            100% { transform: rotate(360deg) scale(1); }
        }

        .feature-card h4 {
            font-size: clamp(1.3rem, 2.5vw, 1.7rem);
            font-weight: 800;
            margin-bottom: 1.2rem;
            color: #fff;
            position: relative;
            z-index: 1;
            letter-spacing: -0.01em;
        }

        .feature-card p {
            color: var(--text-muted);
            font-size: clamp(0.95rem, 1.8vw, 1.1rem);
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero {
                min-height: 85vh;
                padding: 3rem 1.5rem;
            }

            .stats-section {
                padding: 3rem 1rem;
            }

            .container.py-5 {
                padding: 4rem 1rem !important;
            }

            .feature-card {
                padding: 2rem;
                margin-bottom: 2rem;
            }

            .shape {
                filter: blur(60px);
            }
        }

        /* Scroll Reveal Animation */
        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .row > div {
            animation: slideInUp 0.8s ease-out;
        }

        .row > div:nth-child(1) {
            animation-delay: 0.1s;
        }

        .row > div:nth-child(2) {
            animation-delay: 0.2s;
        }

        .row > div:nth-child(3) {
            animation-delay: 0.3s;
        }
    </style>
</head>
<body>
<%@ include file="includes/header.jsp" %>

<!--front content start-->
<main>
    <div class="hero">
        <div class="floating-shapes">
            <div class="shape shape-1"></div>
            <div class="shape shape-2"></div>
            <div class="shape shape-3"></div>
        </div>
        <h1>Get Hired Smarter with AI</h1>
        <p>
            AI-powered resume analysis and smart job matching in one platform.
        </p>
        <a href="login.jsp" class="btn btn-cta mt-4">Get started</a>
    </div>

    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="stat-item">
                        <span class="stat-number">50K+</span>
                        <span class="stat-label">Resumes Analyzed</span>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-item">
                        <span class="stat-number">95%</span>
                        <span class="stat-label">Match Accuracy</span>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-item">
                        <span class="stat-number">10K+</span>
                        <span class="stat-label">Jobs Posted</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!--feature content start-->
    <div class="container py-5">
        <div class="row text-center">

            <div class="col-md-4 mb-4">
                <div class="feature-card">
                    <div class="feature-icon">🧠</div>
                    <h4>AI Resume Insights</h4>
                    <p>
                        Let our AI analyze your resume and extract deep insights like
                        skills, experience, and summary.
                    </p>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="feature-card">
                    <div class="feature-icon">🎯</div>
                    <h4>Smart Job Matching</h4>
                    <p>Get matched with perfect job opportunities using our intelligent algorithm that understands your skills, experience, and career goals.</p>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="feature-card">
                    <div class="feature-icon">⚡</div>
                    <h4>Instant Application</h4>
                    <p>Apply to multiple jobs with a single click. Our platform streamlines the application process, saving you time and effort.</p>
                </div>
            </div>

        </div>
    </div>
    <!--feature content end-->
</main>
<!--front content end-->

<%@ include file="includes/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>