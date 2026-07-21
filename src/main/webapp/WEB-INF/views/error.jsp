<html>
<head>
    <title>Error Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<div class="container">
    <div class="card error-card">
        <h2>${errorTitle}</h2>
        <p>${errorMessage}</p>
        <a class="btn-link" href="${pageContext.request.contextPath}/shopRegistration">Back to Form</a>
    </div>
</div>

</body>
</html>
